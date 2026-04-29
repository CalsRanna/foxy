import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log.dart';
import 'package:foxy/entity/smart_script.dart';
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

  final script = signal(SmartScript());
  final isNew = signal(true);
  final saving = signal(false);

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

  Future<void> save(BuildContext context) async {
    saving.value = true;
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
    } finally {
      saving.value = false;
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
      logger.e(
        '加载脚本(entryOrGuid=$entryOrGuid, id=$id)失败',
        error: e,
        stackTrace: s,
      );
    }
  }

  void _initControllers(SmartScript t) {
    entryOrGuidController.text = t.entryOrGuid.toString();
    sourceTypeController.text = t.sourceType.toString();
    idController.text = t.id.toString();
    linkController.text = t.link.toString();
    commentController.text = t.comment;

    eventTypeController.text = t.eventType.toString();
    eventPhaseMaskController.text = t.eventPhaseMask.toString();
    eventChanceController.text = t.eventChance.toString();
    eventFlagsController.text = t.eventFlags.toString();
    eventParam1Controller.text = t.eventParam1.toString();
    eventParam2Controller.text = t.eventParam2.toString();
    eventParam3Controller.text = t.eventParam3.toString();
    eventParam4Controller.text = t.eventParam4.toString();
    eventParam5Controller.text = t.eventParam5.toString();

    actionTypeController.text = t.actionType.toString();
    actionParam1Controller.text = t.actionParam1.toString();
    actionParam2Controller.text = t.actionParam2.toString();
    actionParam3Controller.text = t.actionParam3.toString();
    actionParam4Controller.text = t.actionParam4.toString();
    actionParam5Controller.text = t.actionParam5.toString();
    actionParam6Controller.text = t.actionParam6.toString();

    targetTypeController.text = t.targetType.toString();
    targetParam1Controller.text = t.targetParam1.toString();
    targetParam2Controller.text = t.targetParam2.toString();
    targetParam3Controller.text = t.targetParam3.toString();
    targetParam4Controller.text = t.targetParam4.toString();
    targetXController.text = t.targetX.toString();
    targetYController.text = t.targetY.toString();
    targetZController.text = t.targetZ.toString();
    targetOController.text = t.targetO.toString();
  }

  SmartScript _collectFromControllers() {
    return SmartScript(
      entryOrGuid: _parseInt(entryOrGuidController.text),
      sourceType: _parseInt(sourceTypeController.text),
      id: _parseInt(idController.text),
      link: _parseInt(linkController.text),
      comment: commentController.text,
      eventType: _parseInt(eventTypeController.text),
      eventPhaseMask: _parseInt(eventPhaseMaskController.text),
      eventChance: _parseInt(eventChanceController.text),
      eventFlags: _parseInt(eventFlagsController.text),
      eventParam1: _parseInt(eventParam1Controller.text),
      eventParam2: _parseInt(eventParam2Controller.text),
      eventParam3: _parseInt(eventParam3Controller.text),
      eventParam4: _parseInt(eventParam4Controller.text),
      eventParam5: _parseInt(eventParam5Controller.text),
      actionType: _parseInt(actionTypeController.text),
      actionParam1: _parseInt(actionParam1Controller.text),
      actionParam2: _parseInt(actionParam2Controller.text),
      actionParam3: _parseInt(actionParam3Controller.text),
      actionParam4: _parseInt(actionParam4Controller.text),
      actionParam5: _parseInt(actionParam5Controller.text),
      actionParam6: _parseInt(actionParam6Controller.text),
      targetType: _parseInt(targetTypeController.text),
      targetParam1: _parseInt(targetParam1Controller.text),
      targetParam2: _parseInt(targetParam2Controller.text),
      targetParam3: _parseInt(targetParam3Controller.text),
      targetParam4: _parseInt(targetParam4Controller.text),
      targetX: _parseDouble(targetXController.text),
      targetY: _parseDouble(targetYController.text),
      targetZ: _parseDouble(targetZController.text),
      targetO: _parseDouble(targetOController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, SmartScript t) {
    final log = ActivityLog(
      module: 'smart_script',
      actionType: action,
      entityId: t.entryOrGuid,
      entityName: t.comment,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    entryOrGuidController.dispose();
    sourceTypeController.dispose();
    idController.dispose();
    linkController.dispose();
    commentController.dispose();
    eventTypeController.dispose();
    eventPhaseMaskController.dispose();
    eventChanceController.dispose();
    eventFlagsController.dispose();
    eventParam1Controller.dispose();
    eventParam2Controller.dispose();
    eventParam3Controller.dispose();
    eventParam4Controller.dispose();
    eventParam5Controller.dispose();
    actionTypeController.dispose();
    actionParam1Controller.dispose();
    actionParam2Controller.dispose();
    actionParam3Controller.dispose();
    actionParam4Controller.dispose();
    actionParam5Controller.dispose();
    actionParam6Controller.dispose();
    targetTypeController.dispose();
    targetParam1Controller.dispose();
    targetParam2Controller.dispose();
    targetParam3Controller.dispose();
    targetParam4Controller.dispose();
    targetXController.dispose();
    targetYController.dispose();
    targetZController.dispose();
    targetOController.dispose();
  }
}
