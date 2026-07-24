import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'achievement_criteria_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_achievement_criteria')
class AchievementCriteriaEntity with _AchievementCriteriaEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Achievement_ID')
  final int achievementId;

  @FoxyBriefField()
  @FoxyFullField('Type')
  final int type;

  @FoxyFullField('Asset_ID')
  final int assetId;

  @FoxyFullField('Quantity')
  final int quantity;

  @FoxyFullField('Start_event')
  final int startEvent;

  @FoxyFullField('Start_asset')
  final int startAsset;

  @FoxyFullField('Fail_event')
  final int failEvent;

  @FoxyFullField('Fail_asset')
  final int failAsset;

  @FoxyFullField('Description_lang_enUS')
  final String descriptionLangEnUS;

  @FoxyFullField('Description_lang_koKR')
  final String descriptionLangKoKR;

  @FoxyFullField('Description_lang_frFR')
  final String descriptionLangFrFR;

  @FoxyFullField('Description_lang_deDE')
  final String descriptionLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('Description_lang_zhCN')
  final String descriptionLangZhCN;

  @FoxyFullField('Description_lang_zhTW')
  final String descriptionLangZhTW;

  @FoxyFullField('Description_lang_esES')
  final String descriptionLangEsES;

  @FoxyFullField('Description_lang_esMX')
  final String descriptionLangEsMX;

  @FoxyFullField('Description_lang_ruRU')
  final String descriptionLangRuRU;

  @FoxyFullField('Description_lang_jaJP')
  final String descriptionLangJaJP;

  @FoxyFullField('Description_lang_ptPT')
  final String descriptionLangPtPT;

  @FoxyFullField('Description_lang_ptBR')
  final String descriptionLangPtBR;

  @FoxyFullField('Description_lang_itIT')
  final String descriptionLangItIT;

  @FoxyFullField('Description_lang_unk1')
  final String descriptionLangUnk1;

  @FoxyFullField('Description_lang_unk2')
  final String descriptionLangUnk2;

  @FoxyFullField('Description_lang_unk3')
  final String descriptionLangUnk3;

  @FoxyFullField('Description_lang_Flags')
  final int descriptionLangFlags;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('Timer_start_event')
  final int timerStartEvent;

  @FoxyFullField('Timer_asset_ID')
  final int timerAssetId;

  @FoxyFullField('Timer_time')
  final int timerTime;

  @FoxyFullField('Ui_order')
  final int uiOrder;

  const AchievementCriteriaEntity({
    this.id = 0,
    this.achievementId = 0,
    this.type = 0,
    this.assetId = 0,
    this.quantity = 0,
    this.startEvent = 0,
    this.startAsset = 0,
    this.failEvent = 0,
    this.failAsset = 0,
    this.descriptionLangEnUS = '',
    this.descriptionLangKoKR = '',
    this.descriptionLangFrFR = '',
    this.descriptionLangDeDE = '',
    this.descriptionLangZhCN = '',
    this.descriptionLangZhTW = '',
    this.descriptionLangEsES = '',
    this.descriptionLangEsMX = '',
    this.descriptionLangRuRU = '',
    this.descriptionLangJaJP = '',
    this.descriptionLangPtPT = '',
    this.descriptionLangPtBR = '',
    this.descriptionLangItIT = '',
    this.descriptionLangUnk1 = '',
    this.descriptionLangUnk2 = '',
    this.descriptionLangUnk3 = '',
    this.descriptionLangFlags = 0,
    this.flags = 0,
    this.timerStartEvent = 0,
    this.timerAssetId = 0,
    this.timerTime = 0,
    this.uiOrder = 0,
  });

  factory AchievementCriteriaEntity.fromJson(Map<String, dynamic> json) =>
      _AchievementCriteriaEntityMixin.fromJson(json);
}
