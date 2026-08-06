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

/// Rendering behavior of three dynamic integer fields: the sealed spec
/// drives the four existing components, and FoxyIntEnumInput's list icon
/// no longer appears.
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
    // Data4 = trap type (select); value 0 shows "not a bomb trap".
    expect(find.text('陷阱类型'), findsOneWidget);
    expect(find.text('非炸弹陷阱'), findsOneWidget);
    // No legacy list icon anywhere on the page.
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
    // Data0 = lock ID (reference), Data2 = auto-close time (number).
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
    // Value3 = contains bank (select); value 1 shows "Yes"; other selects
    // are 0.
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
    // param6 = alive state (select); value 0 shows "ANY".
    expect(find.text('存活状态'), findsOneWidget);
    expect(find.text('ANY'), findsOneWidget);
    // The event-phase mask and event flags remain FlagPickers.
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
