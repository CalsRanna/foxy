import 'dart:async';
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
  _FakeChat chat,
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
        provider: const AgentProviderConfig(
          baseUrl: 'https://example.test/v1',
          apiKey: 'test-key',
          model: 'test-model',
        ),
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

final class _FakeDataSource extends AgentReadOnlyDataSource {
  Future<TableCatalog>? _firstCatalog;

  _FakeDataSource({this._firstCatalog}) : super(ConfigUtil());

  @override
  Future<TableCatalog> getCatalog({bool refresh = false}) async {
    final firstCatalog = _firstCatalog;
    _firstCatalog = null;
    return firstCatalog == null ? const TableCatalog([]) : await firstCatalog;
  }

  @override
  Future<List<Map<String, Object?>>> queryRows({
    required String table,
    required List<RowFilter> filters,
    required int limit,
    List<RowOrder> orderBy = const [],
    int offset = 0,
  }) async => const [];
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
