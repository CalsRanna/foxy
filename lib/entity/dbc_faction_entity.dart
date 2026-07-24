import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'dbc_faction_entity.g.dart';

/// DBC 阵营 — 对应 foxy.dbc_faction 表

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_faction')
class DbcFactionEntity with _DbcFactionEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('ReputationIndex')
  final int reputationIndex;

  @FoxyFullField('ReputationRaceMask0')
  final int reputationRaceMask0;

  @FoxyFullField('ReputationRaceMask1')
  final int reputationRaceMask1;

  @FoxyFullField('ReputationRaceMask2')
  final int reputationRaceMask2;

  @FoxyFullField('ReputationRaceMask3')
  final int reputationRaceMask3;

  @FoxyFullField('ReputationClassMask0')
  final int reputationClassMask0;

  @FoxyFullField('ReputationClassMask1')
  final int reputationClassMask1;

  @FoxyFullField('ReputationClassMask2')
  final int reputationClassMask2;

  @FoxyFullField('ReputationClassMask3')
  final int reputationClassMask3;

  @FoxyFullField('ReputationBase0')
  final int reputationBase0;

  @FoxyFullField('ReputationBase1')
  final int reputationBase1;

  @FoxyFullField('ReputationBase2')
  final int reputationBase2;

  @FoxyFullField('ReputationBase3')
  final int reputationBase3;

  @FoxyFullField('ReputationFlags0')
  final int reputationFlags0;

  @FoxyFullField('ReputationFlags1')
  final int reputationFlags1;

  @FoxyFullField('ReputationFlags2')
  final int reputationFlags2;

  @FoxyFullField('ReputationFlags3')
  final int reputationFlags3;

  @FoxyFullField('ParentFactionID')
  final int parentFactionId;

  @FoxyFullField('ParentFactionMod0')
  final double parentFactionMod0;

  @FoxyFullField('ParentFactionMod1')
  final double parentFactionMod1;

  @FoxyFullField('ParentFactionCap0')
  final int parentFactionCap0;

  @FoxyFullField('ParentFactionCap1')
  final int parentFactionCap1;

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

  const DbcFactionEntity({
    this.id = 0,
    this.reputationIndex = 0,
    this.reputationRaceMask0 = 0,
    this.reputationRaceMask1 = 0,
    this.reputationRaceMask2 = 0,
    this.reputationRaceMask3 = 0,
    this.reputationClassMask0 = 0,
    this.reputationClassMask1 = 0,
    this.reputationClassMask2 = 0,
    this.reputationClassMask3 = 0,
    this.reputationBase0 = 0,
    this.reputationBase1 = 0,
    this.reputationBase2 = 0,
    this.reputationBase3 = 0,
    this.reputationFlags0 = 0,
    this.reputationFlags1 = 0,
    this.reputationFlags2 = 0,
    this.reputationFlags3 = 0,
    this.parentFactionId = 0,
    this.parentFactionMod0 = 0.0,
    this.parentFactionMod1 = 0.0,
    this.parentFactionCap0 = 0,
    this.parentFactionCap1 = 0,
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
  });

  factory DbcFactionEntity.fromJson(Map<String, dynamic> json) =>
      _DbcFactionEntityMixin.fromJson(json);
}
