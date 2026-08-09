import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Regression test: opening the picker dialog renders the table without
/// type errors.
///
/// The old implementation upcast concrete delegates (condition /
/// smart_script / game_object `_delegateFor`) to
/// `FoxyEntityPickerDelegate<Object?>`. Generic covariance does not hold
/// for function fields (`int Function(BriefQuestTemplateEntity)` is not a
/// subtype of `int Function(Object?)`), so `_EntityPickerDialog` threw a
/// TypeError at the `keyOf:` assignment while building the table. Call
/// sites now instantiate the concrete row type directly; this test drives
/// the full render path with the questTemplate delegate.
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
    GetIt.instance.registerSingleton<QuestTemplateRepository>(
      _FakeQuestTemplateRepository(),
    );
  });

  tearDown(() async => GetIt.instance.reset());

  testWidgets('打开选择对话框渲染表格不抛类型错误', (tester) async {
    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: FoxyEntityPicker<BriefQuestTemplateEntity>(
            controller: IntFieldController(),
            delegate: FoxyEntityPickerDelegates.questTemplate,
          ),
        ),
      ),
    );
    await tester.pump();

    // Tap the search icon to open the picker dialog.
    await tester.tap(find.byIcon(LucideIcons.search));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // Fake rows render (id column shows the ids).
    expect(find.text('100'), findsOneWidget);
    expect(find.text('200'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });
}

class _FakeQuestTemplateRepository extends QuestTemplateRepository {
  @override
  Future<List<BriefQuestTemplateEntity>> getBriefQuestTemplates({
    int page = 1,
    QuestTemplateFilter? filter,
  }) async {
    return [
      const BriefQuestTemplateEntity(id: 100, logTitle: '任务甲'),
      const BriefQuestTemplateEntity(id: 200, logTitle: '任务乙'),
    ];
  }

  @override
  Future<int> countQuestTemplates({QuestTemplateFilter? filter}) async => 2;
}

class _RecordingActivityLogRepository extends ActivityLogRepository {
  @override
  void storeActivityLogBestEffort(ActivityLogEntity log) {}
}
