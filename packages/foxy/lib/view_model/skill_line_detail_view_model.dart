import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/skill_line_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/skill_line_repository.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'skill_line_detail_view_model.g.dart';

@FoxyDetailViewModel(
  // Other locales are kept in entity and edited through the locale dialogs.
  exclude: {
    'displayNameLangEnUS',
    'displayNameLangKoKR',
    'displayNameLangFrFR',
    'displayNameLangDeDE',
    'displayNameLangZhTW',
    'displayNameLangEsES',
    'displayNameLangEsMX',
    'displayNameLangRuRU',
    'displayNameLangJaJP',
    'displayNameLangPtPT',
    'displayNameLangPtBR',
    'displayNameLangItIT',
    'displayNameLangUnk1',
    'displayNameLangUnk2',
    'displayNameLangUnk3',
    'descriptionLangEnUS',
    'descriptionLangKoKR',
    'descriptionLangFrFR',
    'descriptionLangDeDE',
    'descriptionLangZhTW',
    'descriptionLangEsES',
    'descriptionLangEsMX',
    'descriptionLangRuRU',
    'descriptionLangJaJP',
    'descriptionLangPtPT',
    'descriptionLangPtBR',
    'descriptionLangItIT',
    'descriptionLangUnk1',
    'descriptionLangUnk2',
    'descriptionLangUnk3',
    'alternateVerbLangEnUS',
    'alternateVerbLangKoKR',
    'alternateVerbLangFrFR',
    'alternateVerbLangDeDE',
    'alternateVerbLangZhTW',
    'alternateVerbLangEsES',
    'alternateVerbLangEsMX',
    'alternateVerbLangRuRU',
    'alternateVerbLangJaJP',
    'alternateVerbLangPtPT',
    'alternateVerbLangPtBR',
    'alternateVerbLangItIT',
    'alternateVerbLangUnk1',
    'alternateVerbLangUnk2',
    'alternateVerbLangUnk3',
  },
)
class SkillLineDetailViewModel
    with FieldControllerMixin, _SkillLineDetailViewModelMixin {
  /// After the dialog saves the display-name localization, merges it back
  /// into the current Entity and syncs the main-language input.
  void applyDisplayNameLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      displayNameLangEnUS: values.valueOf('enUS'),
      displayNameLangKoKR: values.valueOf('koKR'),
      displayNameLangFrFR: values.valueOf('frFR'),
      displayNameLangDeDE: values.valueOf('deDE'),
      displayNameLangZhCN: values.valueOf('zhCN'),
      displayNameLangZhTW: values.valueOf('zhTW'),
      displayNameLangEsES: values.valueOf('esES'),
      displayNameLangEsMX: values.valueOf('esMX'),
      displayNameLangRuRU: values.valueOf('ruRU'),
      displayNameLangJaJP: values.valueOf('jaJP'),
      displayNameLangPtPT: values.valueOf('ptPT'),
      displayNameLangPtBR: values.valueOf('ptBR'),
      displayNameLangItIT: values.valueOf('itIT'),
      displayNameLangUnk1: values.valueOf('unk1'),
      displayNameLangUnk2: values.valueOf('unk2'),
      displayNameLangUnk3: values.valueOf('unk3'),
    );
    displayNameLangZhCNController.init(values.zhCN);
  }

  /// After the dialog saves the description localization, merges it back
  /// into the current Entity and syncs the main-language input.
  void applyDescriptionLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      descriptionLangEnUS: values.valueOf('enUS'),
      descriptionLangKoKR: values.valueOf('koKR'),
      descriptionLangFrFR: values.valueOf('frFR'),
      descriptionLangDeDE: values.valueOf('deDE'),
      descriptionLangZhCN: values.valueOf('zhCN'),
      descriptionLangZhTW: values.valueOf('zhTW'),
      descriptionLangEsES: values.valueOf('esES'),
      descriptionLangEsMX: values.valueOf('esMX'),
      descriptionLangRuRU: values.valueOf('ruRU'),
      descriptionLangJaJP: values.valueOf('jaJP'),
      descriptionLangPtPT: values.valueOf('ptPT'),
      descriptionLangPtBR: values.valueOf('ptBR'),
      descriptionLangItIT: values.valueOf('itIT'),
      descriptionLangUnk1: values.valueOf('unk1'),
      descriptionLangUnk2: values.valueOf('unk2'),
      descriptionLangUnk3: values.valueOf('unk3'),
    );
    descriptionLangZhCNController.init(values.zhCN);
  }

  /// After the dialog saves the alternate-verb localization, merges it back
  /// into the current Entity and syncs the main-language input.
  void applyAlternateVerbLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      alternateVerbLangEnUS: values.valueOf('enUS'),
      alternateVerbLangKoKR: values.valueOf('koKR'),
      alternateVerbLangFrFR: values.valueOf('frFR'),
      alternateVerbLangDeDE: values.valueOf('deDE'),
      alternateVerbLangZhCN: values.valueOf('zhCN'),
      alternateVerbLangZhTW: values.valueOf('zhTW'),
      alternateVerbLangEsES: values.valueOf('esES'),
      alternateVerbLangEsMX: values.valueOf('esMX'),
      alternateVerbLangRuRU: values.valueOf('ruRU'),
      alternateVerbLangJaJP: values.valueOf('jaJP'),
      alternateVerbLangPtPT: values.valueOf('ptPT'),
      alternateVerbLangPtBR: values.valueOf('ptBR'),
      alternateVerbLangItIT: values.valueOf('itIT'),
      alternateVerbLangUnk1: values.valueOf('unk1'),
      alternateVerbLangUnk2: values.valueOf('unk2'),
      alternateVerbLangUnk3: values.valueOf('unk3'),
    );
    alternateVerbLangZhCNController.init(values.zhCN);
  }

  @override
  SkillLineEntity _collectCandidate() {
    // Overlay UI fields from the loaded entity, so hidden columns such as
    // multi-language ones are never cleared.
    return entity.value!.copyWith(
      id: idController.collect(),
      categoryId: categoryIdController.collect(),
      skillCostsId: skillCostsIdController.collect(),
      spellIconId: spellIconIdController.collect(),
      canLink: canLinkController.collect(),
      displayNameLangZhCN: displayNameLangZhCNController.collect(),
      displayNameLangFlags: displayNameLangFlagsController.collect(),
      descriptionLangZhCN: descriptionLangZhCNController.collect(),
      descriptionLangFlags: descriptionLangFlagsController.collect(),
      alternateVerbLangZhCN: alternateVerbLangZhCNController.collect(),
      alternateVerbLangFlags: alternateVerbLangFlagsController.collect(),
    );
  }

  @override
  void _logActivity(ActivityActionType action, SkillLineEntity t) {
    final log = ActivityLogEntity(
      module: 'skill_line',
      actionType: action,
      entityName: t.displayNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }
}
