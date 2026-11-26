import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/agent/agent_session_store.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:foxy/use_case/agent/agent_chat_use_case.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy/view_model/agent_view_model.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

const _testProvider = AgentProviderConfig(
  baseUrl: 'https://example.test/v1',
  apiKey: 'test-key',
  model: 'test-model',
);

void main() {
  late Directory tempDir;
  late AgentSessionStore store;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('foxy_agent_vm_test');
    store = AgentSessionStore(root: Directory('${tempDir.path}/session'));
  });

  tearDown(() async {
    await store.list();
    await tempDir.delete(recursive: true);
  });

  test('interleaves assistant text and tool calls in model order', () async {
    final chat = _FakeChat();
    final viewModel = _buildViewModel(chat, store);
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();

    viewModel.draftController.init('query');
    await viewModel.send();

    chat.controller.add(const AgentTextDeltaEvent('我先查一下。'));
    chat.controller.add(
      const AgentToolCallEvent(
        callId: 'call_1',
        name: 'query_rows',
        arguments: {'table': 'creature_template'},
      ),
    );
    await pumpEventQueue();
    final tool = viewModel.messages.value.last;
    expect(tool.role, AgentChatRole.tool);
    expect(viewModel.isToolInProgress(tool), isTrue);

    chat.controller.add(
      const AgentToolResultEvent(
        callId: 'call_1',
        name: 'query_rows',
        output: '{"count":2}',
        isError: false,
      ),
    );
    await pumpEventQueue();
    expect(viewModel.isToolInProgress(tool), isFalse);

    chat.controller.add(const AgentTextDeltaEvent('找到 2 条。'));
    chat.controller.add(const AgentCompletedEvent());
    await chat.controller.close();
    await pumpEventQueue();

    final messages = viewModel.messages.value;
    expect(messages.map((message) => message.role), [
      AgentChatRole.user,
      AgentChatRole.assistant,
      AgentChatRole.tool,
      AgentChatRole.assistant,
    ]);
    expect(messages[1].text, '我先查一下。');
    expect(messages[3].text, '找到 2 条。');
    expect(viewModel.running.value, isFalse);
  });

  test('records failures once and replays the run failure after reopening', () async {
    final chat = _FakeChat();
    final viewModel = _buildViewModel(chat, store);
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();
    viewModel.draftController.init('query');
    await viewModel.send();

    chat.controller.add(
      const AgentToolCallEvent(
        callId: 'call_1',
        name: 'query_rows',
        arguments: {},
      ),
    );
    const toolFailure = AgentToolResultEvent(
      callId: 'call_1',
      name: 'query_rows',
      output: '查询超时',
      isError: true,
    );
    chat.controller.add(toolFailure);
    chat.controller.add(toolFailure);
    await pumpEventQueue();

    expect(viewModel.running.value, isTrue);
    expect(viewModel.messages.value.map((message) => message.role), [
      AgentChatRole.user,
      AgentChatRole.tool,
      AgentChatRole.tool,
    ]);
    expect(viewModel.messages.value.last.text, '工具失败：查询超时');

    chat.controller.add(const AgentTextDeltaEvent('已完成部分查询。'));
    chat.controller.add(const AgentFailedEvent('连接中断'));
    await pumpEventQueue();

    expect(viewModel.running.value, isFalse);
    expect(viewModel.messages.value.skip(3).map((message) => message.role), [
      AgentChatRole.assistant,
      AgentChatRole.error,
    ]);

    final requestInput = Completer<Object?>();
    final resumed = _buildViewModel(
      AgentChatUseCase(
        provider: viewModel.provider.value!,
        catalog: const TableCatalog([]),
        dataSource: _FakeDataSource(),
        httpClient: MockClient((request) async {
          requestInput.complete(
            jsonDecode(utf8.decode(request.bodyBytes))['input'],
          );
          return http.Response(
            'data: {"type":"response.completed","response":{"output":[]}}\n\n',
            200,
          );
        }),
      ),
      store,
    );
    addTearDown(resumed.dispose);
    await resumed.initSignals();
    expect(resumed.activeSessionId.value, viewModel.activeSessionId.value);
    expect(
      resumed.messages.value.map((message) => (message.role, message.text)),
      viewModel.messages.value.map((message) => (message.role, message.text)),
    );
    expect(resumed.messages.value.last.text, '本轮未完成：连接中断');

    resumed.draftController.init('接着查');
    await resumed.send();
    expect(await requestInput.future, [
      {'role': 'user', 'content': 'query'},
      {'role': 'assistant', 'content': 'Foxy 运行诊断：本轮未完成：连接中断'},
      {'role': 'user', 'content': '接着查'},
    ]);
    await pumpEventQueue();
  });

  test(
    'keeps the user input when setup fails before calling the provider',
    () async {
      final catalog = Completer<TableCatalog>();
      final viewModel = _buildViewModel(
        _FakeChat(),
        store,
        dataSource: _FakeDataSource(firstCatalog: catalog.future),
      );
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      viewModel.draftController.init('查询');
      final send = viewModel.send();
      catalog.completeError(StateError('catalog failed'));
      await send;

      final restored = (await store.load(viewModel.activeSessionId.value!))!;
      expect(restored.session.items, [
        {'role': 'user', 'content': '查询'},
        {'role': 'assistant', 'content': 'Foxy 运行诊断：本轮未完成：内部状态异常，请重试'},
      ]);
    },
  );

  test(
    'keeps streamed and completed reasoning separate from the answer',
    () async {
      final chat = _FakeChat();
      final viewModel = _buildViewModel(chat, store);
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      viewModel.draftController.init('query');
      await viewModel.send();
      final sessionId = viewModel.activeSessionId.value!;

      chat.controller.add(const AgentReasoningStartedEvent());
      chat.controller.add(const AgentReasoningDeltaEvent('先检查'));
      chat.controller.add(const AgentReasoningDeltaEvent('表结构。'));
      await pumpEventQueue();

      final active = viewModel.messages.value.last;
      expect(active.role, AgentChatRole.reasoning);
      expect(active.text, '先检查表结构。');
      expect(viewModel.isReasoningInProgress(active), isTrue);

      chat.controller.add(const AgentReasoningDoneEvent());
      chat.controller.add(
        const AgentToolCallEvent(
          callId: 'call_1',
          name: 'list_tables',
          arguments: {},
        ),
      );
      chat.controller.add(const AgentTextDeltaEvent('查询完成。'));
      chat.controller.add(const AgentReasoningDoneEvent('已核对查询结果。'));
      chat.controller.add(const AgentCompletedEvent());
      await chat.controller.close();
      await pumpEventQueue();

      expect(viewModel.isReasoningInProgress(active), isFalse);
      final messages = viewModel.messages.value;
      expect(messages.map((message) => message.role), [
        AgentChatRole.user,
        AgentChatRole.reasoning,
        AgentChatRole.tool,
        AgentChatRole.reasoning,
        AgentChatRole.assistant,
      ]);
      expect(messages.map((message) => message.text), [
        'query',
        '先检查表结构。',
        '调用 list_tables',
        '已核对查询结果。',
        '查询完成。',
      ]);

      await store.createSession('after_reasoning');
      final restored = await store.load(sessionId);
      expect(
        restored?.messages.map((message) => message.toJson()),
        messages.map((message) => message.toJson()),
      );
    },
  );

  test('shows a placeholder reply when the run has only tool calls', () async {
    final chat = _FakeChat();
    final viewModel = _buildViewModel(chat, store);
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();

    viewModel.draftController.init('query');
    await viewModel.send();

    chat.controller.add(
      const AgentToolCallEvent(
        callId: 'call_1',
        name: 'list_tables',
        arguments: {},
      ),
    );
    chat.controller.add(
      const AgentToolResultEvent(
        callId: 'call_1',
        name: 'list_tables',
        output: '{}',
        isError: false,
      ),
    );
    chat.controller.add(const AgentCompletedEvent());
    await chat.controller.close();
    await pumpEventQueue();

    final messages = viewModel.messages.value;
    expect(messages.map((message) => message.role), [
      AgentChatRole.user,
      AgentChatRole.tool,
      AgentChatRole.assistant,
    ]);
    expect(messages.last.text, '（无回复）');
    expect(viewModel.running.value, isFalse);
  });

  test('restores persisted sessions on init', () async {
    await store.createSession('s1');
    await store.appendMessage('s1', AgentChatRole.user, '恢复的会话');
    await store.appendItem('s1', {'role': 'user', 'content': '恢复的会话'});

    final chat = _FakeChat();
    final viewModel = _buildViewModel(chat, store);
    addTearDown(viewModel.dispose);

    await viewModel.initSignals();

    expect(viewModel.sessions.value.single.id, 's1');
    expect(viewModel.activeTitle, '恢复的会话');
    expect(viewModel.messages.value.single.text, '恢复的会话');
    expect(viewModel.activeSession?.session.items, hasLength(1));
  });

  test('finishes a background session while another is running', () async {
    final firstChat = _FakeChat();
    final secondChat = _FakeChat();
    final viewModel = _buildViewModel(firstChat, store, nextChat: secondChat);
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();

    viewModel.draftController.init('第一问');
    await viewModel.send();
    final firstSession = viewModel.activeSession!;
    firstChat.controller.add(const AgentReasoningDeltaEvent('第一段推理'));
    await pumpEventQueue();
    final reasoning = viewModel.messages.value.last;

    viewModel.startNewSession();
    expect(viewModel.running.value, isFalse);
    viewModel.draftController.init('第二问');
    await viewModel.send();
    final secondSession = viewModel.activeSession!;
    expect(secondSession.id, isNot(firstSession.id));

    await viewModel.selectSession(firstSession.id);
    expect(viewModel.running.value, isTrue);
    expect(viewModel.isReasoningInProgress(reasoning), isTrue);
    await viewModel.deleteSession(firstSession.id);
    expect(viewModel.sessions.value, hasLength(2));
    await viewModel.selectSession(secondSession.id);

    firstChat.controller.add(const AgentTextDeltaEvent('第一答'));
    firstSession.session.addItems([
      {'role': 'assistant', 'content': '第一答'},
    ]);
    firstChat.controller.add(const AgentCompletedEvent());
    await firstChat.controller.close();
    expect(viewModel.running.value, isTrue);
    expect(viewModel.messages.value.first.text, '第二问');
    expect(firstChat.closeCount, 1);
    expect(secondChat.closeCount, 0);

    secondChat.controller.add(const AgentTextDeltaEvent('第二答'));
    secondSession.session.addItems([
      {'role': 'assistant', 'content': '第二答'},
    ]);
    await secondChat.controller.close();
    expect(viewModel.running.value, isFalse);
    expect(viewModel.messages.value.map((message) => message.text), [
      '第二问',
      '第二答',
    ]);
    expect(secondChat.closeCount, 1);

    final firstSaved = (await store.load(firstSession.id))!;
    final secondSaved = (await store.load(secondSession.id))!;
    expect(firstSaved.messages.map((message) => message.text), [
      '第一问',
      '第一段推理',
      '第一答',
    ]);
    expect(firstSaved.session.items.map((item) => item['content']), [
      '第一问',
      '第一答',
    ]);
    expect(secondSaved.session.items.map((item) => item['content']), [
      '第二问',
      '第二答',
    ]);
  });

  test('stopping a session during startup leaves another run active', () async {
    final firstCatalog = Completer<TableCatalog>();
    final chat = _FakeChat();
    final viewModel = _buildViewModel(
      chat,
      store,
      dataSource: _FakeDataSource(firstCatalog: firstCatalog.future),
    );
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();

    viewModel.draftController.init('要停止的问题');
    final firstSend = viewModel.send();
    final firstId = viewModel.activeSessionId.value!;
    viewModel.startNewSession();
    viewModel.draftController.init('继续的问题');
    await viewModel.send();
    final secondId = viewModel.activeSessionId.value!;
    expect(secondId, isNot(firstId));

    await viewModel.selectSession(firstId);
    viewModel.stop();
    expect(viewModel.running.value, isFalse);
    await viewModel.selectSession(secondId);
    firstCatalog.complete(const TableCatalog([]));
    await firstSend;

    expect(viewModel.running.value, isTrue);
    expect(chat.closeCount, 0);
    chat.controller.add(const AgentTextDeltaEvent('继续的回答'));
    await pumpEventQueue();
    viewModel.stop();
    expect(viewModel.messages.value.last.text, '继续的回答');
    expect(viewModel.running.value, isFalse);
    expect(chat.closeCount, 1);
    await chat.controller.close();
  });

  for (final interrupt in ['stop', 'dispose']) {
    test('reopens and sends after $interrupt during a tool call', () async {
      final tool = _PendingTool();
      const call = {
        'type': 'function_call',
        'call_id': 'call_1',
        'name': 'pending_tool',
        'arguments': '{}',
      };
      final viewModel = _buildViewModel(
        AgentChatUseCase(
          provider: _testProvider,
          catalog: const TableCatalog([]),
          dataSource: _FakeDataSource(),
          featureTool: tool,
          httpClient: MockClient((_) async {
            final event = jsonEncode({
              'type': 'response.completed',
              'response': {
                'output': [call],
              },
            });
            return http.Response('data: $event\n\n', 200);
          }),
        ),
        store,
      );
      if (interrupt == 'stop') addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      viewModel.draftController.init('query');
      await viewModel.send();
      await tool.started.future;
      final original = viewModel.activeSession!;

      if (interrupt == 'stop') {
        viewModel.stop();
      } else {
        viewModel.dispose();
      }
      tool.result.complete('late result');
      await pumpEventQueue();

      final requestInput = Completer<Object?>();
      final reopened = _buildViewModel(
        AgentChatUseCase(
          provider: _testProvider,
          catalog: const TableCatalog([]),
          dataSource: _FakeDataSource(),
          httpClient: MockClient((request) async {
            requestInput.complete(
              jsonDecode(utf8.decode(request.bodyBytes))['input'],
            );
            return http.Response(
              'data: {"type":"response.completed","response":{"output":[]}}\n\n',
              200,
            );
          }),
        ),
        store,
      );
      addTearDown(reopened.dispose);
      await reopened.initSignals();
      expect(reopened.activeSessionId.value, original.id);
      expect(
        reopened.messages.value.map((message) => message.role),
        contains(AgentChatRole.tool),
      );

      reopened.draftController.init('retry');
      await reopened.send();
      const user = {'role': 'user', 'content': 'query'};
      expect(await requestInput.future, [
        user,
        {'role': 'user', 'content': 'retry'},
      ]);
      expect(original.session.items, [user]);
      await pumpEventQueue();
    });
  }

  test(
    'saves a draft only on send and names the originating session',
    () async {
      final chat = _FakeChat();
      final title = Completer<String?>();
      final namingInputs = <(String, String)>[];
      final viewModel = _buildViewModel(
        chat,
        store,
        titleGenerator: (provider, text) {
          namingInputs.add((provider.model, text));
          return title.future;
        },
      );
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      viewModel.startNewSession();
      expect(viewModel.activeSessionId.value, isNull);
      expect(await store.list(), isEmpty);

      viewModel.draftController.init('帮我查询掉落亚麻布的生物');
      await viewModel.send();
      final id = viewModel.activeSessionId.value!;
      expect(
        id,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
      expect(viewModel.activeTitle, '帮我查询掉落亚麻布的生物');
      expect(namingInputs, [('test-model', '帮我查询掉落亚麻布的生物')]);
      expect(viewModel.running.value, isTrue);

      viewModel.startNewSession();
      viewModel.draftController.init('另一个草稿');
      title.complete('亚麻布掉落查询');
      chat.controller.add(const AgentTextDeltaEvent('查询完成。'));
      await chat.controller.close();
      await pumpEventQueue();

      expect(viewModel.activeSessionId.value, isNull);
      expect(viewModel.sessions.value.single.title, '亚麻布掉落查询');
      expect((await store.load(id))!.title, '亚麻布掉落查询');
      expect(viewModel.draftController.collect(), '另一个草稿');
      await viewModel.selectSession(id);
      expect(viewModel.activeTitle, '亚麻布掉落查询');
      expect(viewModel.draftController.collect(), isEmpty);
      viewModel.startNewSession();
      expect(viewModel.draftController.collect(), '另一个草稿');
    },
  );

  test('updates the active model when settings save a new provider', () async {
    final configUseCase = AgentProviderConfigUseCase(_MemoryConfigUtil());
    final viewModel = _buildViewModel(
      _FakeChat(),
      store,
      configUseCase: configUseCase,
    );
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();
    expect(viewModel.provider.value?.model, 'test-model');

    const updated = AgentProviderConfig(
      baseUrl: 'https://example.test/v1',
      apiKey: 'test-key',
      model: 'updated-model',
    );
    await configUseCase.save(updated);

    expect(viewModel.provider.value, same(updated));
    expect(viewModel.sessions.value, isEmpty);
  });
}

AgentViewModel _buildViewModel(
  AgentChatUseCase chat,
  AgentSessionStore store, {
  _FakeChat? nextChat,
  AgentProviderConfigUseCase? configUseCase,
  AgentTitleGenerator? titleGenerator,
  _FakeDataSource? dataSource,
}) {
  final chats = [chat, ?nextChat].iterator;
  return AgentViewModel(
    configUseCase:
        configUseCase ?? AgentProviderConfigUseCase(_MemoryConfigUtil()),
    dataSource: dataSource ?? _FakeDataSource(),
    chatFactory:
        ({
          required AgentProviderConfig provider,
          required TableCatalog catalog,
          required ReadOnlyDataSource dataSource,
        }) {
          expect(chats.moveNext(), isTrue);
          return chats.current;
        },
    titleGenerator: titleGenerator ?? (_, _) async => null,
    sessionStore: store,
  );
}

final class _FakeChat extends AgentChatUseCase {
  final controller = StreamController<AgentEvent>();
  var closeCount = 0;

  _FakeChat()
    : super(
        provider: _testProvider,
        catalog: const TableCatalog([]),
        dataSource: _FakeDataSource(),
      );

  @override
  void close() => closeCount++;

  @override
  Stream<AgentEvent> run(AgentSession session, String message) {
    session.addUserMessage(message);
    return controller.stream;
  }
}

final class _PendingTool extends AgentTool {
  final started = Completer<void>();
  final result = Completer<String>();

  @override
  String get description => 'Waits for a result.';

  @override
  Map<String, Object?> get inputSchema => const {'type': 'object'};

  @override
  String get name => 'pending_tool';

  @override
  Future<String> call(Map<String, Object?> arguments) {
    started.complete();
    return result.future;
  }
}

final class _FakeDataSource extends AgentReadOnlyDataSource {
  Future<TableCatalog>? _firstCatalog;

  _FakeDataSource({this._firstCatalog}) : super(ConfigUtil());

  @override
  Future<TableCatalog> getCatalog({bool refresh = false}) async {
    final firstCatalog = _firstCatalog;
    _firstCatalog = null;
    return firstCatalog == null ? const TableCatalog([]) : await firstCatalog;
  }
}

final class _MemoryConfigUtil extends ConfigUtil {
  final _data = <String, dynamic>{
    'agent_base_url': 'https://example.test/v1',
    'agent_api_key': 'test-key',
    'agent_model': 'test-model',
  };

  @override
  Future<Map<String, dynamic>> load() async => Map.of(_data);

  @override
  Future<void> update(Map<String, dynamic> values) async =>
      _data.addAll(values);
}
