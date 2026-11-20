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
      final sessionId = viewModel.activeSessionId.value!;
      viewModel.draftController.init('query');
      await viewModel.send();

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

  test('updates the active model when settings save a new provider', () async {
    final configUseCase = AgentProviderConfigUseCase(_MemoryConfigUtil());
    final viewModel = _buildViewModel(_FakeChat(), store, configUseCase);
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
    expect(viewModel.sessions.value, hasLength(1));
  });
}

AgentViewModel _buildViewModel(
  _FakeChat chat,
  AgentSessionStore store, [
  AgentProviderConfigUseCase? configUseCase,
]) => AgentViewModel(
  configUseCase:
      configUseCase ?? AgentProviderConfigUseCase(_MemoryConfigUtil()),
  dataSource: _FakeDataSource(),
  chatFactory: ({
    required AgentProviderConfig provider,
    required TableCatalog catalog,
    required ReadOnlyDataSource dataSource,
  }) => chat,
  sessionStore: store,
);

final class _FakeChat extends AgentChatUseCase {
  final controller = StreamController<AgentEvent>();

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
  void close() {}

  @override
  Stream<AgentEvent> run(AgentSession session, String message) =>
      controller.stream;
}

final class _FakeDataSource extends AgentReadOnlyDataSource {
  _FakeDataSource() : super(ConfigUtil());

  @override
  Future<TableCatalog> getCatalog({bool refresh = false}) async =>
      const TableCatalog([]);

  @override
  Future<List<Map<String, Object?>>> queryRows({
    required String table,
    required List<RowFilter> filters,
    required int limit,
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
