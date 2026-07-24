// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_purchase_group_entity.dart';

mixin _ItemPurchaseGroupEntityMixin {
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
    final self = this as ItemPurchaseGroupEntity;
    return ItemPurchaseGroupEntity(
      id: id ?? self.id,
      itemID0: itemID0 ?? self.itemID0,
      itemID1: itemID1 ?? self.itemID1,
      itemID2: itemID2 ?? self.itemID2,
      itemID3: itemID3 ?? self.itemID3,
      itemID4: itemID4 ?? self.itemID4,
      itemID5: itemID5 ?? self.itemID5,
      itemID6: itemID6 ?? self.itemID6,
      itemID7: itemID7 ?? self.itemID7,
      nameLangEnUS: nameLangEnUS ?? self.nameLangEnUS,
      nameLangKoKR: nameLangKoKR ?? self.nameLangKoKR,
      nameLangFrFR: nameLangFrFR ?? self.nameLangFrFR,
      nameLangDeDE: nameLangDeDE ?? self.nameLangDeDE,
      nameLangZhCN: nameLangZhCN ?? self.nameLangZhCN,
      nameLangZhTW: nameLangZhTW ?? self.nameLangZhTW,
      nameLangEsES: nameLangEsES ?? self.nameLangEsES,
      nameLangEsMX: nameLangEsMX ?? self.nameLangEsMX,
      nameLangRuRU: nameLangRuRU ?? self.nameLangRuRU,
      nameLangJaJP: nameLangJaJP ?? self.nameLangJaJP,
      nameLangPtPT: nameLangPtPT ?? self.nameLangPtPT,
      nameLangPtBR: nameLangPtBR ?? self.nameLangPtBR,
      nameLangItIT: nameLangItIT ?? self.nameLangItIT,
      nameLangUnk1: nameLangUnk1 ?? self.nameLangUnk1,
      nameLangUnk2: nameLangUnk2 ?? self.nameLangUnk2,
      nameLangUnk3: nameLangUnk3 ?? self.nameLangUnk3,
      nameLangFlags: nameLangFlags ?? self.nameLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemPurchaseGroupEntity;
    return {
      'ID': self.id,
      'ItemID0': self.itemID0,
      'ItemID1': self.itemID1,
      'ItemID2': self.itemID2,
      'ItemID3': self.itemID3,
      'ItemID4': self.itemID4,
      'ItemID5': self.itemID5,
      'ItemID6': self.itemID6,
      'ItemID7': self.itemID7,
      'Name_lang_enUS': self.nameLangEnUS,
      'Name_lang_koKR': self.nameLangKoKR,
      'Name_lang_frFR': self.nameLangFrFR,
      'Name_lang_deDE': self.nameLangDeDE,
      'Name_lang_zhCN': self.nameLangZhCN,
      'Name_lang_zhTW': self.nameLangZhTW,
      'Name_lang_esES': self.nameLangEsES,
      'Name_lang_esMX': self.nameLangEsMX,
      'Name_lang_ruRU': self.nameLangRuRU,
      'Name_lang_jaJP': self.nameLangJaJP,
      'Name_lang_ptPT': self.nameLangPtPT,
      'Name_lang_ptBR': self.nameLangPtBR,
      'Name_lang_itIT': self.nameLangItIT,
      'Name_lang_unk1': self.nameLangUnk1,
      'Name_lang_unk2': self.nameLangUnk2,
      'Name_lang_unk3': self.nameLangUnk3,
      'Name_lang_Flags': self.nameLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemPurchaseGroupEntity;
    return identical(self, other) ||
        other is ItemPurchaseGroupEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.itemID0 == other.itemID0 &&
            self.itemID1 == other.itemID1 &&
            self.itemID2 == other.itemID2 &&
            self.itemID3 == other.itemID3 &&
            self.itemID4 == other.itemID4 &&
            self.itemID5 == other.itemID5 &&
            self.itemID6 == other.itemID6 &&
            self.itemID7 == other.itemID7 &&
            self.nameLangEnUS == other.nameLangEnUS &&
            self.nameLangKoKR == other.nameLangKoKR &&
            self.nameLangFrFR == other.nameLangFrFR &&
            self.nameLangDeDE == other.nameLangDeDE &&
            self.nameLangZhCN == other.nameLangZhCN &&
            self.nameLangZhTW == other.nameLangZhTW &&
            self.nameLangEsES == other.nameLangEsES &&
            self.nameLangEsMX == other.nameLangEsMX &&
            self.nameLangRuRU == other.nameLangRuRU &&
            self.nameLangJaJP == other.nameLangJaJP &&
            self.nameLangPtPT == other.nameLangPtPT &&
            self.nameLangPtBR == other.nameLangPtBR &&
            self.nameLangItIT == other.nameLangItIT &&
            self.nameLangUnk1 == other.nameLangUnk1 &&
            self.nameLangUnk2 == other.nameLangUnk2 &&
            self.nameLangUnk3 == other.nameLangUnk3 &&
            self.nameLangFlags == other.nameLangFlags;
  }

  @override
  int get hashCode {
    final self = this as ItemPurchaseGroupEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.itemID0,
      self.itemID1,
      self.itemID2,
      self.itemID3,
      self.itemID4,
      self.itemID5,
      self.itemID6,
      self.itemID7,
      self.nameLangEnUS,
      self.nameLangKoKR,
      self.nameLangFrFR,
      self.nameLangDeDE,
      self.nameLangZhCN,
      self.nameLangZhTW,
      self.nameLangEsES,
      self.nameLangEsMX,
      self.nameLangRuRU,
      self.nameLangJaJP,
      self.nameLangPtPT,
      self.nameLangPtBR,
      self.nameLangItIT,
      self.nameLangUnk1,
      self.nameLangUnk2,
      self.nameLangUnk3,
      self.nameLangFlags,
    ]);
  }

  @override
  String toString() {
    final self = this as ItemPurchaseGroupEntity;
    return 'ItemPurchaseGroupEntity('
        'id: ${self.id}, '
        'itemID0: ${self.itemID0}, '
        'itemID1: ${self.itemID1}, '
        'itemID2: ${self.itemID2}, '
        'itemID3: ${self.itemID3}, '
        'itemID4: ${self.itemID4}, '
        'itemID5: ${self.itemID5}, '
        'itemID6: ${self.itemID6}, '
        'itemID7: ${self.itemID7}, '
        'nameLangEnUS: ${self.nameLangEnUS}, '
        'nameLangKoKR: ${self.nameLangKoKR}, '
        'nameLangFrFR: ${self.nameLangFrFR}, '
        'nameLangDeDE: ${self.nameLangDeDE}, '
        'nameLangZhCN: ${self.nameLangZhCN}, '
        'nameLangZhTW: ${self.nameLangZhTW}, '
        'nameLangEsES: ${self.nameLangEsES}, '
        'nameLangEsMX: ${self.nameLangEsMX}, '
        'nameLangRuRU: ${self.nameLangRuRU}, '
        'nameLangJaJP: ${self.nameLangJaJP}, '
        'nameLangPtPT: ${self.nameLangPtPT}, '
        'nameLangPtBR: ${self.nameLangPtBR}, '
        'nameLangItIT: ${self.nameLangItIT}, '
        'nameLangUnk1: ${self.nameLangUnk1}, '
        'nameLangUnk2: ${self.nameLangUnk2}, '
        'nameLangUnk3: ${self.nameLangUnk3}, '
        'nameLangFlags: ${self.nameLangFlags}'
        ')';
  }
}
