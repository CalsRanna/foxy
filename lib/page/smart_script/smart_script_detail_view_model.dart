import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SmartScriptDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<SmartScriptRepository>();

  final script = signal(SmartScriptEntity());
  final isNew = signal(true);
  int? _origEntryOrGuid;
  int? _origSourceType;
  int? _origId;
  int? _origLink;

  final entryOrGuidController = IntFieldController();
  final sourceTypeController = IntFieldController();
  final idController = IntFieldController();
  final linkController = IntFieldController();
  final commentController = StringFieldController();

  final eventTypeController = IntFieldController();
  final eventPhaseMaskController = IntFieldController();
  final eventChanceController = IntFieldController();
  final eventFlagsController = IntFieldController();
  final eventParam1Controller = IntFieldController();
  final eventParam2Controller = IntFieldController();
  final eventParam3Controller = IntFieldController();
  final eventParam4Controller = IntFieldController();
  final eventParam5Controller = IntFieldController();

  final actionTypeController = IntFieldController();
  final actionParam1Controller = IntFieldController();
  final actionParam2Controller = IntFieldController();
  final actionParam3Controller = IntFieldController();
  final actionParam4Controller = IntFieldController();
  final actionParam5Controller = IntFieldController();
  final actionParam6Controller = IntFieldController();

  final targetTypeController = IntFieldController();
  final targetParam1Controller = IntFieldController();
  final targetParam2Controller = IntFieldController();
  final targetParam3Controller = IntFieldController();
  final targetParam4Controller = IntFieldController();
  final targetXController = DoubleFieldController();
  final targetYController = DoubleFieldController();
  final targetZController = DoubleFieldController();
  final targetOController = DoubleFieldController();

  late final _controllers = <FieldController>[
    entryOrGuidController,
    sourceTypeController,
    idController,
    linkController,
    commentController,
    eventTypeController,
    eventPhaseMaskController,
    eventChanceController,
    eventFlagsController,
    eventParam1Controller,
    eventParam2Controller,
    eventParam3Controller,
    eventParam4Controller,
    eventParam5Controller,
    actionTypeController,
    actionParam1Controller,
    actionParam2Controller,
    actionParam3Controller,
    actionParam4Controller,
    actionParam5Controller,
    actionParam6Controller,
    targetTypeController,
    targetParam1Controller,
    targetParam2Controller,
    targetParam3Controller,
    targetParam4Controller,
    targetXController,
    targetYController,
    targetZController,
    targetOController,
  ];

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final action = isNew.value
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (isNew.value) {
        // 用户可能改过归属键：按最终 (entryorguid, source_type) 重新分配 id
        final nextId = await _repository.nextIdFor(t.entryOrGuid, t.sourceType);
        t = t.copyWith(id: nextId, link: 0);
        idController.init(nextId);
        linkController.init(0);
        await _repository.storeSmartScript(t);
        _origEntryOrGuid = t.entryOrGuid;
        _origSourceType = t.sourceType;
        _origId = t.id;
        _origLink = t.link;
        isNew.value = false;
        script.value = t;
      } else {
        // 编辑：复合主键 WHERE 用加载时的键
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
      // 复合主键：新建时 create* 预填 scoped id；归属键可改，id/link 只读
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
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
