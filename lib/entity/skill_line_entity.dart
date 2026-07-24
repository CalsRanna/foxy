// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'skill_line_entity.g.dart';

@FoxyFullEntity(table: 'foxy.dbc_skill_line')
class SkillLineEntity with _SkillLineEntityMixin {
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('CategoryID')
  final int categoryId;

  @FoxyFullField('SkillCostsID')
  final int skillCostsId;

  @FoxyFullField('DisplayName_lang_enUS')
  final String displayNameLangEnUS;

  @FoxyFullField('DisplayName_lang_koKR')
  final String displayNameLangKoKR;

  @FoxyFullField('DisplayName_lang_frFR')
  final String displayNameLangFrFR;

  @FoxyFullField('DisplayName_lang_deDE')
  final String displayNameLangDeDE;

  @FoxyFullField('DisplayName_lang_zhCN')
  final String displayNameLangZhCN;

  @FoxyFullField('DisplayName_lang_zhTW')
  final String displayNameLangZhTW;

  @FoxyFullField('DisplayName_lang_esES')
  final String displayNameLangEsES;

  @FoxyFullField('DisplayName_lang_esMX')
  final String displayNameLangEsMX;

  @FoxyFullField('DisplayName_lang_ruRU')
  final String displayNameLangRuRU;

  @FoxyFullField('DisplayName_lang_jaJP')
  final String displayNameLangJaJP;

  @FoxyFullField('DisplayName_lang_ptPT')
  final String displayNameLangPtPT;

  @FoxyFullField('DisplayName_lang_ptBR')
  final String displayNameLangPtBR;

  @FoxyFullField('DisplayName_lang_itIT')
  final String displayNameLangItIT;

  @FoxyFullField('DisplayName_lang_unk1')
  final String displayNameLangUnk1;

  @FoxyFullField('DisplayName_lang_unk2')
  final String displayNameLangUnk2;

  @FoxyFullField('DisplayName_lang_unk3')
  final String displayNameLangUnk3;

  @FoxyFullField('DisplayName_lang_Flags')
  final int displayNameLangFlags;

  @FoxyFullField('Description_lang_enUS')
  final String descriptionLangEnUS;

  @FoxyFullField('Description_lang_koKR')
  final String descriptionLangKoKR;

  @FoxyFullField('Description_lang_frFR')
  final String descriptionLangFrFR;

  @FoxyFullField('Description_lang_deDE')
  final String descriptionLangDeDE;

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

  @FoxyFullField('SpellIconID')
  final int spellIconId;

  @FoxyFullField('AlternateVerb_lang_enUS')
  final String alternateVerbLangEnUS;

  @FoxyFullField('AlternateVerb_lang_koKR')
  final String alternateVerbLangKoKR;

  @FoxyFullField('AlternateVerb_lang_frFR')
  final String alternateVerbLangFrFR;

  @FoxyFullField('AlternateVerb_lang_deDE')
  final String alternateVerbLangDeDE;

  @FoxyFullField('AlternateVerb_lang_zhCN')
  final String alternateVerbLangZhCN;

  @FoxyFullField('AlternateVerb_lang_zhTW')
  final String alternateVerbLangZhTW;

  @FoxyFullField('AlternateVerb_lang_esES')
  final String alternateVerbLangEsES;

  @FoxyFullField('AlternateVerb_lang_esMX')
  final String alternateVerbLangEsMX;

  @FoxyFullField('AlternateVerb_lang_ruRU')
  final String alternateVerbLangRuRU;

  @FoxyFullField('AlternateVerb_lang_jaJP')
  final String alternateVerbLangJaJP;

  @FoxyFullField('AlternateVerb_lang_ptPT')
  final String alternateVerbLangPtPT;

  @FoxyFullField('AlternateVerb_lang_ptBR')
  final String alternateVerbLangPtBR;

  @FoxyFullField('AlternateVerb_lang_itIT')
  final String alternateVerbLangItIT;

  @FoxyFullField('AlternateVerb_lang_unk1')
  final String alternateVerbLangUnk1;

  @FoxyFullField('AlternateVerb_lang_unk2')
  final String alternateVerbLangUnk2;

  @FoxyFullField('AlternateVerb_lang_unk3')
  final String alternateVerbLangUnk3;

  @FoxyFullField('AlternateVerb_lang_Flags')
  final int alternateVerbLangFlags;

  @FoxyFullField('CanLink')
  final int canLink;

  const SkillLineEntity({
    this.id = 0,
    this.categoryId = 0,
    this.skillCostsId = 0,
    this.displayNameLangEnUS = '',
    this.displayNameLangKoKR = '',
    this.displayNameLangFrFR = '',
    this.displayNameLangDeDE = '',
    this.displayNameLangZhCN = '',
    this.displayNameLangZhTW = '',
    this.displayNameLangEsES = '',
    this.displayNameLangEsMX = '',
    this.displayNameLangRuRU = '',
    this.displayNameLangJaJP = '',
    this.displayNameLangPtPT = '',
    this.displayNameLangPtBR = '',
    this.displayNameLangItIT = '',
    this.displayNameLangUnk1 = '',
    this.displayNameLangUnk2 = '',
    this.displayNameLangUnk3 = '',
    this.displayNameLangFlags = 0,
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
    this.spellIconId = 0,
    this.alternateVerbLangEnUS = '',
    this.alternateVerbLangKoKR = '',
    this.alternateVerbLangFrFR = '',
    this.alternateVerbLangDeDE = '',
    this.alternateVerbLangZhCN = '',
    this.alternateVerbLangZhTW = '',
    this.alternateVerbLangEsES = '',
    this.alternateVerbLangEsMX = '',
    this.alternateVerbLangRuRU = '',
    this.alternateVerbLangJaJP = '',
    this.alternateVerbLangPtPT = '',
    this.alternateVerbLangPtBR = '',
    this.alternateVerbLangItIT = '',
    this.alternateVerbLangUnk1 = '',
    this.alternateVerbLangUnk2 = '',
    this.alternateVerbLangUnk3 = '',
    this.alternateVerbLangFlags = 0,
    this.canLink = 0,
  });

  factory SkillLineEntity.fromJson(Map<String, dynamic> json) =>
      _SkillLineEntityMixin.fromJson(json);
}
