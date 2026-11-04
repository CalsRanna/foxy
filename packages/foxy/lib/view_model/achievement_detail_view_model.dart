import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'achievement_detail_view_model.g.dart';

@FoxyDetailViewModel(
  enums: {'faction'},
  flags: {'flags'},
  // Language flags retain their signal-based state.
  exclude: {'titleLangFlags', 'descriptionLangFlags', 'rewardLangFlags'},
)
class AchievementDetailViewModel
    with FieldControllerMixin, _AchievementDetailViewModelMixin {
  final titleLangFlags = signal<int>(0);
  final descriptionLangFlags = signal<int>(0);
  final rewardLangFlags = signal<int>(0);

  void applyDescriptionLocales(List<DbcLocaleFieldValue> values) {
    _applyLangControllers(
      values,
      enUS: descriptionLangEnUSController,
      koKR: descriptionLangKoKRController,
      frFR: descriptionLangFrFRController,
      deDE: descriptionLangDeDEController,
      zhCN: descriptionLangZhCNController,
      zhTW: descriptionLangZhTWController,
      esES: descriptionLangEsESController,
      esMX: descriptionLangEsMXController,
      ruRU: descriptionLangRuRUController,
      jaJP: descriptionLangJaJPController,
      ptPT: descriptionLangPtPTController,
      ptBR: descriptionLangPtBRController,
      itIT: descriptionLangItITController,
      unk1: descriptionLangUnk1Controller,
      unk2: descriptionLangUnk2Controller,
      unk3: descriptionLangUnk3Controller,
    );
    entity.value = _collectCandidate();
  }

  void applyRewardLocales(List<DbcLocaleFieldValue> values) {
    _applyLangControllers(
      values,
      enUS: rewardLangEnUSController,
      koKR: rewardLangKoKRController,
      frFR: rewardLangFrFRController,
      deDE: rewardLangDeDEController,
      zhCN: rewardLangZhCNController,
      zhTW: rewardLangZhTWController,
      esES: rewardLangEsESController,
      esMX: rewardLangEsMXController,
      ruRU: rewardLangRuRUController,
      jaJP: rewardLangJaJPController,
      ptPT: rewardLangPtPTController,
      ptBR: rewardLangPtBRController,
      itIT: rewardLangItITController,
      unk1: rewardLangUnk1Controller,
      unk2: rewardLangUnk2Controller,
      unk3: rewardLangUnk3Controller,
    );
    entity.value = _collectCandidate();
  }

  void applyTitleLocales(List<DbcLocaleFieldValue> values) {
    _applyLangControllers(
      values,
      enUS: titleLangEnUSController,
      koKR: titleLangKoKRController,
      frFR: titleLangFrFRController,
      deDE: titleLangDeDEController,
      zhCN: titleLangZhCNController,
      zhTW: titleLangZhTWController,
      esES: titleLangEsESController,
      esMX: titleLangEsMXController,
      ruRU: titleLangRuRUController,
      jaJP: titleLangJaJPController,
      ptPT: titleLangPtPTController,
      ptBR: titleLangPtBRController,
      itIT: titleLangItITController,
      unk1: titleLangUnk1Controller,
      unk2: titleLangUnk2Controller,
      unk3: titleLangUnk3Controller,
    );
    entity.value = _collectCandidate();
  }

  @override
  void _afterApplyCandidate(AchievementEntity achievement) {
    titleLangFlags.value = achievement.titleLangFlags;
    descriptionLangFlags.value = achievement.descriptionLangFlags;
    rewardLangFlags.value = achievement.rewardLangFlags;
  }

  void _applyLangControllers(
    List<DbcLocaleFieldValue> values, {
    required StringFieldController enUS,
    required StringFieldController koKR,
    required StringFieldController frFR,
    required StringFieldController deDE,
    required StringFieldController zhCN,
    required StringFieldController zhTW,
    required StringFieldController esES,
    required StringFieldController esMX,
    required StringFieldController ruRU,
    required StringFieldController jaJP,
    required StringFieldController ptPT,
    required StringFieldController ptBR,
    required StringFieldController itIT,
    required StringFieldController unk1,
    required StringFieldController unk2,
    required StringFieldController unk3,
  }) {
    enUS.init(values.valueOf('enUS'));
    koKR.init(values.valueOf('koKR'));
    frFR.init(values.valueOf('frFR'));
    deDE.init(values.valueOf('deDE'));
    zhCN.init(values.valueOf('zhCN'));
    zhTW.init(values.valueOf('zhTW'));
    esES.init(values.valueOf('esES'));
    esMX.init(values.valueOf('esMX'));
    ruRU.init(values.valueOf('ruRU'));
    jaJP.init(values.valueOf('jaJP'));
    ptPT.init(values.valueOf('ptPT'));
    ptBR.init(values.valueOf('ptBR'));
    itIT.init(values.valueOf('itIT'));
    unk1.init(values.valueOf('unk1'));
    unk2.init(values.valueOf('unk2'));
    unk3.init(values.valueOf('unk3'));
  }

  @override
  AchievementEntity _collectCandidate() {
    return super._collectCandidate().copyWith(
      titleLangFlags: titleLangFlags.value,
      descriptionLangFlags: descriptionLangFlags.value,
      rewardLangFlags: rewardLangFlags.value,
    );
  }

  @override
  void _logActivity(ActivityActionType action, AchievementEntity achievement) {
    final log = ActivityLogEntity(
      module: 'achievement',
      actionType: action,
      entityName: achievement.titleLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }
}
