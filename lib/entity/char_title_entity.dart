class CharTitleEntity {
  final int id;
  final int conditionId;
  final String nameLangEnUS;
  final String nameLangKoKR;
  final String nameLangFrFR;
  final String nameLangDeDE;
  final String nameLangZhCN;
  final String nameLangZhTW;
  final String nameLangEsES;
  final String nameLangEsMX;
  final String nameLangRuRU;
  final String nameLangJaJP;
  final String nameLangPtPT;
  final String nameLangPtBR;
  final String nameLangItIT;
  final String nameLangUnk1;
  final String nameLangUnk2;
  final String nameLangUnk3;
  final int nameLangFlags;
  final String name1LangEnUS;
  final String name1LangKoKR;
  final String name1LangFrFR;
  final String name1LangDeDE;
  final String name1LangZhCN;
  final String name1LangZhTW;
  final String name1LangEsES;
  final String name1LangEsMX;
  final String name1LangRuRU;
  final String name1LangJaJP;
  final String name1LangPtPT;
  final String name1LangPtBR;
  final String name1LangItIT;
  final String name1LangUnk1;
  final String name1LangUnk2;
  final String name1LangUnk3;
  final int name1LangFlags;
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

  factory CharTitleEntity.fromJson(Map<String, dynamic> json) {
    return CharTitleEntity(
      id: json['ID'] ?? 0,
      conditionId: json['Condition_ID'] ?? 0,
      nameLangEnUS: json['Name_lang_enUS'] ?? '',
      nameLangKoKR: json['Name_lang_koKR'] ?? '',
      nameLangFrFR: json['Name_lang_frFR'] ?? '',
      nameLangDeDE: json['Name_lang_deDE'] ?? '',
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      nameLangZhTW: json['Name_lang_zhTW'] ?? '',
      nameLangEsES: json['Name_lang_esES'] ?? '',
      nameLangEsMX: json['Name_lang_esMX'] ?? '',
      nameLangRuRU: json['Name_lang_ruRU'] ?? '',
      nameLangJaJP: json['Name_lang_jaJP'] ?? '',
      nameLangPtPT: json['Name_lang_ptPT'] ?? '',
      nameLangPtBR: json['Name_lang_ptBR'] ?? '',
      nameLangItIT: json['Name_lang_itIT'] ?? '',
      nameLangUnk1: json['Name_lang_unk1'] ?? '',
      nameLangUnk2: json['Name_lang_unk2'] ?? '',
      nameLangUnk3: json['Name_lang_unk3'] ?? '',
      nameLangFlags: json['Name_lang_Flags'] ?? 0,
      name1LangEnUS: json['Name1_lang_enUS'] ?? '',
      name1LangKoKR: json['Name1_lang_koKR'] ?? '',
      name1LangFrFR: json['Name1_lang_frFR'] ?? '',
      name1LangDeDE: json['Name1_lang_deDE'] ?? '',
      name1LangZhCN: json['Name1_lang_zhCN'] ?? '',
      name1LangZhTW: json['Name1_lang_zhTW'] ?? '',
      name1LangEsES: json['Name1_lang_esES'] ?? '',
      name1LangEsMX: json['Name1_lang_esMX'] ?? '',
      name1LangRuRU: json['Name1_lang_ruRU'] ?? '',
      name1LangJaJP: json['Name1_lang_jaJP'] ?? '',
      name1LangPtPT: json['Name1_lang_ptPT'] ?? '',
      name1LangPtBR: json['Name1_lang_ptBR'] ?? '',
      name1LangItIT: json['Name1_lang_itIT'] ?? '',
      name1LangUnk1: json['Name1_lang_unk1'] ?? '',
      name1LangUnk2: json['Name1_lang_unk2'] ?? '',
      name1LangUnk3: json['Name1_lang_unk3'] ?? '',
      name1LangFlags: json['Name1_lang_Flags'] ?? 0,
      maskId: json['Mask_ID'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Condition_ID': conditionId,
      'Name_lang_enUS': nameLangEnUS,
      'Name_lang_koKR': nameLangKoKR,
      'Name_lang_frFR': nameLangFrFR,
      'Name_lang_deDE': nameLangDeDE,
      'Name_lang_zhCN': nameLangZhCN,
      'Name_lang_zhTW': nameLangZhTW,
      'Name_lang_esES': nameLangEsES,
      'Name_lang_esMX': nameLangEsMX,
      'Name_lang_ruRU': nameLangRuRU,
      'Name_lang_jaJP': nameLangJaJP,
      'Name_lang_ptPT': nameLangPtPT,
      'Name_lang_ptBR': nameLangPtBR,
      'Name_lang_itIT': nameLangItIT,
      'Name_lang_unk1': nameLangUnk1,
      'Name_lang_unk2': nameLangUnk2,
      'Name_lang_unk3': nameLangUnk3,
      'Name_lang_Flags': nameLangFlags,
      'Name1_lang_enUS': name1LangEnUS,
      'Name1_lang_koKR': name1LangKoKR,
      'Name1_lang_frFR': name1LangFrFR,
      'Name1_lang_deDE': name1LangDeDE,
      'Name1_lang_zhCN': name1LangZhCN,
      'Name1_lang_zhTW': name1LangZhTW,
      'Name1_lang_esES': name1LangEsES,
      'Name1_lang_esMX': name1LangEsMX,
      'Name1_lang_ruRU': name1LangRuRU,
      'Name1_lang_jaJP': name1LangJaJP,
      'Name1_lang_ptPT': name1LangPtPT,
      'Name1_lang_ptBR': name1LangPtBR,
      'Name1_lang_itIT': name1LangItIT,
      'Name1_lang_unk1': name1LangUnk1,
      'Name1_lang_unk2': name1LangUnk2,
      'Name1_lang_unk3': name1LangUnk3,
      'Name1_lang_Flags': name1LangFlags,
      'Mask_ID': maskId,
    };
  }

  CharTitleEntity copyWith({
    int? id,
    int? conditionId,
    String? nameLangEnUS,
    String? nameLangKoKR,
    String? nameLangFrFR,
    String? nameLangDeDE,
    String? nameLangZhCN,
    String? nameLangZhTW,
    String? nameLangEsES,
    String? nameLangEsMX,
    String? nameLangRuRU,
    String? nameLangJaJP,
    String? nameLangPtPT,
    String? nameLangPtBR,
    String? nameLangItIT,
    String? nameLangUnk1,
    String? nameLangUnk2,
    String? nameLangUnk3,
    int? nameLangFlags,
    String? name1LangEnUS,
    String? name1LangKoKR,
    String? name1LangFrFR,
    String? name1LangDeDE,
    String? name1LangZhCN,
    String? name1LangZhTW,
    String? name1LangEsES,
    String? name1LangEsMX,
    String? name1LangRuRU,
    String? name1LangJaJP,
    String? name1LangPtPT,
    String? name1LangPtBR,
    String? name1LangItIT,
    String? name1LangUnk1,
    String? name1LangUnk2,
    String? name1LangUnk3,
    int? name1LangFlags,
    int? maskId,
  }) {
    return CharTitleEntity(
      id: id ?? this.id,
      conditionId: conditionId ?? this.conditionId,
      nameLangEnUS: nameLangEnUS ?? this.nameLangEnUS,
      nameLangKoKR: nameLangKoKR ?? this.nameLangKoKR,
      nameLangFrFR: nameLangFrFR ?? this.nameLangFrFR,
      nameLangDeDE: nameLangDeDE ?? this.nameLangDeDE,
      nameLangZhCN: nameLangZhCN ?? this.nameLangZhCN,
      nameLangZhTW: nameLangZhTW ?? this.nameLangZhTW,
      nameLangEsES: nameLangEsES ?? this.nameLangEsES,
      nameLangEsMX: nameLangEsMX ?? this.nameLangEsMX,
      nameLangRuRU: nameLangRuRU ?? this.nameLangRuRU,
      nameLangJaJP: nameLangJaJP ?? this.nameLangJaJP,
      nameLangPtPT: nameLangPtPT ?? this.nameLangPtPT,
      nameLangPtBR: nameLangPtBR ?? this.nameLangPtBR,
      nameLangItIT: nameLangItIT ?? this.nameLangItIT,
      nameLangUnk1: nameLangUnk1 ?? this.nameLangUnk1,
      nameLangUnk2: nameLangUnk2 ?? this.nameLangUnk2,
      nameLangUnk3: nameLangUnk3 ?? this.nameLangUnk3,
      nameLangFlags: nameLangFlags ?? this.nameLangFlags,
      name1LangEnUS: name1LangEnUS ?? this.name1LangEnUS,
      name1LangKoKR: name1LangKoKR ?? this.name1LangKoKR,
      name1LangFrFR: name1LangFrFR ?? this.name1LangFrFR,
      name1LangDeDE: name1LangDeDE ?? this.name1LangDeDE,
      name1LangZhCN: name1LangZhCN ?? this.name1LangZhCN,
      name1LangZhTW: name1LangZhTW ?? this.name1LangZhTW,
      name1LangEsES: name1LangEsES ?? this.name1LangEsES,
      name1LangEsMX: name1LangEsMX ?? this.name1LangEsMX,
      name1LangRuRU: name1LangRuRU ?? this.name1LangRuRU,
      name1LangJaJP: name1LangJaJP ?? this.name1LangJaJP,
      name1LangPtPT: name1LangPtPT ?? this.name1LangPtPT,
      name1LangPtBR: name1LangPtBR ?? this.name1LangPtBR,
      name1LangItIT: name1LangItIT ?? this.name1LangItIT,
      name1LangUnk1: name1LangUnk1 ?? this.name1LangUnk1,
      name1LangUnk2: name1LangUnk2 ?? this.name1LangUnk2,
      name1LangUnk3: name1LangUnk3 ?? this.name1LangUnk3,
      name1LangFlags: name1LangFlags ?? this.name1LangFlags,
      maskId: maskId ?? this.maskId,
    );
  }
}


/// 称号列表/Picker 展示模型
class BriefCharTitleEntity {
  final int id;
  final String nameLangZhCN;

  const BriefCharTitleEntity({this.id = 0, this.nameLangZhCN = ''});

  factory BriefCharTitleEntity.fromJson(Map<String, dynamic> json) {
    return BriefCharTitleEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Name_lang_zhCN': nameLangZhCN};
  }

  BriefCharTitleEntity copyWith({int? id, String? nameLangZhCN}) {
    return BriefCharTitleEntity(
      id: id ?? this.id,
      nameLangZhCN: nameLangZhCN ?? this.nameLangZhCN,
    );
  }
}
