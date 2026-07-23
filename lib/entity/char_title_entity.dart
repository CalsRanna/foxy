// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'char_title_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_char_titles')
class CharTitleEntity with _CharTitleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Condition_ID')
  final int conditionId;

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

  @FoxyFullField('Name1_lang_enUS')
  final String name1LangEnUS;

  @FoxyFullField('Name1_lang_koKR')
  final String name1LangKoKR;

  @FoxyFullField('Name1_lang_frFR')
  final String name1LangFrFR;

  @FoxyFullField('Name1_lang_deDE')
  final String name1LangDeDE;

  @FoxyFullField('Name1_lang_zhCN')
  final String name1LangZhCN;

  @FoxyFullField('Name1_lang_zhTW')
  final String name1LangZhTW;

  @FoxyFullField('Name1_lang_esES')
  final String name1LangEsES;

  @FoxyFullField('Name1_lang_esMX')
  final String name1LangEsMX;

  @FoxyFullField('Name1_lang_ruRU')
  final String name1LangRuRU;

  @FoxyFullField('Name1_lang_jaJP')
  final String name1LangJaJP;

  @FoxyFullField('Name1_lang_ptPT')
  final String name1LangPtPT;

  @FoxyFullField('Name1_lang_ptBR')
  final String name1LangPtBR;

  @FoxyFullField('Name1_lang_itIT')
  final String name1LangItIT;

  @FoxyFullField('Name1_lang_unk1')
  final String name1LangUnk1;

  @FoxyFullField('Name1_lang_unk2')
  final String name1LangUnk2;

  @FoxyFullField('Name1_lang_unk3')
  final String name1LangUnk3;

  @FoxyFullField('Name1_lang_Flags')
  final int name1LangFlags;

  @FoxyFullField('Mask_ID')
  final int maskId;

  const CharTitleEntity({
    this.id = 0,
    this.conditionId = 0,
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
    this.name1LangEnUS = '',
    this.name1LangKoKR = '',
    this.name1LangFrFR = '',
    this.name1LangDeDE = '',
    this.name1LangZhCN = '',
    this.name1LangZhTW = '',
    this.name1LangEsES = '',
    this.name1LangEsMX = '',
    this.name1LangRuRU = '',
    this.name1LangJaJP = '',
    this.name1LangPtPT = '',
    this.name1LangPtBR = '',
    this.name1LangItIT = '',
    this.name1LangUnk1 = '',
    this.name1LangUnk2 = '',
    this.name1LangUnk3 = '',
    this.name1LangFlags = 0,
    this.maskId = 0,
  });

  factory CharTitleEntity.fromJson(Map<String, dynamic> json) =>
      _CharTitleEntityMixin.fromJson(json);
}
