import 'dart:async';
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/agent/agent_session_store.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:foxy/page/agent/agent_composer.dart';
import 'package:foxy/page/agent/agent_page.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy/view_model/agent_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  tearDown(() async => GetIt.instance.reset());

  testWidgets('恢复历史会话期间不显示空状态', (tester) async {
    final config = _UnconfiguredAgentConfig();
    final store = _PendingAgentSessionStore();
    final viewModel = AgentViewModel(
      configUseCase: AgentProviderConfigUseCase(config),
      dataSource: AgentReadOnlyDataSource(config),
      sessionStore: store,
    );
    GetIt.instance.registerSingleton<AgentViewModel>(viewModel);

    final emptyState = find.text('配置 AI 模型');
    final message = find.text('历史消息');
    await tester.pumpWidget(const ShadApp(home: Scaffold(body: AgentPage())));
    expect(emptyState, findsNothing);

    await tester.pump();
    expect(find.text('已有会话'), findsOneWidget);
    expect(emptyState, findsNothing);
    expect(message, findsNothing);

    final session = AgentChatSession(id: 'existing', title: '已有会话');
    session.messages.add(
      AgentChatMessage(role: AgentChatRole.user, text: '历史消息'),
    );
    store.loaded.complete(session);
    await tester.pumpAndSettle();

    expect(viewModel.activeSessionId.value, 'existing');
    expect(message, findsOneWidget);
    expect(emptyState, findsNothing);

    await tester.tap(find.text('新建会话'));
    await tester.pumpAndSettle();
    expect(emptyState, findsOneWidget);
  });

  testWidgets('输入区支持换行、发送和停止', (tester) async {
    final draft = TextEditingController();
    final focusNode = FocusNode();
    final running = ValueNotifier(false);
    addTearDown(draft.dispose);
    addTearDown(focusNode.dispose);
    addTearDown(running.dispose);
    final sent = <String>[];

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder<bool>(
              valueListenable: running,
              builder: (context, streaming, _) => AgentComposer(
                controller: draft,
                focusNode: focusNode,
                running: streaming,
                configured: true,
                ready: true,
                onSend: () {
                  sent.add(draft.text);
                  draft.clear();
                  running.value = true;
                },
                onStop: () => running.value = false,
                onConfigure: () {},
              ),
            ),
          ),
        ),
      ),
    );

    final input = find.byType(TextField);
    final button = find.byType(IconButton);
    final activeColor = Theme.of(tester.element(button)).colorScheme.onPrimary;
    Color? iconColor(IconData icon) {
      final glyph = find.descendant(
        of: find.byIcon(icon),
        matching: find.byType(RichText),
      );
      return tester.widget<RichText>(glyph).text.style!.color;
    }

    expect(tester.widget<IconButton>(button).onPressed, isNull);
    expect(iconColor(LucideIcons.arrowUp)?.a, closeTo(0.38, 0.01));
    await tester.enterText(input, '第一行');
    await tester.pumpAndSettle();
    expect(iconColor(LucideIcons.arrowUp), activeColor);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    expect(draft.text, '第一行\n');
    expect(sent, isEmpty);

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(sent, ['第一行\n']);
    expect(find.bySemanticsLabel('停止'), findsOneWidget);
    expect(tester.widget<TextField>(input).readOnly, isTrue);
    expect(iconColor(LucideIcons.square), activeColor);

    await tester.tap(button);
    await tester.pumpAndSettle();
    await tester.enterText(input, '再发一条');
    await tester.pumpAndSettle();
    await tester.tap(button);
    expect(sent, ['第一行\n', '再发一条']);
  });

  testWidgets('顶部新建会话入口显示快捷键并聚焦草稿', (tester) async {
    final viewModel = _TestAgentViewModel(ConfigUtil());
    viewModel.activeSessionId.value = 'existing';
    viewModel.sessions.value = [
      AgentChatSessionMeta(
        id: 'existing',
        title: '已有会话',
        updatedAt: DateTime.now(),
      ),
    ];
    GetIt.instance.registerSingleton<AgentViewModel>(viewModel);
    await tester.pumpWidget(
      ShadApp(
        materialThemeBuilder: (_, theme) =>
            theme.copyWith(platform: TargetPlatform.windows),
        home: const Scaffold(body: AgentPage()),
      ),
    );
    await tester.pumpAndSettle();

    final newSession = find.text('新建会话');
    final shortcut = find.text('Ctrl+N');
    final composer = find.byType(TextField);
    expect(
      tester.getTopLeft(newSession).dy,
      lessThan(tester.getTopLeft(find.text('已有会话')).dy),
    );
    expect(shortcut, findsNothing);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: Offset.zero);
    addTearDown(mouse.removePointer);
    await mouse.moveTo(tester.getCenter(newSession));
    await tester.pumpAndSettle();
    expect(shortcut, findsOneWidget);

    await tester.tap(newSession);
    await tester.pumpAndSettle();
    expect(viewModel.activeSessionId.value, isNull);
    expect(viewModel.sessions.value.single.id, 'existing');
    expect(tester.widget<TextField>(composer).focusNode!.hasFocus, isTrue);

    await tester.enterText(composer, '尚未发送的草稿');
    await tester.tap(newSession);
    await tester.pumpAndSettle();
    expect(viewModel.draftController.collect(), '尚未发送的草稿');

    viewModel.activeSessionId.value = 'existing';
    await tester.pump();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyN);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();
    expect(viewModel.activeSessionId.value, isNull);
    expect(tester.widget<TextField>(composer).focusNode!.hasFocus, isTrue);
  });

  testWidgets('悬停时在会话标题行内显示删除图标', (tester) async {
    final viewModel = _TestAgentViewModel(ConfigUtil());
    viewModel.sessions.value = [
      AgentChatSessionMeta(
        id: 'session',
        title: '已有会话',
        updatedAt: DateTime.now(),
      ),
    ];
    GetIt.instance.registerSingleton<AgentViewModel>(viewModel);
    await tester.pumpWidget(
      ShadApp(
        navigatorKey: FoxyRouter.router.navigatorKey,
        home: const Scaffold(body: AgentPage()),
      ),
    );
    await tester.pumpAndSettle();

    final title = find.text('已有会话');
    final trash = find.byIcon(LucideIcons.trash2);
    expect(trash, findsNothing);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: Offset.zero);
    addTearDown(mouse.removePointer);
    await mouse.moveTo(tester.getCenter(title));
    await tester.pumpAndSettle();
    expect(trash, findsOneWidget);
    expect(
      find.descendant(
        of: find.widgetWithText(ShadButton, '已有会话'),
        matching: trash,
      ),
      findsOneWidget,
    );

    await mouse.moveTo(tester.getCenter(trash));
    await tester.pump();
    await tester.tap(trash);
    await tester.pumpAndSettle();
    expect(find.text('删除会话'), findsOneWidget);
    expect(viewModel.activeSessionId.value, isNull);
    await tester.tap(find.text('取消'));
    await tester.pumpAndSettle();

    await mouse.moveTo(Offset.zero);
    await tester.pumpAndSettle();
    expect(trash, findsNothing);
    await tester.tap(title);
    await tester.pumpAndSettle();
    expect(viewModel.activeSessionId.value, 'session');
    expect(find.text('删除会话'), findsNothing);
  });

  testWidgets('翻阅历史时暂停贴底，回到底部后继续跟随', (tester) async {
    final viewModel = _TestAgentViewModel(ConfigUtil());
    viewModel.messages.value = [
      for (var index = 0; index < 30; index++)
        AgentChatMessage(
          role: AgentChatRole.user,
          text: List.filled(index % 4 + 1, '历史消息 $index').join('\n'),
        ),
    ];
    GetIt.instance.registerSingleton<AgentViewModel>(viewModel);
    await tester.pumpWidget(const ShadApp(home: Scaffold(body: AgentPage())));
    await tester.pumpAndSettle();

    final list = find.byWidgetPredicate(
      (widget) => widget is ListView && widget.controller != null,
    );
    final position = tester.widget<ListView>(list).controller!.position;
    expect(position.extentAfter, lessThanOrEqualTo(1));
    await tester.drag(list, const Offset(0, 180));
    await tester.pumpAndSettle();
    final readingOffset = position.pixels;
    final jump = find.bySemanticsLabel('回到底部');
    expect(jump, findsOneWidget);

    viewModel.messages.value = [
      ...viewModel.messages.value,
      AgentChatMessage(role: AgentChatRole.assistant, text: '流式新消息'),
    ];
    await tester.pumpAndSettle();
    expect(position.pixels, closeTo(readingOffset, 1));

    await tester.tap(jump);
    await tester.pumpAndSettle();
    expect(jump, findsNothing);
    expect(position.extentAfter, lessThanOrEqualTo(1));

    viewModel.messages.value = [
      ...viewModel.messages.value,
      AgentChatMessage(role: AgentChatRole.assistant, text: '继续输出'),
    ];
    await tester.pumpAndSettle();
    expect(position.extentAfter, lessThanOrEqualTo(1));
  });

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
    final titleColor = const ShadNeutralColorScheme.light().mutedForeground;
    expect(tester.widget<Text>(thinking).style?.color, titleColor);
    expect(find.byIcon(LucideIcons.chevronDown), findsNothing);
    expect(indicator, findsOneWidget);
    expect(
      find.ancestor(of: thinking, matching: find.byType(ShaderMask)),
      findsOneWidget,
    );
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
    expect(tester.widget<Text>(completed).style?.color, titleColor);
    expect(
      find.ancestor(of: completed, matching: find.byType(ShaderMask)),
      findsNothing,
    );
    await tester.tap(completed);
    await tester.pumpAndSettle();
    expect(updatedDetails, findsOneWidget);
  });

  testWidgets('相邻步骤在组内独立展开，正文切断分组', (tester) async {
    final firstReasoning = AgentChatMessage(
      role: AgentChatRole.reasoning,
      text: '先检查表结构',
    );
    const arguments = '{"query":"creature"}';
    final call = AgentChatMessage(
      role: AgentChatRole.tool,
      text: '调用 list_tables $arguments',
    );
    final nextReasoning = AgentChatMessage(
      role: AgentChatRole.reasoning,
      text: '再核对结果',
    );
    final viewModel = _TestAgentViewModel(ConfigUtil());
    viewModel.messages.value = [firstReasoning];
    GetIt.instance.registerSingleton<AgentViewModel>(viewModel);
    await tester.pumpWidget(const ShadApp(home: Scaffold(body: AgentPage())));

    final firstDetail = find.text(firstReasoning.text, findRichText: true);
    await tester.tap(find.text('推理过程'));
    await tester.pumpAndSettle();
    expect(firstDetail, findsOneWidget);

    viewModel.messages.value = [firstReasoning, call];
    await tester.pumpAndSettle();
    final group = find.text('推理过程 · 工具调用（1 次）');
    final callTitle = find.text('调用 list_tables');
    final callDetail = find.text(arguments);
    expect(group, findsOneWidget);
    expect(firstDetail, findsNothing);
    expect(callTitle, findsNothing);

    await tester.tap(group);
    await tester.pumpAndSettle();
    expect(find.byType(ShadAccordionItem<bool>), findsNWidgets(3));
    expect(firstDetail, findsNothing);
    expect(callDetail, findsNothing);

    await tester.tap(find.text('推理过程'));
    await tester.pumpAndSettle();
    expect(firstDetail, findsOneWidget);
    expect(callDetail, findsNothing);

    await tester.tap(callTitle);
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(firstDetail).dy,
      lessThan(tester.getTopLeft(callDetail).dy),
    );
    await tester.tap(callTitle);
    await tester.pumpAndSettle();
    expect(firstDetail, findsOneWidget);
    expect(callDetail, findsNothing);

    viewModel.activeReasoning = nextReasoning;
    viewModel.messages.value = [firstReasoning, call, nextReasoning];
    await tester.pump();
    expect(find.text('思考中 · 工具调用（1 次）'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(firstDetail, findsOneWidget);
    final nextDetail = find.text(nextReasoning.text, findRichText: true);
    expect(nextDetail, findsNothing);
    await tester.tap(find.text('思考中'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(
      tester.getTopLeft(callTitle).dy,
      lessThan(tester.getTopLeft(nextDetail).dy),
    );

    const separateCall = '调用 query_rows';
    viewModel.activeReasoning = null;
    viewModel.messages.value = [
      ...viewModel.messages.value,
      AgentChatMessage(role: AgentChatRole.assistant, text: '已确认表结构。'),
      AgentChatMessage(role: AgentChatRole.tool, text: separateCall),
    ];
    await tester.pumpAndSettle();
    await tester.tap(group);
    await tester.pumpAndSettle();
    expect(nextDetail, findsNothing);
    expect(find.text(separateCall), findsOneWidget);

    await tester.tap(group);
    await tester.pumpAndSettle();
    expect(firstDetail, findsOneWidget);
    expect(callDetail, findsNothing);
    expect(nextDetail, findsOneWidget);
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
    final failureTitle = find.text('工具失败');
    final groupFailure = find.text('请求超时');
    expect(find.text('调用 inspect_schema'), findsOneWidget);
    expect(find.text('工具失败：缺少列'), findsOneWidget);
    expect(group, findsOneWidget);
    expect(firstCall, findsNothing);
    expect(groupFailure, findsNothing);

    await tester.tap(group);
    await tester.pumpAndSettle();
    expect(firstCall, findsOneWidget);
    expect(secondCall, findsOneWidget);
    expect(failureTitle, findsOneWidget);
    expect(groupFailure, findsNothing);
    await tester.tap(failureTitle);
    await tester.pumpAndSettle();
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

class _PendingAgentSessionStore extends AgentSessionStore {
  final loaded = Completer<AgentChatSession?>();

  @override
  Future<List<AgentChatSessionMeta>> list() async => [
    AgentChatSessionMeta(
      id: 'existing',
      title: '已有会话',
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Future<AgentChatSession?> load(String id) => loaded.future;
}

class _TestAgentViewModel extends AgentViewModel {
  AgentChatMessage? activeReasoning;

  _TestAgentViewModel(ConfigUtil configUtil)
    : super(
        configUseCase: AgentProviderConfigUseCase(configUtil),
        dataSource: AgentReadOnlyDataSource(configUtil),
        sessionStore: AgentSessionStore(),
      ) {
    ready.value = true;
  }

  @override
  Future<void> initSignals() async {}

  @override
  bool isReasoningInProgress(AgentChatMessage message) =>
      identical(activeReasoning, message);

  @override
  Future<void> selectSession(String id) async => activeSessionId.value = id;
}

class _UnconfiguredAgentConfig extends ConfigUtil {
  @override
  Future<Map<String, dynamic>> load() async => {};
}
