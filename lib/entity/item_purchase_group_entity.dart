class BriefItemPurchaseGroupEntity {
  final int id;
  final String nameLangZhCN;

  const BriefItemPurchaseGroupEntity({this.id = 0, this.nameLangZhCN = ''});

  factory BriefItemPurchaseGroupEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemPurchaseGroupEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Name_lang_zhCN': nameLangZhCN};
  }
}

class ItemPurchaseGroupEntity {
  final int id;
  final int itemID0;
  final int itemID1;
  final int itemID2;
  final int itemID3;
  final int itemID4;
  final int itemID5;
  final int itemID6;
  final int itemID7;
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

  const ItemPurchaseGroupEntity({
    this.id = 0,
    this.itemID0 = 0,
    this.itemID1 = 0,
    this.itemID2 = 0,
    this.itemID3 = 0,
    this.itemID4 = 0,
    this.itemID5 = 0,
    this.itemID6 = 0,
    this.itemID7 = 0,
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
  });

  factory ItemPurchaseGroupEntity.fromJson(Map<String, dynamic> json) {
    return ItemPurchaseGroupEntity(
      id: json['ID'] ?? 0,
      itemID0: json['ItemID0'] ?? 0,
      itemID1: json['ItemID1'] ?? 0,
      itemID2: json['ItemID2'] ?? 0,
      itemID3: json['ItemID3'] ?? 0,
      itemID4: json['ItemID4'] ?? 0,
      itemID5: json['ItemID5'] ?? 0,
      itemID6: json['ItemID6'] ?? 0,
      itemID7: json['ItemID7'] ?? 0,
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
    );
  }

  ItemPurchaseGroupEntity copyWith({
    int? id,
    int? itemID0,
    int? itemID1,
    int? itemID2,
    int? itemID3,
    int? itemID4,
    int? itemID5,
    int? itemID6,
    int? itemID7,
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
  }) {
    return ItemPurchaseGroupEntity(
      id: id ?? this.id,
      itemID0: itemID0 ?? this.itemID0,
      itemID1: itemID1 ?? this.itemID1,
      itemID2: itemID2 ?? this.itemID2,
      itemID3: itemID3 ?? this.itemID3,
      itemID4: itemID4 ?? this.itemID4,
      itemID5: itemID5 ?? this.itemID5,
      itemID6: itemID6 ?? this.itemID6,
      itemID7: itemID7 ?? this.itemID7,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ItemID0': itemID0,
      'ItemID1': itemID1,
      'ItemID2': itemID2,
      'ItemID3': itemID3,
      'ItemID4': itemID4,
      'ItemID5': itemID5,
      'ItemID6': itemID6,
      'ItemID7': itemID7,
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
    };
  }
}
