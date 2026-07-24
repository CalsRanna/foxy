import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_set_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_set')
class ItemSetEntity with _ItemSetEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

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

  @FoxyFullField('ItemID0')
  final int itemId0;

  @FoxyFullField('ItemID1')
  final int itemId1;

  @FoxyFullField('ItemID2')
  final int itemId2;

  @FoxyFullField('ItemID3')
  final int itemId3;

  @FoxyFullField('ItemID4')
  final int itemId4;

  @FoxyFullField('ItemID5')
  final int itemId5;

  @FoxyFullField('ItemID6')
  final int itemId6;

  @FoxyFullField('ItemID7')
  final int itemId7;

  @FoxyFullField('ItemID8')
  final int itemId8;

  @FoxyFullField('ItemID9')
  final int itemId9;

  @FoxyFullField('ItemID10')
  final int itemId10;

  @FoxyFullField('ItemID11')
  final int itemId11;

  @FoxyFullField('ItemID12')
  final int itemId12;

  @FoxyFullField('ItemID13')
  final int itemId13;

  @FoxyFullField('ItemID14')
  final int itemId14;

  @FoxyFullField('ItemID15')
  final int itemId15;

  @FoxyFullField('ItemID16')
  final int itemId16;

  @FoxyFullField('SetSpellID0')
  final int setSpellId0;

  @FoxyFullField('SetSpellID1')
  final int setSpellId1;

  @FoxyFullField('SetSpellID2')
  final int setSpellId2;

  @FoxyFullField('SetSpellID3')
  final int setSpellId3;

  @FoxyFullField('SetSpellID4')
  final int setSpellId4;

  @FoxyFullField('SetSpellID5')
  final int setSpellId5;

  @FoxyFullField('SetSpellID6')
  final int setSpellId6;

  @FoxyFullField('SetSpellID7')
  final int setSpellId7;

  @FoxyFullField('SetThreshold0')
  final int setThreshold0;

  @FoxyFullField('SetThreshold1')
  final int setThreshold1;

  @FoxyFullField('SetThreshold2')
  final int setThreshold2;

  @FoxyFullField('SetThreshold3')
  final int setThreshold3;

  @FoxyFullField('SetThreshold4')
  final int setThreshold4;

  @FoxyFullField('SetThreshold5')
  final int setThreshold5;

  @FoxyFullField('SetThreshold6')
  final int setThreshold6;

  @FoxyFullField('SetThreshold7')
  final int setThreshold7;

  @FoxyBriefField()
  @FoxyFullField('RequiredSkill')
  final int requiredSkill;

  @FoxyBriefField()
  @FoxyFullField('RequiredSkillRank')
  final int requiredSkillRank;

  const ItemSetEntity({
    this.id = 0,
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
    this.itemId0 = 0,
    this.itemId1 = 0,
    this.itemId2 = 0,
    this.itemId3 = 0,
    this.itemId4 = 0,
    this.itemId5 = 0,
    this.itemId6 = 0,
    this.itemId7 = 0,
    this.itemId8 = 0,
    this.itemId9 = 0,
    this.itemId10 = 0,
    this.itemId11 = 0,
    this.itemId12 = 0,
    this.itemId13 = 0,
    this.itemId14 = 0,
    this.itemId15 = 0,
    this.itemId16 = 0,
    this.setSpellId0 = 0,
    this.setSpellId1 = 0,
    this.setSpellId2 = 0,
    this.setSpellId3 = 0,
    this.setSpellId4 = 0,
    this.setSpellId5 = 0,
    this.setSpellId6 = 0,
    this.setSpellId7 = 0,
    this.setThreshold0 = 0,
    this.setThreshold1 = 0,
    this.setThreshold2 = 0,
    this.setThreshold3 = 0,
    this.setThreshold4 = 0,
    this.setThreshold5 = 0,
    this.setThreshold6 = 0,
    this.setThreshold7 = 0,
    this.requiredSkill = 0,
    this.requiredSkillRank = 0,
  });

  factory ItemSetEntity.fromJson(Map<String, dynamic> json) =>
      _ItemSetEntityMixin.fromJson(json);
}
