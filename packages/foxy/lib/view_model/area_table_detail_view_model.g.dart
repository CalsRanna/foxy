// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_table_detail_view_model.dart';

mixin _AreaTableDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<AreaTableRepository>();

  final entity = signal<AreaTableEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final continentIdController = registerController(IntFieldController());
  late final parentAreaIdController = registerController(IntFieldController());
  late final areaBitController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final soundProviderPrefController = registerController(
    IntFieldController(),
  );
  late final soundProviderPrefUnderwaterController = registerController(
    IntFieldController(),
  );
  late final ambienceIdController = registerController(IntFieldController());
  late final zoneMusicController = registerController(IntFieldController());
  late final introSoundController = registerController(IntFieldController());
  late final explorationLevelController = registerController(
    IntFieldController(),
  );
  late final areaNameLangZhCNController = registerController(
    StringFieldController(),
  );
  late final areaNameLangFlagsController = registerController(
    IntFieldController(),
  );
  late final factionGroupMaskController = registerController(
    EnumFieldController<int>(fallback: 0),
  );
  late final liquidTypeId0Controller = registerController(IntFieldController());
  late final liquidTypeId1Controller = registerController(IntFieldController());
  late final liquidTypeId2Controller = registerController(IntFieldController());
  late final liquidTypeId3Controller = registerController(IntFieldController());
  late final minElevationController = registerController(
    DoubleFieldController(),
  );
  late final ambientMultiplierController = registerController(
    DoubleFieldController(),
  );
  late final lightIdController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createAreaTable();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getAreaTable(key);
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
      var candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final storedKey = await _repository.storeAreaTable(candidate);
        persistedKey.value = storedKey;
        if (storedKey != candidate.id) {
          candidate = candidate.copyWith(id: storedKey);
          if (!isDisposed) {
            idController.init(storedKey);
          }
        }
      } else {
        await _repository.updateAreaTable(originalKey, candidate);
        persistedKey.value = candidate.id;
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

  void _afterApplyCandidate(AreaTableEntity areaTable) {}

  void _applyCandidate(AreaTableEntity areaTable) {
    idController.init(areaTable.id);
    continentIdController.init(areaTable.continentId);
    parentAreaIdController.init(areaTable.parentAreaId);
    areaBitController.init(areaTable.areaBit);
    flagsController.init(areaTable.flags);
    soundProviderPrefController.init(areaTable.soundProviderPref);
    soundProviderPrefUnderwaterController.init(
      areaTable.soundProviderPrefUnderwater,
    );
    ambienceIdController.init(areaTable.ambienceId);
    zoneMusicController.init(areaTable.zoneMusic);
    introSoundController.init(areaTable.introSound);
    explorationLevelController.init(areaTable.explorationLevel);
    areaNameLangZhCNController.init(areaTable.areaNameLangZhCN);
    areaNameLangFlagsController.init(areaTable.areaNameLangFlags);
    factionGroupMaskController.init(areaTable.factionGroupMask);
    liquidTypeId0Controller.init(areaTable.liquidTypeId0);
    liquidTypeId1Controller.init(areaTable.liquidTypeId1);
    liquidTypeId2Controller.init(areaTable.liquidTypeId2);
    liquidTypeId3Controller.init(areaTable.liquidTypeId3);
    minElevationController.init(areaTable.minElevation);
    ambientMultiplierController.init(areaTable.ambientMultiplier);
    lightIdController.init(areaTable.lightId);
    _afterApplyCandidate(areaTable);
  }

  AreaTableEntity _collectCandidate() {
    return AreaTableEntity(
      id: idController.collect(),
      continentId: continentIdController.collect(),
      parentAreaId: parentAreaIdController.collect(),
      areaBit: areaBitController.collect(),
      flags: flagsController.collect(),
      soundProviderPref: soundProviderPrefController.collect(),
      soundProviderPrefUnderwater: soundProviderPrefUnderwaterController
          .collect(),
      ambienceId: ambienceIdController.collect(),
      zoneMusic: zoneMusicController.collect(),
      introSound: introSoundController.collect(),
      explorationLevel: explorationLevelController.collect(),
      areaNameLangZhCN: areaNameLangZhCNController.collect(),
      areaNameLangFlags: areaNameLangFlagsController.collect(),
      factionGroupMask: factionGroupMaskController.collect(),
      liquidTypeId0: liquidTypeId0Controller.collect(),
      liquidTypeId1: liquidTypeId1Controller.collect(),
      liquidTypeId2: liquidTypeId2Controller.collect(),
      liquidTypeId3: liquidTypeId3Controller.collect(),
      minElevation: minElevationController.collect(),
      ambientMultiplier: ambientMultiplierController.collect(),
      lightId: lightIdController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, AreaTableEntity areaTable) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_area_table',
          actionType: action,
          entityName: 'AreaTable ${areaTable.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
