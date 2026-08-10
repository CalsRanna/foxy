import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class AreaTableDetailViewModel with FieldControllerMixin {
  void _logActivity(ActivityActionType action, AreaTableEntity t) {
    final log = ActivityLogEntity(
      module: 'area_table',
      actionType: action,
      entityName: t.areaNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }

  final _repository = GetIt.instance.get<AreaTableRepository>();

  final entity = signal<AreaTableEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final continentIdController = registerController(IntFieldController());
  late final parentAreaIdController = registerController(IntFieldController());
  late final areaBitController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final factionGroupMaskController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final explorationLevelController = registerController(
    IntFieldController(),
  );
  late final areaNameLangFlagsController = registerController(
    IntFieldController(),
  );

  /// Sound
  late final soundProviderPrefController = registerController(
    IntFieldController(),
  );
  late final soundProviderPrefUnderwaterController = registerController(
    IntFieldController(),
  );
  late final ambienceIdController = registerController(IntFieldController());
  late final zoneMusicController = registerController(IntFieldController());
  late final introSoundController = registerController(IntFieldController());
  late final ambientMultiplierController = registerController(
    DoubleFieldController(),
  );
  late final lightIdController = registerController(IntFieldController());
  late final minElevationController = registerController(
    DoubleFieldController(),
  );

  /// Other
  late final liquidTypeId0Controller = registerController(IntFieldController());
  late final liquidTypeId1Controller = registerController(IntFieldController());
  late final liquidTypeId2Controller = registerController(IntFieldController());
  late final liquidTypeId3Controller = registerController(IntFieldController());

  /// After the dialog saves the area-name localization, merges it back
  /// into the current Entity and syncs the main-language input.
  void applyAreaNameLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      areaNameLangEnUS: values.valueOf('enUS'),
      areaNameLangKoKR: values.valueOf('koKR'),
      areaNameLangFrFR: values.valueOf('frFR'),
      areaNameLangDeDE: values.valueOf('deDE'),
      areaNameLangZhCN: values.valueOf('zhCN'),
      areaNameLangZhTW: values.valueOf('zhTW'),
      areaNameLangEsES: values.valueOf('esES'),
      areaNameLangEsMX: values.valueOf('esMX'),
      areaNameLangRuRU: values.valueOf('ruRU'),
      areaNameLangJaJP: values.valueOf('jaJP'),
      areaNameLangPtPT: values.valueOf('ptPT'),
      areaNameLangPtBR: values.valueOf('ptBR'),
      areaNameLangItIT: values.valueOf('itIT'),
      areaNameLangUnk1: values.valueOf('unk1'),
      areaNameLangUnk2: values.valueOf('unk2'),
      areaNameLangUnk3: values.valueOf('unk3'),
    );
    nameController.init(values.zhCN);
  }

  void dispose() {
    disposeControllers();
  }

  /// Collects data from all controllers to build the AreaTable

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
      errorMessage.value = FoxyError.message(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  /// Leaves the page
  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      await _validate(candidate, originalKey: originalKey);
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeAreaTable(candidate);
      } else {
        await _repository.updateAreaTable(originalKey, candidate);
      }
      final newKey = candidate.id;
      persistedKey.value = newKey;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _applyCandidate(AreaTableEntity table) {
    idController.init(table.id);
    nameController.init(table.areaNameLangZhCN);
    continentIdController.init(table.continentId);
    parentAreaIdController.init(table.parentAreaId);
    areaBitController.init(table.areaBit);
    flagsController.init(table.flags);
    factionGroupMaskController.init(table.factionGroupMask);
    explorationLevelController.init(table.explorationLevel);
    areaNameLangFlagsController.init(table.areaNameLangFlags);
    soundProviderPrefController.init(table.soundProviderPref);
    soundProviderPrefUnderwaterController.init(
      table.soundProviderPrefUnderwater,
    );
    ambienceIdController.init(table.ambienceId);
    zoneMusicController.init(table.zoneMusic);
    introSoundController.init(table.introSound);
    ambientMultiplierController.init(table.ambientMultiplier);
    lightIdController.init(table.lightId);
    minElevationController.init(table.minElevation);
    liquidTypeId0Controller.init(table.liquidTypeId0);
    liquidTypeId1Controller.init(table.liquidTypeId1);
    liquidTypeId2Controller.init(table.liquidTypeId2);
    liquidTypeId3Controller.init(table.liquidTypeId3);
  }

  AreaTableEntity _collectCandidate() {
    // Overlay UI fields from the loaded entity, so hidden columns such as
    // multi-language ones are never cleared.
    return entity.value!.copyWith(
      id: idController.collect(),
      areaNameLangZhCN: nameController.collect(),
      continentId: continentIdController.collect(),
      parentAreaId: parentAreaIdController.collect(),
      areaBit: areaBitController.collect(),
      flags: flagsController.collect(),
      factionGroupMask: factionGroupMaskController.collect(),
      explorationLevel: explorationLevelController.collect(),
      areaNameLangFlags: areaNameLangFlagsController.collect(),
      soundProviderPref: soundProviderPrefController.collect(),
      soundProviderPrefUnderwater: soundProviderPrefUnderwaterController
          .collect(),
      ambienceId: ambienceIdController.collect(),
      zoneMusic: zoneMusicController.collect(),
      introSound: introSoundController.collect(),
      ambientMultiplier: ambientMultiplierController.collect(),
      lightId: lightIdController.collect(),
      minElevation: minElevationController.collect(),
      liquidTypeId0: liquidTypeId0Controller.collect(),
      liquidTypeId1: liquidTypeId1Controller.collect(),
      liquidTypeId2: liquidTypeId2Controller.collect(),
      liquidTypeId3: liquidTypeId3Controller.collect(),
    );
  }

  Future<void> _validate(
    AreaTableEntity value, {
    required int? originalKey,
  }) async {
    if (value.parentAreaId > 0 &&
        await _repository.getAreaTable(value.parentAreaId) == null) {
      throw RecordNotFoundException(
        'parent area ${value.parentAreaId} does not exist',
      );
    }
    if (!await _repository.isAreaBitAvailable(
      value.areaBit,
      excludingKey: originalKey,
    )) {
      throw DuplicateKeyException(
        'exploration bit index ${value.areaBit} is already used by another area',
      );
    }
  }
}
