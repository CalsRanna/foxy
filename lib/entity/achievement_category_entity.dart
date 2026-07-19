class AchievementCategoryEntity {
  final int id;
  final int parent;
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
  final int uiOrder;

  const AchievementCategoryEntity({
    this.id = 0,
    this.parent = -1,
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
    this.uiOrder = 0,
  });

  factory AchievementCategoryEntity.fromJson(Map<String, dynamic> json) {
    return AchievementCategoryEntity(
      id: json['ID'] ?? 0,
      parent: json['Parent'] ?? -1,
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
      uiOrder: json['Ui_order'] ?? 0,
    );
  }

  AchievementCategoryEntity copyWith({
    int? id,
    int? parent,
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
    int? uiOrder,
  }) => AchievementCategoryEntity(
    id: id ?? this.id,
    parent: parent ?? this.parent,
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
    uiOrder: uiOrder ?? this.uiOrder,
  );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'Parent': parent,
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
    'Ui_order': uiOrder,
  };
}
