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

  testWidgets('推理默认收起，展开时显示流式内容，完成后停止指示器', (tester) async {
    final reasoning = AgentChatMessage(
      role: AgentChatRole.reasoning,
      text: '检查表结构',
    );
    final viewModel = _TestAgentViewModel(ConfigUtil())
      ..activeReasoning = reasoning;
    viewModel.messages.value = [reasoning];
    GetIt.instance.registerSingleton<AgentViewModel>(viewModel);

    await tester.pumpWidget(const ShadApp(home: Scaffold(body: AgentPage())));
    await tester.pump();

    final thinking = find.text('思考中');
    final indicator = find.byType(CircularProgressIndicator);
    final details = find.text('检查表结构', findRichText: true);
    expect(thinking, findsOneWidget);
    expect(indicator, findsOneWidget);
    expect(details, findsNothing);

    await tester.tap(thinking);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(details, findsOneWidget);

    reasoning.text += '，再查找记录';
    viewModel.messages.value = [reasoning];
    await tester.pump();
    final updatedDetails = find.text('检查表结构，再查找记录', findRichText: true);
    expect(updatedDetails, findsOneWidget);

    await tester.tap(thinking);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(updatedDetails, findsNothing);
    expect(indicator, findsOneWidget);

    viewModel.activeReasoning = null;
    viewModel.messages.value = [reasoning];
    await tester.pumpAndSettle();
    expect(indicator, findsNothing);
    final completed = find.text('推理过程');
    expect(completed, findsOneWidget);
    await tester.tap(completed);
    await tester.pumpAndSettle();
    expect(updatedDetails, findsOneWidget);
  });

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
  AgentChatMessage? activeReasoning;

  _TestAgentViewModel(ConfigUtil configUtil)
    : super(
        configUseCase: AgentProviderConfigUseCase(configUtil),
        dataSource: AgentReadOnlyDataSource(configUtil),
        sessionStore: AgentSessionStore(),
      );

  @override
  Future<void> initSignals() async {}

  @override
  bool isReasoningInProgress(AgentChatMessage message) =>
      identical(activeReasoning, message);
}
