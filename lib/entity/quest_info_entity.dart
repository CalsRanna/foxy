class QuestInfoEntity {
  final int id;
  final String infoNameLangEnUS;
  final String infoNameLangKoKR;
  final String infoNameLangFrFR;
  final String infoNameLangDeDE;
  final String infoNameLangZhCN;
  final String infoNameLangZhTW;
  final String infoNameLangEsES;
  final String infoNameLangEsMX;
  final String infoNameLangRuRU;
  final String infoNameLangJaJP;
  final String infoNameLangPtPT;
  final String infoNameLangPtBR;
  final String infoNameLangItIT;
  final String infoNameLangUnk1;
  final String infoNameLangUnk2;
  final String infoNameLangUnk3;
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

  factory QuestInfoEntity.fromJson(Map<String, dynamic> json) {
    return QuestInfoEntity(
      id: json['ID'] ?? 0,
      infoNameLangEnUS: json['InfoName_lang_enUS'] ?? '',
      infoNameLangKoKR: json['InfoName_lang_koKR'] ?? '',
      infoNameLangFrFR: json['InfoName_lang_frFR'] ?? '',
      infoNameLangDeDE: json['InfoName_lang_deDE'] ?? '',
      infoNameLangZhCN: json['InfoName_lang_zhCN'] ?? '',
      infoNameLangZhTW: json['InfoName_lang_zhTW'] ?? '',
      infoNameLangEsES: json['InfoName_lang_esES'] ?? '',
      infoNameLangEsMX: json['InfoName_lang_esMX'] ?? '',
      infoNameLangRuRU: json['InfoName_lang_ruRU'] ?? '',
      infoNameLangJaJP: json['InfoName_lang_jaJP'] ?? '',
      infoNameLangPtPT: json['InfoName_lang_ptPT'] ?? '',
      infoNameLangPtBR: json['InfoName_lang_ptBR'] ?? '',
      infoNameLangItIT: json['InfoName_lang_itIT'] ?? '',
      infoNameLangUnk1: json['InfoName_lang_unk1'] ?? '',
      infoNameLangUnk2: json['InfoName_lang_unk2'] ?? '',
      infoNameLangUnk3: json['InfoName_lang_unk3'] ?? '',
      infoNameLangFlags: json['InfoName_lang_Flags'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'InfoName_lang_enUS': infoNameLangEnUS,
      'InfoName_lang_koKR': infoNameLangKoKR,
      'InfoName_lang_frFR': infoNameLangFrFR,
      'InfoName_lang_deDE': infoNameLangDeDE,
      'InfoName_lang_zhCN': infoNameLangZhCN,
      'InfoName_lang_zhTW': infoNameLangZhTW,
      'InfoName_lang_esES': infoNameLangEsES,
      'InfoName_lang_esMX': infoNameLangEsMX,
      'InfoName_lang_ruRU': infoNameLangRuRU,
      'InfoName_lang_jaJP': infoNameLangJaJP,
      'InfoName_lang_ptPT': infoNameLangPtPT,
      'InfoName_lang_ptBR': infoNameLangPtBR,
      'InfoName_lang_itIT': infoNameLangItIT,
      'InfoName_lang_unk1': infoNameLangUnk1,
      'InfoName_lang_unk2': infoNameLangUnk2,
      'InfoName_lang_unk3': infoNameLangUnk3,
      'InfoName_lang_Flags': infoNameLangFlags,
    };
  }

  QuestInfoEntity copyWith({
    int? id,
    String? infoNameLangEnUS,
    String? infoNameLangKoKR,
    String? infoNameLangFrFR,
    String? infoNameLangDeDE,
    String? infoNameLangZhCN,
    String? infoNameLangZhTW,
    String? infoNameLangEsES,
    String? infoNameLangEsMX,
    String? infoNameLangRuRU,
    String? infoNameLangJaJP,
    String? infoNameLangPtPT,
    String? infoNameLangPtBR,
    String? infoNameLangItIT,
    String? infoNameLangUnk1,
    String? infoNameLangUnk2,
    String? infoNameLangUnk3,
    int? infoNameLangFlags,
  }) {
    return QuestInfoEntity(
      id: id ?? this.id,
      infoNameLangEnUS: infoNameLangEnUS ?? this.infoNameLangEnUS,
      infoNameLangKoKR: infoNameLangKoKR ?? this.infoNameLangKoKR,
      infoNameLangFrFR: infoNameLangFrFR ?? this.infoNameLangFrFR,
      infoNameLangDeDE: infoNameLangDeDE ?? this.infoNameLangDeDE,
      infoNameLangZhCN: infoNameLangZhCN ?? this.infoNameLangZhCN,
      infoNameLangZhTW: infoNameLangZhTW ?? this.infoNameLangZhTW,
      infoNameLangEsES: infoNameLangEsES ?? this.infoNameLangEsES,
      infoNameLangEsMX: infoNameLangEsMX ?? this.infoNameLangEsMX,
      infoNameLangRuRU: infoNameLangRuRU ?? this.infoNameLangRuRU,
      infoNameLangJaJP: infoNameLangJaJP ?? this.infoNameLangJaJP,
      infoNameLangPtPT: infoNameLangPtPT ?? this.infoNameLangPtPT,
      infoNameLangPtBR: infoNameLangPtBR ?? this.infoNameLangPtBR,
      infoNameLangItIT: infoNameLangItIT ?? this.infoNameLangItIT,
      infoNameLangUnk1: infoNameLangUnk1 ?? this.infoNameLangUnk1,
      infoNameLangUnk2: infoNameLangUnk2 ?? this.infoNameLangUnk2,
      infoNameLangUnk3: infoNameLangUnk3 ?? this.infoNameLangUnk3,
      infoNameLangFlags: infoNameLangFlags ?? this.infoNameLangFlags,
    );
  }
}

/// 任务信息列表/Picker 展示模型
class BriefQuestInfoEntity {
  final int id;
  final String infoNameLangZhCN;

  const BriefQuestInfoEntity({this.id = 0, this.infoNameLangZhCN = ''});

  factory BriefQuestInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestInfoEntity(
      id: json['ID'] ?? 0,
      infoNameLangZhCN: json['InfoName_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'InfoName_lang_zhCN': infoNameLangZhCN};
  }

  BriefQuestInfoEntity copyWith({int? id, String? infoNameLangZhCN}) {
    return BriefQuestInfoEntity(
      id: id ?? this.id,
      infoNameLangZhCN: infoNameLangZhCN ?? this.infoNameLangZhCN,
    );
  }
}
