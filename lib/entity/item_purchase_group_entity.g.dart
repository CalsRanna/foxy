// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_purchase_group_entity.dart';

mixin _ItemPurchaseGroupEntityMixin {
  int get id;
  int get itemID0;
  int get itemID1;
  int get itemID2;
  int get itemID3;
  int get itemID4;
  int get itemID5;
  int get itemID6;
  int get itemID7;
  String get nameLangEnUS;
  String get nameLangKoKR;
  String get nameLangFrFR;
  String get nameLangDeDE;
  String get nameLangZhCN;
  String get nameLangZhTW;
  String get nameLangEsES;
  String get nameLangEsMX;
  String get nameLangRuRU;
  String get nameLangJaJP;
  String get nameLangPtPT;
  String get nameLangPtBR;
  String get nameLangItIT;
  String get nameLangUnk1;
  String get nameLangUnk2;
  String get nameLangUnk3;
  int get nameLangFlags;

  static ItemPurchaseGroupEntity fromJson(Map<String, dynamic> json) {
    return ItemPurchaseGroupEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      itemID0: (json['ItemID0'] as num?)?.toInt() ?? 0,
      itemID1: (json['ItemID1'] as num?)?.toInt() ?? 0,
      itemID2: (json['ItemID2'] as num?)?.toInt() ?? 0,
      itemID3: (json['ItemID3'] as num?)?.toInt() ?? 0,
      itemID4: (json['ItemID4'] as num?)?.toInt() ?? 0,
      itemID5: (json['ItemID5'] as num?)?.toInt() ?? 0,
      itemID6: (json['ItemID6'] as num?)?.toInt() ?? 0,
      itemID7: (json['ItemID7'] as num?)?.toInt() ?? 0,
      nameLangEnUS: json['Name_lang_enUS']?.toString() ?? '',
      nameLangKoKR: json['Name_lang_koKR']?.toString() ?? '',
      nameLangFrFR: json['Name_lang_frFR']?.toString() ?? '',
      nameLangDeDE: json['Name_lang_deDE']?.toString() ?? '',
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      nameLangZhTW: json['Name_lang_zhTW']?.toString() ?? '',
      nameLangEsES: json['Name_lang_esES']?.toString() ?? '',
      nameLangEsMX: json['Name_lang_esMX']?.toString() ?? '',
      nameLangRuRU: json['Name_lang_ruRU']?.toString() ?? '',
      nameLangJaJP: json['Name_lang_jaJP']?.toString() ?? '',
      nameLangPtPT: json['Name_lang_ptPT']?.toString() ?? '',
      nameLangPtBR: json['Name_lang_ptBR']?.toString() ?? '',
      nameLangItIT: json['Name_lang_itIT']?.toString() ?? '',
      nameLangUnk1: json['Name_lang_unk1']?.toString() ?? '',
      nameLangUnk2: json['Name_lang_unk2']?.toString() ?? '',
      nameLangUnk3: json['Name_lang_unk3']?.toString() ?? '',
      nameLangFlags: (json['Name_lang_Flags'] as num?)?.toInt() ?? 0,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemPurchaseGroupEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            itemID0 == other.itemID0 &&
            itemID1 == other.itemID1 &&
            itemID2 == other.itemID2 &&
            itemID3 == other.itemID3 &&
            itemID4 == other.itemID4 &&
            itemID5 == other.itemID5 &&
            itemID6 == other.itemID6 &&
            itemID7 == other.itemID7 &&
            nameLangEnUS == other.nameLangEnUS &&
            nameLangKoKR == other.nameLangKoKR &&
            nameLangFrFR == other.nameLangFrFR &&
            nameLangDeDE == other.nameLangDeDE &&
            nameLangZhCN == other.nameLangZhCN &&
            nameLangZhTW == other.nameLangZhTW &&
            nameLangEsES == other.nameLangEsES &&
            nameLangEsMX == other.nameLangEsMX &&
            nameLangRuRU == other.nameLangRuRU &&
            nameLangJaJP == other.nameLangJaJP &&
            nameLangPtPT == other.nameLangPtPT &&
            nameLangPtBR == other.nameLangPtBR &&
            nameLangItIT == other.nameLangItIT &&
            nameLangUnk1 == other.nameLangUnk1 &&
            nameLangUnk2 == other.nameLangUnk2 &&
            nameLangUnk3 == other.nameLangUnk3 &&
            nameLangFlags == other.nameLangFlags;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      itemID0,
      itemID1,
      itemID2,
      itemID3,
      itemID4,
      itemID5,
      itemID6,
      itemID7,
      nameLangEnUS,
      nameLangKoKR,
      nameLangFrFR,
      nameLangDeDE,
      nameLangZhCN,
      nameLangZhTW,
      nameLangEsES,
      nameLangEsMX,
      nameLangRuRU,
      nameLangJaJP,
      nameLangPtPT,
      nameLangPtBR,
      nameLangItIT,
      nameLangUnk1,
      nameLangUnk2,
      nameLangUnk3,
      nameLangFlags,
    ]);
  }

  @override
  String toString() {
    return 'ItemPurchaseGroupEntity('
        'id: $id, '
        'itemID0: $itemID0, '
        'itemID1: $itemID1, '
        'itemID2: $itemID2, '
        'itemID3: $itemID3, '
        'itemID4: $itemID4, '
        'itemID5: $itemID5, '
        'itemID6: $itemID6, '
        'itemID7: $itemID7, '
        'nameLangEnUS: $nameLangEnUS, '
        'nameLangKoKR: $nameLangKoKR, '
        'nameLangFrFR: $nameLangFrFR, '
        'nameLangDeDE: $nameLangDeDE, '
        'nameLangZhCN: $nameLangZhCN, '
        'nameLangZhTW: $nameLangZhTW, '
        'nameLangEsES: $nameLangEsES, '
        'nameLangEsMX: $nameLangEsMX, '
        'nameLangRuRU: $nameLangRuRU, '
        'nameLangJaJP: $nameLangJaJP, '
        'nameLangPtPT: $nameLangPtPT, '
        'nameLangPtBR: $nameLangPtBR, '
        'nameLangItIT: $nameLangItIT, '
        'nameLangUnk1: $nameLangUnk1, '
        'nameLangUnk2: $nameLangUnk2, '
        'nameLangUnk3: $nameLangUnk3, '
        'nameLangFlags: $nameLangFlags'
        ')';
  }
}
