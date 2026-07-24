// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'emote_text_data_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_emotes_text_data')
class EmoteTextDataEntity with _EmoteTextDataEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Text_lang_enUS')
  final String textLangEnUS;

  @FoxyFullField('Text_lang_koKR')
  final String textLangKoKR;

  @FoxyFullField('Text_lang_frFR')
  final String textLangFrFR;

  @FoxyFullField('Text_lang_deDE')
  final String textLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('Text_lang_zhCN')
  final String textLangZhCN;

  @FoxyFullField('Text_lang_zhTW')
  final String textLangZhTW;

  @FoxyFullField('Text_lang_esES')
  final String textLangEsES;

  @FoxyFullField('Text_lang_esMX')
  final String textLangEsMX;

  @FoxyFullField('Text_lang_ruRU')
  final String textLangRuRU;

  @FoxyFullField('Text_lang_jaJP')
  final String textLangJaJP;

  @FoxyFullField('Text_lang_ptPT')
  final String textLangPtPT;

  @FoxyFullField('Text_lang_ptBR')
  final String textLangPtBR;

  @FoxyFullField('Text_lang_itIT')
  final String textLangItIT;

  @FoxyFullField('Text_lang_unk1')
  final String textLangUnk1;

  @FoxyFullField('Text_lang_unk2')
  final String textLangUnk2;

  @FoxyFullField('Text_lang_unk3')
  final String textLangUnk3;

  @FoxyFullField('Text_lang_Flags')
  final int textLangFlags;

  const EmoteTextDataEntity({
    this.id = 0,
    this.textLangEnUS = '',
    this.textLangKoKR = '',
    this.textLangFrFR = '',
    this.textLangDeDE = '',
    this.textLangZhCN = '',
    this.textLangZhTW = '',
    this.textLangEsES = '',
    this.textLangEsMX = '',
    this.textLangRuRU = '',
    this.textLangJaJP = '',
    this.textLangPtPT = '',
    this.textLangPtBR = '',
    this.textLangItIT = '',
    this.textLangUnk1 = '',
    this.textLangUnk2 = '',
    this.textLangUnk3 = '',
    this.textLangFlags = 0,
  });

  factory EmoteTextDataEntity.fromJson(Map<String, dynamic> json) =>
      _EmoteTextDataEntityMixin.fromJson(json);
}
