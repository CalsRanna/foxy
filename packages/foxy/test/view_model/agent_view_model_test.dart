import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:foxy/use_case/agent/agent_chat_use_case.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy/view_model/agent_view_model.dart';
import 'package:foxy_agent/foxy_agent.dart';

void main() {
  test('interleaves assistant text and tool calls in model order', () async {
    final chat = _FakeChat();
    final viewModel = _buildViewModel(chat);
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
    chat.controller.add(
      const AgentToolResultEvent(
        callId: 'call_1',
        name: 'query_rows',
        output: '{"count":2}',
        isError: false,
      ),
    );
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

  test('shows a placeholder reply when the run has only tool calls', () async {
    final chat = _FakeChat();
    final viewModel = _buildViewModel(chat);
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
}

AgentViewModel _buildViewModel(_FakeChat chat) => AgentViewModel(
  configUseCase: _FakeConfigUseCase(),
  dataSource: _FakeDataSource(),
  chatFactory: ({
    required AgentProviderConfig provider,
    required TableCatalog catalog,
    required ReadOnlyDataSource dataSource,
  }) => chat,
);

final class _FakeConfigUseCase extends AgentProviderConfigUseCase {
  _FakeConfigUseCase() : super(ConfigUtil());

  @override
  Future<AgentProviderConfig?> load() async => const AgentProviderConfig(
    baseUrl: 'https://example.test/v1',
    apiKey: 'test-key',
    model: 'test-model',
  );

  @override
  Future<void> save(AgentProviderConfig provider) async {}
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

final class _FakeChat extends AgentChatUseCase {
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

  final controller = StreamController<AgentEvent>();

  @override
  Stream<AgentEvent> run(AgentSession session, String message) =>
      controller.stream;

  @override
  void close() {}
}
