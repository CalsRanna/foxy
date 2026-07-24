import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_range_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_spell_range')
class SpellRangeEntity with _SpellRangeEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('RangeMin0')
  final double rangeMin0;

  @FoxyFullField('RangeMin1')
  final double rangeMin1;

  @FoxyBriefField()
  @FoxyFullField('RangeMax0')
  final double rangeMax0;

  @FoxyFullField('RangeMax1')
  final double rangeMax1;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('DisplayName_lang_enUS')
  final String displayNameLangEnUS;

  @FoxyFullField('DisplayName_lang_koKR')
  final String displayNameLangKoKR;

  @FoxyFullField('DisplayName_lang_frFR')
  final String displayNameLangFrFR;

  @FoxyFullField('DisplayName_lang_deDE')
  final String displayNameLangDeDE;

  @FoxyBriefField()
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

  @FoxyFullField('DisplayNameShort_lang_enUS')
  final String displayNameShortLangEnUS;

  @FoxyFullField('DisplayNameShort_lang_koKR')
  final String displayNameShortLangKoKR;

  @FoxyFullField('DisplayNameShort_lang_frFR')
  final String displayNameShortLangFrFR;

  @FoxyFullField('DisplayNameShort_lang_deDE')
  final String displayNameShortLangDeDE;

  @FoxyFullField('DisplayNameShort_lang_zhCN')
  final String displayNameShortLangZhCN;

  @FoxyFullField('DisplayNameShort_lang_zhTW')
  final String displayNameShortLangZhTW;

  @FoxyFullField('DisplayNameShort_lang_esES')
  final String displayNameShortLangEsES;

  @FoxyFullField('DisplayNameShort_lang_esMX')
  final String displayNameShortLangEsMX;

  @FoxyFullField('DisplayNameShort_lang_ruRU')
  final String displayNameShortLangRuRU;

  @FoxyFullField('DisplayNameShort_lang_jaJP')
  final String displayNameShortLangJaJP;

  @FoxyFullField('DisplayNameShort_lang_ptPT')
  final String displayNameShortLangPtPT;

  @FoxyFullField('DisplayNameShort_lang_ptBR')
  final String displayNameShortLangPtBR;

  @FoxyFullField('DisplayNameShort_lang_itIT')
  final String displayNameShortLangItIT;

  @FoxyFullField('DisplayNameShort_lang_unk1')
  final String displayNameShortLangUnk1;

  @FoxyFullField('DisplayNameShort_lang_unk2')
  final String displayNameShortLangUnk2;

  @FoxyFullField('DisplayNameShort_lang_unk3')
  final String displayNameShortLangUnk3;

  @FoxyFullField('DisplayNameShort_lang_Flags')
  final int displayNameShortLangFlags;

  const SpellRangeEntity({
    this.id = 0,
    this.rangeMin0 = 0.0,
    this.rangeMin1 = 0.0,
    this.rangeMax0 = 0.0,
    this.rangeMax1 = 0.0,
    this.flags = 0,
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
    this.displayNameShortLangEnUS = '',
    this.displayNameShortLangKoKR = '',
    this.displayNameShortLangFrFR = '',
    this.displayNameShortLangDeDE = '',
    this.displayNameShortLangZhCN = '',
    this.displayNameShortLangZhTW = '',
    this.displayNameShortLangEsES = '',
    this.displayNameShortLangEsMX = '',
    this.displayNameShortLangRuRU = '',
    this.displayNameShortLangJaJP = '',
    this.displayNameShortLangPtPT = '',
    this.displayNameShortLangPtBR = '',
    this.displayNameShortLangItIT = '',
    this.displayNameShortLangUnk1 = '',
    this.displayNameShortLangUnk2 = '',
    this.displayNameShortLangUnk3 = '',
    this.displayNameShortLangFlags = 0,
  });

  factory SpellRangeEntity.fromJson(Map<String, dynamic> json) =>
      _SpellRangeEntityMixin.fromJson(json);
}
