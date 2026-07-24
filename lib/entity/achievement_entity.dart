import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'achievement_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_achievement')
class AchievementEntity with _AchievementEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Faction')
  final int faction;

  @FoxyFullField('Instance_ID')
  final int instanceId;

  @FoxyFullField('Supercedes')
  final int supercedes;

  @FoxyFullField('Title_lang_enUS')
  final String titleLangEnUS;

  @FoxyFullField('Title_lang_koKR')
  final String titleLangKoKR;

  @FoxyFullField('Title_lang_frFR')
  final String titleLangFrFR;

  @FoxyFullField('Title_lang_deDE')
  final String titleLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('Title_lang_zhCN')
  final String titleLangZhCN;

  @FoxyFullField('Title_lang_zhTW')
  final String titleLangZhTW;

  @FoxyFullField('Title_lang_esES')
  final String titleLangEsES;

  @FoxyFullField('Title_lang_esMX')
  final String titleLangEsMX;

  @FoxyFullField('Title_lang_ruRU')
  final String titleLangRuRU;

  @FoxyFullField('Title_lang_jaJP')
  final String titleLangJaJP;

  @FoxyFullField('Title_lang_ptPT')
  final String titleLangPtPT;

  @FoxyFullField('Title_lang_ptBR')
  final String titleLangPtBR;

  @FoxyFullField('Title_lang_itIT')
  final String titleLangItIT;

  @FoxyFullField('Title_lang_unk1')
  final String titleLangUnk1;

  @FoxyFullField('Title_lang_unk2')
  final String titleLangUnk2;

  @FoxyFullField('Title_lang_unk3')
  final String titleLangUnk3;

  @FoxyFullField('Title_lang_Flags')
  final int titleLangFlags;

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

  @FoxyFullField('Category')
  final int category;

  @FoxyFullField('Points')
  final int points;

  @FoxyFullField('Ui_order')
  final int uiOrder;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('IconID')
  final int iconId;

  @FoxyFullField('Reward_lang_enUS')
  final String rewardLangEnUS;

  @FoxyFullField('Reward_lang_koKR')
  final String rewardLangKoKR;

  @FoxyFullField('Reward_lang_frFR')
  final String rewardLangFrFR;

  @FoxyFullField('Reward_lang_deDE')
  final String rewardLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('Reward_lang_zhCN')
  final String rewardLangZhCN;

  @FoxyFullField('Reward_lang_zhTW')
  final String rewardLangZhTW;

  @FoxyFullField('Reward_lang_esES')
  final String rewardLangEsES;

  @FoxyFullField('Reward_lang_esMX')
  final String rewardLangEsMX;

  @FoxyFullField('Reward_lang_ruRU')
  final String rewardLangRuRU;

  @FoxyFullField('Reward_lang_jaJP')
  final String rewardLangJaJP;

  @FoxyFullField('Reward_lang_ptPT')
  final String rewardLangPtPT;

  @FoxyFullField('Reward_lang_ptBR')
  final String rewardLangPtBR;

  @FoxyFullField('Reward_lang_itIT')
  final String rewardLangItIT;

  @FoxyFullField('Reward_lang_unk1')
  final String rewardLangUnk1;

  @FoxyFullField('Reward_lang_unk2')
  final String rewardLangUnk2;

  @FoxyFullField('Reward_lang_unk3')
  final String rewardLangUnk3;

  @FoxyFullField('Reward_lang_Flags')
  final int rewardLangFlags;

  @FoxyFullField('Minimum_criteria')
  final int minimumCriteria;

  @FoxyFullField('Shares_criteria')
  final int sharesCriteria;

  const AchievementEntity({
    this.id = 0,
    this.faction = -1,
    this.instanceId = -1,
    this.supercedes = 0,
    this.titleLangEnUS = '',
    this.titleLangKoKR = '',
    this.titleLangFrFR = '',
    this.titleLangDeDE = '',
    this.titleLangZhCN = '',
    this.titleLangZhTW = '',
    this.titleLangEsES = '',
    this.titleLangEsMX = '',
    this.titleLangRuRU = '',
    this.titleLangJaJP = '',
    this.titleLangPtPT = '',
    this.titleLangPtBR = '',
    this.titleLangItIT = '',
    this.titleLangUnk1 = '',
    this.titleLangUnk2 = '',
    this.titleLangUnk3 = '',
    this.titleLangFlags = 0,
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
    this.category = 0,
    this.points = 0,
    this.uiOrder = 0,
    this.flags = 0,
    this.iconId = 0,
    this.rewardLangEnUS = '',
    this.rewardLangKoKR = '',
    this.rewardLangFrFR = '',
    this.rewardLangDeDE = '',
    this.rewardLangZhCN = '',
    this.rewardLangZhTW = '',
    this.rewardLangEsES = '',
    this.rewardLangEsMX = '',
    this.rewardLangRuRU = '',
    this.rewardLangJaJP = '',
    this.rewardLangPtPT = '',
    this.rewardLangPtBR = '',
    this.rewardLangItIT = '',
    this.rewardLangUnk1 = '',
    this.rewardLangUnk2 = '',
    this.rewardLangUnk3 = '',
    this.rewardLangFlags = 0,
    this.minimumCriteria = 0,
    this.sharesCriteria = 0,
  });

  factory AchievementEntity.fromJson(Map<String, dynamic> json) =>
      _AchievementEntityMixin.fromJson(json);
}
