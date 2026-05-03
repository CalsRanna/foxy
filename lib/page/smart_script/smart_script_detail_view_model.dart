import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SmartScriptDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = SmartScriptRepository();

  final script = signal(SmartScriptEntity());
  final isNew = signal(true);
  int? _origEntryOrGuid;
  int? _origSourceType;
  int? _origId;
  int? _origLink;

  final entryOrGuid = signal<int>(0);
  final sourceType = signal<int>(0);
  final id = signal<int>(0);
  final link = signal<int>(0);
  final commentController = TextEditingController();

  final eventType = signal<int>(0);
  final eventPhaseMask = signal<int>(0);
  final eventChance = signal<int>(0);
  final eventFlags = signal<int>(0);
  final eventParam1 = signal<int>(0);
  final eventParam2 = signal<int>(0);
  final eventParam3 = signal<int>(0);
  final eventParam4 = signal<int>(0);
  final eventParam5 = signal<int>(0);

  final actionType = signal<int>(0);
  final actionParam1 = signal<int>(0);
  final actionParam2 = signal<int>(0);
  final actionParam3 = signal<int>(0);
  final actionParam4 = signal<int>(0);
  final actionParam5 = signal<int>(0);
  final actionParam6 = signal<int>(0);

  final targetType = signal<int>(0);
  final targetParam1 = signal<int>(0);
  final targetParam2 = signal<int>(0);
  final targetParam3 = signal<int>(0);
  final targetParam4 = signal<int>(0);
  final targetX = signal<double>(0.0);
  final targetY = signal<double>(0.0);
  final targetZ = signal<double>(0.0);
  final targetO = signal<double>(0.0);

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final action = isNew.value
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (isNew.value) {
        await repository.storeSmartScript(t);
        _origEntryOrGuid = t.entryOrGuid;
        _origSourceType = t.sourceType;
        _origId = t.id;
        _origLink = t.link;
        isNew.value = false;
        script.value = t;
      } else {
        await repository.updateSmartScript(
          _origEntryOrGuid!,
          _origSourceType!,
          _origId!,
          _origLink!,
          t,
        );
        _origEntryOrGuid = t.entryOrGuid;
        _origSourceType = t.sourceType;
        _origId = t.id;
        _origLink = t.link;
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
    if (entryOrGuid == null ||
        sourceType == null ||
        id == null ||
        link == null) {
      isNew.value = true;
      return;
    }
    _origEntryOrGuid = entryOrGuid;
    _origSourceType = sourceType;
    _origId = id;
    _origLink = link;
    isNew.value = false;
    try {
      script.value = await repository.getSmartScript(
        entryOrGuid,
        sourceType,
        id,
        link,
      );
      _initControllers(script.value);
    } catch (e, s) {
      LoggerUtil.instance.e(
        '加载脚本(entryOrGuid=$entryOrGuid, id=$id)失败',
        error: e,
        stackTrace: s,
      );
    }
  }

  void _initControllers(SmartScriptEntity t) {
    entryOrGuid.value = t.entryOrGuid;
    sourceType.value = t.sourceType;
    id.value = t.id;
    link.value = t.link;
    commentController.text = t.comment;

    eventType.value = t.eventType;
    eventPhaseMask.value = t.eventPhaseMask;
    eventChance.value = t.eventChance;
    eventFlags.value = t.eventFlags;
    eventParam1.value = t.eventParam1;
    eventParam2.value = t.eventParam2;
    eventParam3.value = t.eventParam3;
    eventParam4.value = t.eventParam4;
    eventParam5.value = t.eventParam5;

    actionType.value = t.actionType;
    actionParam1.value = t.actionParam1;
    actionParam2.value = t.actionParam2;
    actionParam3.value = t.actionParam3;
    actionParam4.value = t.actionParam4;
    actionParam5.value = t.actionParam5;
    actionParam6.value = t.actionParam6;

    targetType.value = t.targetType;
    targetParam1.value = t.targetParam1;
    targetParam2.value = t.targetParam2;
    targetParam3.value = t.targetParam3;
    targetParam4.value = t.targetParam4;
    targetX.value = t.targetX;
    targetY.value = t.targetY;
    targetZ.value = t.targetZ;
    targetO.value = t.targetO;
  }

  SmartScriptEntity _collectFromControllers() {
    return SmartScriptEntity(
      entryOrGuid: entryOrGuid.value,
      sourceType: sourceType.value,
      id: id.value,
      link: link.value,
      comment: commentController.text,
      eventType: eventType.value,
      eventPhaseMask: eventPhaseMask.value,
      eventChance: eventChance.value,
      eventFlags: eventFlags.value,
      eventParam1: eventParam1.value,
      eventParam2: eventParam2.value,
      eventParam3: eventParam3.value,
      eventParam4: eventParam4.value,
      eventParam5: eventParam5.value,
      actionType: actionType.value,
      actionParam1: actionParam1.value,
      actionParam2: actionParam2.value,
      actionParam3: actionParam3.value,
      actionParam4: actionParam4.value,
      actionParam5: actionParam5.value,
      actionParam6: actionParam6.value,
      targetType: targetType.value,
      targetParam1: targetParam1.value,
      targetParam2: targetParam2.value,
      targetParam3: targetParam3.value,
      targetParam4: targetParam4.value,
      targetX: targetX.value,
      targetY: targetY.value,
      targetZ: targetZ.value,
      targetO: targetO.value,
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    commentController.dispose();
  }
}
