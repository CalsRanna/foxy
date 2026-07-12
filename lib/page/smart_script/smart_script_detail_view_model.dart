import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
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
  final _repository = GetIt.instance.get<SmartScriptRepository>();

  final script = signal(SmartScriptEntity());
  final isNew = signal(true);
  int? _origEntryOrGuid;
  int? _origSourceType;
  int? _origId;
  int? _origLink;

  final entryOrGuidController = TextEditingController();
  final sourceTypeController = TextEditingController();
  final idController = TextEditingController();
  final linkController = TextEditingController();
  final commentController = TextEditingController();

  final eventTypeController = TextEditingController();
  final eventPhaseMaskController = TextEditingController();
  final eventChanceController = TextEditingController();
  final eventFlagsController = TextEditingController();
  final eventParam1Controller = TextEditingController();
  final eventParam2Controller = TextEditingController();
  final eventParam3Controller = TextEditingController();
  final eventParam4Controller = TextEditingController();
  final eventParam5Controller = TextEditingController();

  final actionTypeController = TextEditingController();
  final actionParam1Controller = TextEditingController();
  final actionParam2Controller = TextEditingController();
  final actionParam3Controller = TextEditingController();
  final actionParam4Controller = TextEditingController();
  final actionParam5Controller = TextEditingController();
  final actionParam6Controller = TextEditingController();

  final targetTypeController = TextEditingController();
  final targetParam1Controller = TextEditingController();
  final targetParam2Controller = TextEditingController();
  final targetParam3Controller = TextEditingController();
  final targetParam4Controller = TextEditingController();
  final targetXController = TextEditingController();
  final targetYController = TextEditingController();
  final targetZController = TextEditingController();
  final targetOController = TextEditingController();

  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);
  double _pd(String t, [String field = '']) => parseDoubleField(t, field: field);

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final action = isNew.value
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (isNew.value) {
        await _repository.storeSmartScript(t);
        _origEntryOrGuid = t.entryOrGuid;
        _origSourceType = t.sourceType;
        _origId = t.id;
        _origLink = t.link;
        isNew.value = false;
        script.value = t;
      } else {
        // 复合主键只读：WHERE 始终用加载时的键，不把表单主键写回 _orig*
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
    entryOrGuidController.text = _fmt(t.entryOrGuid);
    sourceTypeController.text = _fmt(t.sourceType);
    idController.text = _fmt(t.id);
    linkController.text = _fmt(t.link);
    commentController.text = t.comment;

    eventTypeController.text = _fmt(t.eventType);
    eventPhaseMaskController.text = _fmt(t.eventPhaseMask);
    eventChanceController.text = _fmt(t.eventChance);
    eventFlagsController.text = _fmt(t.eventFlags);
    eventParam1Controller.text = _fmt(t.eventParam1);
    eventParam2Controller.text = _fmt(t.eventParam2);
    eventParam3Controller.text = _fmt(t.eventParam3);
    eventParam4Controller.text = _fmt(t.eventParam4);
    eventParam5Controller.text = _fmt(t.eventParam5);

    actionTypeController.text = _fmt(t.actionType);
    actionParam1Controller.text = _fmt(t.actionParam1);
    actionParam2Controller.text = _fmt(t.actionParam2);
    actionParam3Controller.text = _fmt(t.actionParam3);
    actionParam4Controller.text = _fmt(t.actionParam4);
    actionParam5Controller.text = _fmt(t.actionParam5);
    actionParam6Controller.text = _fmt(t.actionParam6);

    targetTypeController.text = _fmt(t.targetType);
    targetParam1Controller.text = _fmt(t.targetParam1);
    targetParam2Controller.text = _fmt(t.targetParam2);
    targetParam3Controller.text = _fmt(t.targetParam3);
    targetParam4Controller.text = _fmt(t.targetParam4);
    targetXController.text = _fmt(t.targetX);
    targetYController.text = _fmt(t.targetY);
    targetZController.text = _fmt(t.targetZ);
    targetOController.text = _fmt(t.targetO);
  }

  SmartScriptEntity _collectFromControllers() {
    return SmartScriptEntity(
      entryOrGuid: _pi(entryOrGuidController.text),
      sourceType: _pi(sourceTypeController.text),
      id: _pi(idController.text),
      link: _pi(linkController.text),
      comment: commentController.text,
      eventType: _pi(eventTypeController.text),
      eventPhaseMask: _pi(eventPhaseMaskController.text),
      eventChance: _pi(eventChanceController.text),
      eventFlags: _pi(eventFlagsController.text),
      eventParam1: _pi(eventParam1Controller.text),
      eventParam2: _pi(eventParam2Controller.text),
      eventParam3: _pi(eventParam3Controller.text),
      eventParam4: _pi(eventParam4Controller.text),
      eventParam5: _pi(eventParam5Controller.text),
      actionType: _pi(actionTypeController.text),
      actionParam1: _pi(actionParam1Controller.text),
      actionParam2: _pi(actionParam2Controller.text),
      actionParam3: _pi(actionParam3Controller.text),
      actionParam4: _pi(actionParam4Controller.text),
      actionParam5: _pi(actionParam5Controller.text),
      actionParam6: _pi(actionParam6Controller.text),
      targetType: _pi(targetTypeController.text),
      targetParam1: _pi(targetParam1Controller.text),
      targetParam2: _pi(targetParam2Controller.text),
      targetParam3: _pi(targetParam3Controller.text),
      targetParam4: _pi(targetParam4Controller.text),
      targetX: _pd(targetXController.text),
      targetY: _pd(targetYController.text),
      targetZ: _pd(targetZController.text),
      targetO: _pd(targetOController.text),
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
    actionParam1Controller.dispose();
    actionParam2Controller.dispose();
    actionParam3Controller.dispose();
    actionParam4Controller.dispose();
    actionParam5Controller.dispose();
    actionParam6Controller.dispose();
    actionTypeController.dispose();
    commentController.dispose();
    entryOrGuidController.dispose();
    eventChanceController.dispose();
    eventFlagsController.dispose();
    eventParam1Controller.dispose();
    eventParam2Controller.dispose();
    eventParam3Controller.dispose();
    eventParam4Controller.dispose();
    eventParam5Controller.dispose();
    eventPhaseMaskController.dispose();
    eventTypeController.dispose();
    idController.dispose();
    linkController.dispose();
    sourceTypeController.dispose();
    targetOController.dispose();
    targetParam1Controller.dispose();
    targetParam2Controller.dispose();
    targetParam3Controller.dispose();
    targetParam4Controller.dispose();
    targetTypeController.dispose();
    targetXController.dispose();
    targetYController.dispose();
    targetZController.dispose();
  }
}
