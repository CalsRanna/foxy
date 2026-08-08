// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_script_detail_view_model.dart';

mixin _SmartScriptDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<SmartScriptRepository>();

  final entity = signal<SmartScriptEntity?>(null);

  final persistedKey = signal<SmartScriptKey?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryOrGuidController = registerController(IntFieldController());
  late final sourceTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final idController = registerController(IntFieldController());
  late final linkController = registerController(IntFieldController());
  late final eventTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final eventPhaseMaskController = registerController(
    FlagFieldController(),
  );
  late final eventChanceController = registerController(IntFieldController());
  late final eventFlagsController = registerController(FlagFieldController());
  late final eventParam1Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final eventParam2Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final eventParam3Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final eventParam4Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final eventParam5Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final eventParam6Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final actionTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final actionParam1Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final actionParam2Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final actionParam3Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final actionParam4Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final actionParam5Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final actionParam6Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final targetTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final targetParam1Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final targetParam2Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final targetParam3Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final targetParam4Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final targetXController = registerController(DoubleFieldController());
  late final targetYController = registerController(DoubleFieldController());
  late final targetZController = registerController(DoubleFieldController());
  late final targetOController = registerController(DoubleFieldController());
  late final commentController = registerController(StringFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({SmartScriptKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createSmartScript();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getSmartScript(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final _ = await _repository.storeSmartScript(candidate);
        persistedKey.value = SmartScriptKey.fromEntity(candidate);
      } else {
        await _repository.updateSmartScript(originalKey, candidate);
        persistedKey.value = SmartScriptKey.fromEntity(candidate);
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(SmartScriptEntity smartScript) {}

  void _applyCandidate(SmartScriptEntity smartScript) {
    entryOrGuidController.init(smartScript.entryOrGuid);
    sourceTypeController.init(smartScript.sourceType);
    idController.init(smartScript.id);
    linkController.init(smartScript.link);
    eventTypeController.init(smartScript.eventType);
    eventPhaseMaskController.init(smartScript.eventPhaseMask);
    eventChanceController.init(smartScript.eventChance);
    eventFlagsController.init(smartScript.eventFlags);
    eventParam1Controller.init(smartScript.eventParam1);
    eventParam2Controller.init(smartScript.eventParam2);
    eventParam3Controller.init(smartScript.eventParam3);
    eventParam4Controller.init(smartScript.eventParam4);
    eventParam5Controller.init(smartScript.eventParam5);
    eventParam6Controller.init(smartScript.eventParam6);
    actionTypeController.init(smartScript.actionType);
    actionParam1Controller.init(smartScript.actionParam1);
    actionParam2Controller.init(smartScript.actionParam2);
    actionParam3Controller.init(smartScript.actionParam3);
    actionParam4Controller.init(smartScript.actionParam4);
    actionParam5Controller.init(smartScript.actionParam5);
    actionParam6Controller.init(smartScript.actionParam6);
    targetTypeController.init(smartScript.targetType);
    targetParam1Controller.init(smartScript.targetParam1);
    targetParam2Controller.init(smartScript.targetParam2);
    targetParam3Controller.init(smartScript.targetParam3);
    targetParam4Controller.init(smartScript.targetParam4);
    targetXController.init(smartScript.targetX);
    targetYController.init(smartScript.targetY);
    targetZController.init(smartScript.targetZ);
    targetOController.init(smartScript.targetO);
    commentController.init(smartScript.comment);
    _afterApplyCandidate(smartScript);
  }

  SmartScriptEntity _collectCandidate() {
    return SmartScriptEntity(
      entryOrGuid: entryOrGuidController.collect(),
      sourceType: sourceTypeController.collect(),
      id: idController.collect(),
      link: linkController.collect(),
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
      comment: commentController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, SmartScriptEntity smartScript) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'smart_scripts',
          actionType: action,
          entityName: 'SmartScript',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
