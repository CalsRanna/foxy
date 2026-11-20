import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/agent/agent_session_store.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:foxy/page/agent/agent_page.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy/view_model/agent_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  tearDown(() async => GetIt.instance.reset());

  testWidgets('连续工具调用可以折叠，流式追加时保留展开状态', (tester) async {
    AgentChatMessage tool(String text) =>
        AgentChatMessage(role: AgentChatRole.tool, text: text);

    final viewModel = _TestAgentViewModel(ConfigUtil());
    viewModel.messages.value = [
      tool('调用 inspect_schema'),
      tool('工具失败：缺少列'),
      AgentChatMessage(role: AgentChatRole.assistant, text: '继续检查'),
      tool('调用 list_tables'),
      tool('调用 query_rows'),
      tool('工具失败：请求超时'),
    ];
    GetIt.instance.registerSingleton<AgentViewModel>(viewModel);

    await tester.pumpWidget(const ShadApp(home: Scaffold(body: AgentPage())));
    await tester.pumpAndSettle();

    final group = find.text('工具调用（2 次，1 次失败）');
    final firstCall = find.text('调用 list_tables');
    final secondCall = find.text('调用 query_rows');
    final groupFailure = find.text('工具失败：请求超时');
    expect(find.text('调用 inspect_schema'), findsOneWidget);
    expect(find.text('工具失败：缺少列'), findsOneWidget);
    expect(group, findsOneWidget);
    expect(firstCall, findsNothing);
    expect(groupFailure, findsNothing);

    await tester.tap(group);
    await tester.pumpAndSettle();
    expect(firstCall, findsOneWidget);
    expect(secondCall, findsOneWidget);
    expect(groupFailure, findsOneWidget);
    expect(
      tester.getTopLeft(firstCall).dy,
      lessThan(tester.getTopLeft(secondCall).dy),
    );

    final thirdCall = tool('调用 describe_table');
    viewModel.messages.value = [...viewModel.messages.value, thirdCall];
    await tester.pumpAndSettle();

    final updatedGroup = find.text('工具调用（3 次，1 次失败）');
    expect(updatedGroup, findsOneWidget);
    expect(find.text(thirdCall.text), findsOneWidget);

    await tester.tap(updatedGroup);
    await tester.pumpAndSettle();
    expect(firstCall, findsNothing);
    expect(groupFailure, findsNothing);
    expect(find.text(thirdCall.text), findsNothing);
  });
}

class _TestAgentViewModel extends AgentViewModel {
  _TestAgentViewModel(ConfigUtil configUtil)
    : super(
        configUseCase: AgentProviderConfigUseCase(configUtil),
        dataSource: AgentReadOnlyDataSource(configUtil),
        sessionStore: AgentSessionStore(),
      );

  @override
  Future<void> initSignals() async {}
}
