import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_quest_info')
class QuestInfoEntity with _QuestInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('InfoName_lang_enUS')
  final String infoNameLangEnUS;

  @FoxyFullField('InfoName_lang_koKR')
  final String infoNameLangKoKR;

  @FoxyFullField('InfoName_lang_frFR')
  final String infoNameLangFrFR;

  @FoxyFullField('InfoName_lang_deDE')
  final String infoNameLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('InfoName_lang_zhCN')
  final String infoNameLangZhCN;

  @FoxyFullField('InfoName_lang_zhTW')
  final String infoNameLangZhTW;

  @FoxyFullField('InfoName_lang_esES')
  final String infoNameLangEsES;

  @FoxyFullField('InfoName_lang_esMX')
  final String infoNameLangEsMX;

  @FoxyFullField('InfoName_lang_ruRU')
  final String infoNameLangRuRU;

  @FoxyFullField('InfoName_lang_jaJP')
  final String infoNameLangJaJP;

  @FoxyFullField('InfoName_lang_ptPT')
  final String infoNameLangPtPT;

  @FoxyFullField('InfoName_lang_ptBR')
  final String infoNameLangPtBR;

  @FoxyFullField('InfoName_lang_itIT')
  final String infoNameLangItIT;

  @FoxyFullField('InfoName_lang_unk1')
  final String infoNameLangUnk1;

  @FoxyFullField('InfoName_lang_unk2')
  final String infoNameLangUnk2;

  @FoxyFullField('InfoName_lang_unk3')
  final String infoNameLangUnk3;

  @FoxyFullField('InfoName_lang_Flags')
  final int infoNameLangFlags;

  const QuestInfoEntity({
    this.id = 0,
    this.infoNameLangEnUS = '',
    this.infoNameLangKoKR = '',
    this.infoNameLangFrFR = '',
    this.infoNameLangDeDE = '',
    this.infoNameLangZhCN = '',
    this.infoNameLangZhTW = '',
    this.infoNameLangEsES = '',
    this.infoNameLangEsMX = '',
    this.infoNameLangRuRU = '',
    this.infoNameLangJaJP = '',
    this.infoNameLangPtPT = '',
    this.infoNameLangPtBR = '',
    this.infoNameLangItIT = '',
    this.infoNameLangUnk1 = '',
    this.infoNameLangUnk2 = '',
    this.infoNameLangUnk3 = '',
    this.infoNameLangFlags = 0,
  });

  factory QuestInfoEntity.fromJson(Map<String, dynamic> json) =>
      _QuestInfoEntityMixin.fromJson(json);
}
