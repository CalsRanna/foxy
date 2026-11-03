import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_item_enchantment_detail_view_model.g.dart';

@FoxyDetailViewModel(
  enums: {'effect0', 'effect1', 'effect2'},
  flags: {'flags'},
  groups: {'effectArg0', 'effectArg1', 'effectArg2'},
  // Other locales are kept in entity and edited through the locale dialog.
  exclude: {
    'nameLangEnUS',
    'nameLangKoKR',
    'nameLangFrFR',
    'nameLangDeDE',
    'nameLangZhTW',
    'nameLangEsES',
    'nameLangEsMX',
    'nameLangRuRU',
    'nameLangJaJP',
    'nameLangPtPT',
    'nameLangPtBR',
    'nameLangItIT',
    'nameLangUnk1',
    'nameLangUnk2',
    'nameLangUnk3',
  },
)
class SpellItemEnchantmentDetailViewModel
    with FieldControllerMixin, _SpellItemEnchantmentDetailViewModelMixin {
  StringFieldController get nameController => nameLangZhCNController;

  void applyNameLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      nameLangEnUS: values.valueOf('enUS'),
      nameLangKoKR: values.valueOf('koKR'),
      nameLangFrFR: values.valueOf('frFR'),
      nameLangDeDE: values.valueOf('deDE'),
      nameLangZhCN: values.valueOf('zhCN'),
      nameLangZhTW: values.valueOf('zhTW'),
      nameLangEsES: values.valueOf('esES'),
      nameLangEsMX: values.valueOf('esMX'),
      nameLangRuRU: values.valueOf('ruRU'),
      nameLangJaJP: values.valueOf('jaJP'),
      nameLangPtPT: values.valueOf('ptPT'),
      nameLangPtBR: values.valueOf('ptBR'),
      nameLangItIT: values.valueOf('itIT'),
      nameLangUnk1: values.valueOf('unk1'),
      nameLangUnk2: values.valueOf('unk2'),
      nameLangUnk3: values.valueOf('unk3'),
    );
    nameController.init(values.zhCN);
  }

  @override
  SpellItemEnchantmentEntity _collectCandidate() {
    // Overlay UI fields from the loaded entity, so hidden columns such as
    // multi-language ones are never cleared.
    return entity.value!.copyWith(
      id: idController.collect(),
      nameLangZhCN: nameController.collect(),
      charges: chargesController.collect(),
      effect0: effect0Controller.collect(),
      effect1: effect1Controller.collect(),
      effect2: effect2Controller.collect(),
      effectPointsMin0: effectPointsMin0Controller.collect(),
      effectPointsMin1: effectPointsMin1Controller.collect(),
      effectPointsMin2: effectPointsMin2Controller.collect(),
      effectPointsMax0: effectPointsMax0Controller.collect(),
      effectPointsMax1: effectPointsMax1Controller.collect(),
      effectPointsMax2: effectPointsMax2Controller.collect(),
      effectArg0: effectArg0Controller.collect(),
      effectArg1: effectArg1Controller.collect(),
      effectArg2: effectArg2Controller.collect(),
      itemVisual: itemVisualController.collect(),
      nameLangFlags: nameLangFlagsController.collect(),
      flags: flagsController.collect(),
      srcItemId: srcItemIdController.collect(),
      conditionId: conditionIdController.collect(),
      requiredSkillId: requiredSkillIdController.collect(),
      requiredSkillRank: requiredSkillRankController.collect(),
      minLevel: minLevelController.collect(),
    );
  }

  @override
  void _logActivity(ActivityActionType action, SpellItemEnchantmentEntity t) {
    final log = ActivityLogEntity(
      module: 'spell_item_enchantment',
      actionType: action,
      entityName: t.nameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }
}
