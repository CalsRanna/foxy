class QuestSortEntity {
  final int id;
  final String sortNameLangEnUS;
  final String sortNameLangKoKR;
  final String sortNameLangFrFR;
  final String sortNameLangDeDE;
  final String sortNameLangZhCN;
  final String sortNameLangZhTW;
  final String sortNameLangEsES;
  final String sortNameLangEsMX;
  final String sortNameLangRuRU;
  final String sortNameLangJaJP;
  final String sortNameLangPtPT;
  final String sortNameLangPtBR;
  final String sortNameLangItIT;
  final String sortNameLangUnk1;
  final String sortNameLangUnk2;
  final String sortNameLangUnk3;
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

  factory QuestSortEntity.fromJson(Map<String, dynamic> json) {
    return QuestSortEntity(
      id: json['ID'] ?? 0,
      sortNameLangEnUS: json['SortName_lang_enUS'] ?? '',
      sortNameLangKoKR: json['SortName_lang_koKR'] ?? '',
      sortNameLangFrFR: json['SortName_lang_frFR'] ?? '',
      sortNameLangDeDE: json['SortName_lang_deDE'] ?? '',
      sortNameLangZhCN: json['SortName_lang_zhCN'] ?? '',
      sortNameLangZhTW: json['SortName_lang_zhTW'] ?? '',
      sortNameLangEsES: json['SortName_lang_esES'] ?? '',
      sortNameLangEsMX: json['SortName_lang_esMX'] ?? '',
      sortNameLangRuRU: json['SortName_lang_ruRU'] ?? '',
      sortNameLangJaJP: json['SortName_lang_jaJP'] ?? '',
      sortNameLangPtPT: json['SortName_lang_ptPT'] ?? '',
      sortNameLangPtBR: json['SortName_lang_ptBR'] ?? '',
      sortNameLangItIT: json['SortName_lang_itIT'] ?? '',
      sortNameLangUnk1: json['SortName_lang_unk1'] ?? '',
      sortNameLangUnk2: json['SortName_lang_unk2'] ?? '',
      sortNameLangUnk3: json['SortName_lang_unk3'] ?? '',
      sortNameLangFlags: json['SortName_lang_Flags'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SortName_lang_enUS': sortNameLangEnUS,
      'SortName_lang_koKR': sortNameLangKoKR,
      'SortName_lang_frFR': sortNameLangFrFR,
      'SortName_lang_deDE': sortNameLangDeDE,
      'SortName_lang_zhCN': sortNameLangZhCN,
      'SortName_lang_zhTW': sortNameLangZhTW,
      'SortName_lang_esES': sortNameLangEsES,
      'SortName_lang_esMX': sortNameLangEsMX,
      'SortName_lang_ruRU': sortNameLangRuRU,
      'SortName_lang_jaJP': sortNameLangJaJP,
      'SortName_lang_ptPT': sortNameLangPtPT,
      'SortName_lang_ptBR': sortNameLangPtBR,
      'SortName_lang_itIT': sortNameLangItIT,
      'SortName_lang_unk1': sortNameLangUnk1,
      'SortName_lang_unk2': sortNameLangUnk2,
      'SortName_lang_unk3': sortNameLangUnk3,
      'SortName_lang_Flags': sortNameLangFlags,
    };
  }

  QuestSortEntity copyWith({
    int? id,
    String? sortNameLangEnUS,
    String? sortNameLangKoKR,
    String? sortNameLangFrFR,
    String? sortNameLangDeDE,
    String? sortNameLangZhCN,
    String? sortNameLangZhTW,
    String? sortNameLangEsES,
    String? sortNameLangEsMX,
    String? sortNameLangRuRU,
    String? sortNameLangJaJP,
    String? sortNameLangPtPT,
    String? sortNameLangPtBR,
    String? sortNameLangItIT,
    String? sortNameLangUnk1,
    String? sortNameLangUnk2,
    String? sortNameLangUnk3,
    int? sortNameLangFlags,
  }) {
    return QuestSortEntity(
      id: id ?? this.id,
      sortNameLangEnUS: sortNameLangEnUS ?? this.sortNameLangEnUS,
      sortNameLangKoKR: sortNameLangKoKR ?? this.sortNameLangKoKR,
      sortNameLangFrFR: sortNameLangFrFR ?? this.sortNameLangFrFR,
      sortNameLangDeDE: sortNameLangDeDE ?? this.sortNameLangDeDE,
      sortNameLangZhCN: sortNameLangZhCN ?? this.sortNameLangZhCN,
      sortNameLangZhTW: sortNameLangZhTW ?? this.sortNameLangZhTW,
      sortNameLangEsES: sortNameLangEsES ?? this.sortNameLangEsES,
      sortNameLangEsMX: sortNameLangEsMX ?? this.sortNameLangEsMX,
      sortNameLangRuRU: sortNameLangRuRU ?? this.sortNameLangRuRU,
      sortNameLangJaJP: sortNameLangJaJP ?? this.sortNameLangJaJP,
      sortNameLangPtPT: sortNameLangPtPT ?? this.sortNameLangPtPT,
      sortNameLangPtBR: sortNameLangPtBR ?? this.sortNameLangPtBR,
      sortNameLangItIT: sortNameLangItIT ?? this.sortNameLangItIT,
      sortNameLangUnk1: sortNameLangUnk1 ?? this.sortNameLangUnk1,
      sortNameLangUnk2: sortNameLangUnk2 ?? this.sortNameLangUnk2,
      sortNameLangUnk3: sortNameLangUnk3 ?? this.sortNameLangUnk3,
      sortNameLangFlags: sortNameLangFlags ?? this.sortNameLangFlags,
    );
  }
}

/// 任务排序列表/Picker 展示模型
class BriefQuestSortEntity {
  final int id;
  final String sortNameLangZhCN;

  const BriefQuestSortEntity({this.id = 0, this.sortNameLangZhCN = ''});

  factory BriefQuestSortEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestSortEntity(
      id: json['ID'] ?? 0,
      sortNameLangZhCN: json['SortName_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'SortName_lang_zhCN': sortNameLangZhCN};
  }

  BriefQuestSortEntity copyWith({int? id, String? sortNameLangZhCN}) {
    return BriefQuestSortEntity(
      id: id ?? this.id,
      sortNameLangZhCN: sortNameLangZhCN ?? this.sortNameLangZhCN,
    );
  }
}
