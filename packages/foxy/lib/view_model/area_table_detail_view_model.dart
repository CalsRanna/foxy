import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'area_table_detail_view_model.g.dart';

@FoxyDetailViewModel(
  enums: {'factionGroupMask'},
  flags: {'flags'},
  // Other locales are kept in entity and edited through the locale dialog.
  exclude: {
    'areaNameLangEnUS',
    'areaNameLangKoKR',
    'areaNameLangFrFR',
    'areaNameLangDeDE',
    'areaNameLangZhTW',
    'areaNameLangEsES',
    'areaNameLangEsMX',
    'areaNameLangRuRU',
    'areaNameLangJaJP',
    'areaNameLangPtPT',
    'areaNameLangPtBR',
    'areaNameLangItIT',
    'areaNameLangUnk1',
    'areaNameLangUnk2',
    'areaNameLangUnk3',
  },
)
class AreaTableDetailViewModel
    with FieldControllerMixin, _AreaTableDetailViewModelMixin {
  StringFieldController get nameController => areaNameLangZhCNController;

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

  @override
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

  @override
  void _logActivity(ActivityActionType action, AreaTableEntity t) {
    final log = ActivityLogEntity(
      module: 'area_table',
      actionType: action,
      entityName: t.areaNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }
}
