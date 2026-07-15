import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/page/smart_script/smart_script_validation_mixin.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SmartScriptDetailViewModel
    with
        FieldControllerMixin,
        ViewModelValidationMixin,
        SmartScriptValidationMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<SmartScriptRepository>();

  final script = signal(SmartScriptEntity());
  final isNew = signal(true);
  int? _origEntryOrGuid;
  int? _origSourceType;
  int? _origId;
  int? _origLink;

  late final entryOrGuidController = registerController(IntFieldController());
  late final sourceTypeController = registerController(IntFieldController());
  late final idController = registerController(IntFieldController());
  late final linkController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  late final eventTypeController = registerController(IntFieldController());
  late final eventPhaseMaskController = registerController(
    FlagFieldController(),
  );
  late final eventChanceController = registerController(IntFieldController());
  late final eventFlagsController = registerController(FlagFieldController());
  late final eventParam1Controller = registerController(IntFieldController());
  late final eventParam2Controller = registerController(IntFieldController());
  late final eventParam3Controller = registerController(IntFieldController());
  late final eventParam4Controller = registerController(IntFieldController());
  late final eventParam5Controller = registerController(IntFieldController());
  late final eventParam6Controller = registerController(IntFieldController());

  late final actionTypeController = registerController(IntFieldController());
  late final actionParam1Controller = registerController(IntFieldController());
  late final actionParam2Controller = registerController(IntFieldController());
  late final actionParam3Controller = registerController(IntFieldController());
  late final actionParam4Controller = registerController(IntFieldController());
  late final actionParam5Controller = registerController(IntFieldController());
  late final actionParam6Controller = registerController(IntFieldController());

  late final targetTypeController = registerController(IntFieldController());
  late final targetParam1Controller = registerController(IntFieldController());
  late final targetParam2Controller = registerController(IntFieldController());
  late final targetParam3Controller = registerController(IntFieldController());
  late final targetParam4Controller = registerController(IntFieldController());
  late final targetXController = registerController(DoubleFieldController());
  late final targetYController = registerController(DoubleFieldController());
  late final targetZController = registerController(DoubleFieldController());
  late final targetOController = registerController(DoubleFieldController());

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final action = isNew.value
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (isNew.value) {
        final nextId = await _repository.nextIdFor(t.entryOrGuid, t.sourceType);
        t = t.copyWith(id: nextId);
        idController.init(nextId);
        validateSmartScriptFields(t);
        await _repository.storeSmartScript(t);
        _origEntryOrGuid = t.entryOrGuid;
        _origSourceType = t.sourceType;
        _origId = t.id;
        _origLink = t.link;
        isNew.value = false;
        script.value = t;
      } else {
        validateSmartScriptFields(t);
        await _repository.updateSmartScript(
          _origEntryOrGuid!,
          _origSourceType!,
          _origId!,
          _origLink!,
          t,
        );
        script.value = t;
      }
      _logActivity(action, t);
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('脚本数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> initSignals({
    int? entryOrGuid,
    int? sourceType,
    int? id,
    int? link,
  }) async {
    try {
      if (entryOrGuid == null ||
          sourceType == null ||
          id == null ||
          link == null) {
        isNew.value = true;
        final blank = await _repository.createSmartScript();
        script.value = blank;
        _initControllers(blank);
        return;
      }
      _origEntryOrGuid = entryOrGuid;
      _origSourceType = sourceType;
      _origId = id;
      _origLink = link;
      isNew.value = false;
      final result = await _repository.getSmartScript(
        entryOrGuid,
        sourceType,
        id,
        link,
      );
      if (result == null) return;
      script.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e(
        '加载脚本(entryOrGuid=$entryOrGuid, id=$id)失败',
        error: e,
        stackTrace: s,
      );
    }
  }

  void _initControllers(SmartScriptEntity t) {
    entryOrGuidController.init(t.entryOrGuid);
    sourceTypeController.init(t.sourceType);
    idController.init(t.id);
    linkController.init(t.link);
    commentController.init(t.comment);

    eventTypeController.init(t.eventType);
    eventPhaseMaskController.init(t.eventPhaseMask);
    eventChanceController.init(t.eventChance);
    eventFlagsController.init(t.eventFlags);
    eventParam1Controller.init(t.eventParam1);
    eventParam2Controller.init(t.eventParam2);
    eventParam3Controller.init(t.eventParam3);
    eventParam4Controller.init(t.eventParam4);
    eventParam5Controller.init(t.eventParam5);
    eventParam6Controller.init(t.eventParam6);

    actionTypeController.init(t.actionType);
    actionParam1Controller.init(t.actionParam1);
    actionParam2Controller.init(t.actionParam2);
    actionParam3Controller.init(t.actionParam3);
    actionParam4Controller.init(t.actionParam4);
    actionParam5Controller.init(t.actionParam5);
    actionParam6Controller.init(t.actionParam6);

    targetTypeController.init(t.targetType);
    targetParam1Controller.init(t.targetParam1);
    targetParam2Controller.init(t.targetParam2);
    targetParam3Controller.init(t.targetParam3);
    targetParam4Controller.init(t.targetParam4);
    targetXController.init(t.targetX);
    targetYController.init(t.targetY);
    targetZController.init(t.targetZ);
    targetOController.init(t.targetO);
  }

  SmartScriptEntity _collectFromControllers() {
    return SmartScriptEntity(
      entryOrGuid: entryOrGuidController.collect(),
      sourceType: sourceTypeController.collect(),
      id: idController.collect(),
      link: linkController.collect(),
      comment: commentController.collect(),
      eventType: eventTypeController.collect(),
      eventPhaseMask: eventPhaseMaskController.collect(),
      eventChance: eventChanceController.collect(),
      eventFlags: eventFlagsController.collect(),
      eventParam1: eventParam1Controller.collect(),
      eventParam2: eventParam2Controller.collect(),
      eventParam3: eventParam3Controller.collect(),
      eventParam4: eventParam4Controller.collect(),
      eventParam5: eventParam5Controller.collect(),
      eventParam6: eventParam6Controller.collect(),
      actionType: actionTypeController.collect(),
      actionParam1: actionParam1Controller.collect(),
      actionParam2: actionParam2Controller.collect(),
      actionParam3: actionParam3Controller.collect(),
      actionParam4: actionParam4Controller.collect(),
      actionParam5: actionParam5Controller.collect(),
      actionParam6: actionParam6Controller.collect(),
      targetType: targetTypeController.collect(),
      targetParam1: targetParam1Controller.collect(),
      targetParam2: targetParam2Controller.collect(),
      targetParam3: targetParam3Controller.collect(),
      targetParam4: targetParam4Controller.collect(),
      targetX: targetXController.collect(),
      targetY: targetYController.collect(),
      targetZ: targetZController.collect(),
      targetO: targetOController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, SmartScriptEntity t) {
    final log = ActivityLogEntity(
      module: 'smart_script',
      actionType: action,
      entityId: t.entryOrGuid,
      entityName: t.comment,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
