import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_sort_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_quest_sort')
class QuestSortEntity with _QuestSortEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('SortName_lang_enUS')
  final String sortNameLangEnUS;

  @FoxyFullField('SortName_lang_koKR')
  final String sortNameLangKoKR;

  @FoxyFullField('SortName_lang_frFR')
  final String sortNameLangFrFR;

  @FoxyFullField('SortName_lang_deDE')
  final String sortNameLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('SortName_lang_zhCN')
  final String sortNameLangZhCN;

  @FoxyFullField('SortName_lang_zhTW')
  final String sortNameLangZhTW;

  @FoxyFullField('SortName_lang_esES')
  final String sortNameLangEsES;

  @FoxyFullField('SortName_lang_esMX')
  final String sortNameLangEsMX;

  @FoxyFullField('SortName_lang_ruRU')
  final String sortNameLangRuRU;

  @FoxyFullField('SortName_lang_jaJP')
  final String sortNameLangJaJP;

  @FoxyFullField('SortName_lang_ptPT')
  final String sortNameLangPtPT;

  @FoxyFullField('SortName_lang_ptBR')
  final String sortNameLangPtBR;

  @FoxyFullField('SortName_lang_itIT')
  final String sortNameLangItIT;

  @FoxyFullField('SortName_lang_unk1')
  final String sortNameLangUnk1;

  @FoxyFullField('SortName_lang_unk2')
  final String sortNameLangUnk2;

  @FoxyFullField('SortName_lang_unk3')
  final String sortNameLangUnk3;

  @FoxyFullField('SortName_lang_Flags')
  final int sortNameLangFlags;

  const QuestSortEntity({
    this.id = 0,
    this.sortNameLangEnUS = '',
    this.sortNameLangKoKR = '',
    this.sortNameLangFrFR = '',
    this.sortNameLangDeDE = '',
    this.sortNameLangZhCN = '',
    this.sortNameLangZhTW = '',
    this.sortNameLangEsES = '',
    this.sortNameLangEsMX = '',
    this.sortNameLangRuRU = '',
    this.sortNameLangJaJP = '',
    this.sortNameLangPtPT = '',
    this.sortNameLangPtBR = '',
    this.sortNameLangItIT = '',
    this.sortNameLangUnk1 = '',
    this.sortNameLangUnk2 = '',
    this.sortNameLangUnk3 = '',
    this.sortNameLangFlags = 0,
  });

  factory QuestSortEntity.fromJson(Map<String, dynamic> json) =>
      _QuestSortEntityMixin.fromJson(json);
}
