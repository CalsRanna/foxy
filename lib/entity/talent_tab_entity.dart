import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'talent_tab_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_talent_tab')
class TalentTabEntity with _TalentTabEntityMixin {
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

  @FoxyFullField('SpellIconID')
  final int spellIconId;

  @FoxyFullField('RaceMask')
  final int raceMask;

  @FoxyBriefField()
  @FoxyFullField('ClassMask')
  final int classMask;

  @FoxyBriefField()
  @FoxyFullField('CategoryEnumID')
  final int categoryEnumId;

  @FoxyBriefField()
  @FoxyFullField('OrderIndex')
  final int orderIndex;

  @FoxyFullField('BackgroundFile')
  final String backgroundFile;

  const TalentTabEntity({
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
    this.spellIconId = 0,
    this.raceMask = 0,
    this.classMask = 0,
    this.categoryEnumId = 0,
    this.orderIndex = 0,
    this.backgroundFile = '',
  });

  factory TalentTabEntity.fromJson(Map<String, dynamic> json) =>
      _TalentTabEntityMixin.fromJson(json);
}
