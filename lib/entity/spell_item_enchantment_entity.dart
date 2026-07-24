import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_item_enchantment_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_spell_item_enchantment')
class SpellItemEnchantmentEntity with _SpellItemEnchantmentEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Charges')
  final int charges;

  @FoxyBriefField()
  @FoxyFullField('Effect0')
  final int effect0;

  @FoxyBriefField()
  @FoxyFullField('Effect1')
  final int effect1;

  @FoxyBriefField()
  @FoxyFullField('Effect2')
  final int effect2;

  @FoxyFullField('EffectPointsMin0')
  final int effectPointsMin0;

  @FoxyFullField('EffectPointsMin1')
  final int effectPointsMin1;

  @FoxyFullField('EffectPointsMin2')
  final int effectPointsMin2;

  @FoxyFullField('EffectPointsMax0')
  final int effectPointsMax0;

  @FoxyFullField('EffectPointsMax1')
  final int effectPointsMax1;

  @FoxyFullField('EffectPointsMax2')
  final int effectPointsMax2;

  @FoxyFullField('EffectArg0')
  final int effectArg0;

  @FoxyFullField('EffectArg1')
  final int effectArg1;

  @FoxyFullField('EffectArg2')
  final int effectArg2;

  @FoxyFullField('Name_lang_enUS')
  final String nameLangEnUS;

  @FoxyFullField('Name_lang_koKR')
  final String nameLangKoKR;

  @FoxyFullField('Name_lang_frFR')
  final String nameLangFrFR;

  @FoxyFullField('Name_lang_deDE')
  final String nameLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('Name_lang_zhCN')
  final String nameLangZhCN;

  @FoxyFullField('Name_lang_zhTW')
  final String nameLangZhTW;

  @FoxyFullField('Name_lang_esES')
  final String nameLangEsES;

  @FoxyFullField('Name_lang_esMX')
  final String nameLangEsMX;

  @FoxyFullField('Name_lang_ruRU')
  final String nameLangRuRU;

  @FoxyFullField('Name_lang_jaJP')
  final String nameLangJaJP;

  @FoxyFullField('Name_lang_ptPT')
  final String nameLangPtPT;

  @FoxyFullField('Name_lang_ptBR')
  final String nameLangPtBR;

  @FoxyFullField('Name_lang_itIT')
  final String nameLangItIT;

  @FoxyFullField('Name_lang_unk1')
  final String nameLangUnk1;

  @FoxyFullField('Name_lang_unk2')
  final String nameLangUnk2;

  @FoxyFullField('Name_lang_unk3')
  final String nameLangUnk3;

  @FoxyFullField('Name_lang_Flags')
  final int nameLangFlags;

  @FoxyFullField('ItemVisual')
  final int itemVisual;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('Src_itemID')
  final int srcItemId;

  @FoxyFullField('Condition_ID')
  final int conditionId;

  @FoxyFullField('RequiredSkillID')
  final int requiredSkillId;

  @FoxyFullField('RequiredSkillRank')
  final int requiredSkillRank;

  @FoxyFullField('MinLevel')
  final int minLevel;

  const SpellItemEnchantmentEntity({
    this.id = 0,
    this.charges = 0,
    this.effect0 = 0,
    this.effect1 = 0,
    this.effect2 = 0,
    this.effectPointsMin0 = 0,
    this.effectPointsMin1 = 0,
    this.effectPointsMin2 = 0,
    this.effectPointsMax0 = 0,
    this.effectPointsMax1 = 0,
    this.effectPointsMax2 = 0,
    this.effectArg0 = 0,
    this.effectArg1 = 0,
    this.effectArg2 = 0,
    this.nameLangEnUS = '',
    this.nameLangKoKR = '',
    this.nameLangFrFR = '',
    this.nameLangDeDE = '',
    this.nameLangZhCN = '',
    this.nameLangZhTW = '',
    this.nameLangEsES = '',
    this.nameLangEsMX = '',
    this.nameLangRuRU = '',
    this.nameLangJaJP = '',
    this.nameLangPtPT = '',
    this.nameLangPtBR = '',
    this.nameLangItIT = '',
    this.nameLangUnk1 = '',
    this.nameLangUnk2 = '',
    this.nameLangUnk3 = '',
    this.nameLangFlags = 0,
    this.itemVisual = 0,
    this.flags = 0,
    this.srcItemId = 0,
    this.conditionId = 0,
    this.requiredSkillId = 0,
    this.requiredSkillRank = 0,
    this.minLevel = 0,
  });

  factory SpellItemEnchantmentEntity.fromJson(Map<String, dynamic> json) =>
      _SpellItemEnchantmentEntityMixin.fromJson(json);
}
