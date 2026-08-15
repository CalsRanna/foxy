// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_detail_view_model.dart';

mixin _GameObjectTemplateDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<GameObjectTemplateRepository>();

  final entity = signal<GameObjectTemplateEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(IntFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final displayIdController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final iconNameController = registerController(StringFieldController());
  late final castBarCaptionController = registerController(
    StringFieldController(),
  );
  late final unk1Controller = registerController(StringFieldController());
  late final sizeController = registerController(DoubleFieldController());
  late final data0Controller = registerController(IntFieldControllerGroup());
  late final data1Controller = registerController(IntFieldControllerGroup());
  late final data2Controller = registerController(IntFieldControllerGroup());
  late final data3Controller = registerController(IntFieldControllerGroup());
  late final data4Controller = registerController(IntFieldControllerGroup());
  late final data5Controller = registerController(IntFieldControllerGroup());
  late final data6Controller = registerController(IntFieldControllerGroup());
  late final data7Controller = registerController(IntFieldControllerGroup());
  late final data8Controller = registerController(IntFieldControllerGroup());
  late final data9Controller = registerController(IntFieldControllerGroup());
  late final data10Controller = registerController(IntFieldControllerGroup());
  late final data11Controller = registerController(IntFieldControllerGroup());
  late final data12Controller = registerController(IntFieldControllerGroup());
  late final data13Controller = registerController(IntFieldControllerGroup());
  late final data14Controller = registerController(IntFieldControllerGroup());
  late final data15Controller = registerController(IntFieldControllerGroup());
  late final data16Controller = registerController(IntFieldControllerGroup());
  late final data17Controller = registerController(IntFieldControllerGroup());
  late final data18Controller = registerController(IntFieldControllerGroup());
  late final data19Controller = registerController(IntFieldControllerGroup());
  late final data20Controller = registerController(IntFieldControllerGroup());
  late final data21Controller = registerController(IntFieldControllerGroup());
  late final data22Controller = registerController(IntFieldControllerGroup());
  late final data23Controller = registerController(IntFieldControllerGroup());
  late final aiNameController = registerController(StringFieldController());
  late final scriptNameController = registerController(StringFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createGameObjectTemplate();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getGameObjectTemplate(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = FoxyExceptions.message(error);
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
        final storedKey = await _repository.storeGameObjectTemplate(candidate);
        persistedKey.value = storedKey;
      } else {
        await _repository.updateGameObjectTemplate(originalKey, candidate);
        persistedKey.value = candidate.entry;
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(GameObjectTemplateEntity gameObjectTemplate) {}

  void _applyCandidate(GameObjectTemplateEntity gameObjectTemplate) {
    entryController.init(gameObjectTemplate.entry);
    typeController.init(gameObjectTemplate.type);
    displayIdController.init(gameObjectTemplate.displayId);
    nameController.init(gameObjectTemplate.name);
    iconNameController.init(gameObjectTemplate.iconName);
    castBarCaptionController.init(gameObjectTemplate.castBarCaption);
    unk1Controller.init(gameObjectTemplate.unk1);
    sizeController.init(gameObjectTemplate.size);
    data0Controller.init(gameObjectTemplate.data0);
    data1Controller.init(gameObjectTemplate.data1);
    data2Controller.init(gameObjectTemplate.data2);
    data3Controller.init(gameObjectTemplate.data3);
    data4Controller.init(gameObjectTemplate.data4);
    data5Controller.init(gameObjectTemplate.data5);
    data6Controller.init(gameObjectTemplate.data6);
    data7Controller.init(gameObjectTemplate.data7);
    data8Controller.init(gameObjectTemplate.data8);
    data9Controller.init(gameObjectTemplate.data9);
    data10Controller.init(gameObjectTemplate.data10);
    data11Controller.init(gameObjectTemplate.data11);
    data12Controller.init(gameObjectTemplate.data12);
    data13Controller.init(gameObjectTemplate.data13);
    data14Controller.init(gameObjectTemplate.data14);
    data15Controller.init(gameObjectTemplate.data15);
    data16Controller.init(gameObjectTemplate.data16);
    data17Controller.init(gameObjectTemplate.data17);
    data18Controller.init(gameObjectTemplate.data18);
    data19Controller.init(gameObjectTemplate.data19);
    data20Controller.init(gameObjectTemplate.data20);
    data21Controller.init(gameObjectTemplate.data21);
    data22Controller.init(gameObjectTemplate.data22);
    data23Controller.init(gameObjectTemplate.data23);
    aiNameController.init(gameObjectTemplate.aiName);
    scriptNameController.init(gameObjectTemplate.scriptName);
    verifiedBuildController.init(gameObjectTemplate.verifiedBuild);
    _afterApplyCandidate(gameObjectTemplate);
  }

  GameObjectTemplateEntity _collectCandidate() {
    return GameObjectTemplateEntity(
      entry: entryController.collect(),
      type: typeController.collect(),
      displayId: displayIdController.collect(),
      name: nameController.collect(),
      iconName: iconNameController.collect(),
      castBarCaption: castBarCaptionController.collect(),
      unk1: unk1Controller.collect(),
      size: sizeController.collect(),
      data0: data0Controller.collect(),
      data1: data1Controller.collect(),
      data2: data2Controller.collect(),
      data3: data3Controller.collect(),
      data4: data4Controller.collect(),
      data5: data5Controller.collect(),
      data6: data6Controller.collect(),
      data7: data7Controller.collect(),
      data8: data8Controller.collect(),
      data9: data9Controller.collect(),
      data10: data10Controller.collect(),
      data11: data11Controller.collect(),
      data12: data12Controller.collect(),
      data13: data13Controller.collect(),
      data14: data14Controller.collect(),
      data15: data15Controller.collect(),
      data16: data16Controller.collect(),
      data17: data17Controller.collect(),
      data18: data18Controller.collect(),
      data19: data19Controller.collect(),
      data20: data20Controller.collect(),
      data21: data21Controller.collect(),
      data22: data22Controller.collect(),
      data23: data23Controller.collect(),
      aiName: aiNameController.collect(),
      scriptName: scriptNameController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    GameObjectTemplateEntity gameObjectTemplate,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'gameobject_template',
          actionType: action,
          entityName: gameObjectTemplate.name,
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
