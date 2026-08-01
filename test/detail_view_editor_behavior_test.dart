import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/page/condition/condition_view.dart';
import 'package:foxy/page/game_object/game_object_template_view.dart';
import 'package:foxy/page/smart_script/smart_script_view.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/condition_detail_view_model.dart';
import 'package:foxy/view_model/game_object_template_detail_view_model.dart';
import 'package:foxy/view_model/smart_script_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 三个动态整数字段的渲染行为：sealed spec 驱动四种既有组件，
/// 不再出现 FoxyIntEnumInput 的 list icon。
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    GetIt.instance.registerSingleton<EventBus>(EventBus(sync: true));
    GetIt.instance.registerSingleton<ActivityLogRepository>(
      _RecordingActivityLogRepository(),
    );
    GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    GetIt.instance.registerSingleton(
      ActivityLogService(_RecordingActivityLogRepository()),
    );
  });

  tearDown(() async => GetIt.instance.reset());

  testWidgets('GameObject 陷阱类型的 Data4 渲染为 ShadSelect，无 list icon', (
    tester,
  ) async {
    GetIt.instance.registerSingleton<GameObjectTemplateRepository>(
      _FakeGameObjectTemplateRepository(),
    );
    final viewModel = GameObjectTemplateDetailViewModel();
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();
    viewModel.typeController.init(6);

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(body: GameObjectTemplateView(viewModel: viewModel)),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    // Data4 = 陷阱类型（select），值为 0 显示「非炸弹陷阱」。
    expect(find.text('陷阱类型'), findsOneWidget);
    expect(find.text('非炸弹陷阱'), findsOneWidget);
    // 整页不存在旧 list icon。
    expect(find.byIcon(LucideIcons.list), findsNothing);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('GameObject 引用与数字分支仍使用 EntityPicker 和 NumberInput', (
    tester,
  ) async {
    GetIt.instance.registerSingleton<GameObjectTemplateRepository>(
      _FakeGameObjectTemplateRepository(),
    );
    final viewModel = GameObjectTemplateDetailViewModel();
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();
    viewModel.typeController.init(6);

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(body: GameObjectTemplateView(viewModel: viewModel)),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    // Data0 = 锁 ID（引用），Data2 = 自动关闭时间（数字）。
    expect(find.text('锁 ID'), findsOneWidget);
    expect(find.bySubtype<FoxyEntityPicker>(), findsWidgets);
    expect(find.byType(FoxyNumberInput<int>), findsWidgets);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('Condition 类型 2 的 Value3 渲染为 ShadSelect', (tester) async {
    GetIt.instance.registerSingleton<ConditionRepository>(
      _FakeConditionRepository(),
    );
    final viewModel = ConditionDetailViewModel();
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();
    viewModel.conditionTypeController.init(2);
    viewModel.conditionValue3Controller.init(1);

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(body: ConditionView(viewModel: viewModel)),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    // Value3 = 包含银行（select），值为 1 显示「是」；其他 select 值为 0。
    expect(find.text('包含银行'), findsOneWidget);
    expect(find.text('是'), findsOneWidget);
    expect(find.byIcon(LucideIcons.list), findsNothing);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('SmartScript 动作 29 的存活状态参数渲染为 ShadSelect', (tester) async {
    GetIt.instance.registerSingleton<SmartScriptRepository>(
      _FakeSmartScriptRepository(),
    );
    final viewModel = SmartScriptDetailViewModel();
    addTearDown(viewModel.dispose);
    await viewModel.initSignals();
    viewModel.actionTypeController.init(29);

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(body: SmartScriptView(viewModel: viewModel)),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    // param6 = 存活状态（select），值为 0 显示「ANY」。
    expect(find.text('存活状态'), findsOneWidget);
    expect(find.text('ANY'), findsOneWidget);
    // 事件阶段掩码与事件标志仍是 FlagPicker。
    expect(find.byType(FoxyFlagPicker), findsWidgets);
    expect(find.byIcon(LucideIcons.list), findsNothing);

    await tester.pumpWidget(const SizedBox());
  });
}

class _FakeConditionRepository extends ConditionRepository {
  @override
  Future<ConditionEntity> createCondition() async => const ConditionEntity();
}

class _FakeGameObjectTemplateRepository extends GameObjectTemplateRepository {
  @override
  Future<GameObjectTemplateEntity> createGameObjectTemplate() async =>
      const GameObjectTemplateEntity();
}

class _FakeSmartScriptRepository extends SmartScriptRepository {
  @override
  Future<SmartScriptEntity> createSmartScript({
    int entryOrGuid = 0,
    int sourceType = 0,
  }) async => const SmartScriptEntity();
}

class _RecordingActivityLogRepository extends ActivityLogRepository {
  @override
  void storeActivityLogBestEffort(ActivityLogEntity log) {}
}
