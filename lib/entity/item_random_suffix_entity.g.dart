// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_random_suffix_entity.dart';

mixin _ItemRandomSuffixEntityMixin {
  static ItemRandomSuffixEntity fromJson(Map<String, dynamic> json) {
    return ItemRandomSuffixEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
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
      internalName: json['InternalName']?.toString() ?? '',
      enchantment0: (json['Enchantment0'] as num?)?.toInt() ?? 0,
      enchantment1: (json['Enchantment1'] as num?)?.toInt() ?? 0,
      enchantment2: (json['Enchantment2'] as num?)?.toInt() ?? 0,
      enchantment3: (json['Enchantment3'] as num?)?.toInt() ?? 0,
      enchantment4: (json['Enchantment4'] as num?)?.toInt() ?? 0,
      allocationPct0: (json['AllocationPct0'] as num?)?.toInt() ?? 0,
      allocationPct1: (json['AllocationPct1'] as num?)?.toInt() ?? 0,
      allocationPct2: (json['AllocationPct2'] as num?)?.toInt() ?? 0,
      allocationPct3: (json['AllocationPct3'] as num?)?.toInt() ?? 0,
      allocationPct4: (json['AllocationPct4'] as num?)?.toInt() ?? 0,
    );
  }

  ItemRandomSuffixEntity copyWith({
    int? id,
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
    String? internalName,
    int? enchantment0,
    int? enchantment1,
    int? enchantment2,
    int? enchantment3,
    int? enchantment4,
    int? allocationPct0,
    int? allocationPct1,
    int? allocationPct2,
    int? allocationPct3,
    int? allocationPct4,
  }) {
    final self = this as ItemRandomSuffixEntity;
    return ItemRandomSuffixEntity(
      id: id ?? self.id,
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
      internalName: internalName ?? self.internalName,
      enchantment0: enchantment0 ?? self.enchantment0,
      enchantment1: enchantment1 ?? self.enchantment1,
      enchantment2: enchantment2 ?? self.enchantment2,
      enchantment3: enchantment3 ?? self.enchantment3,
      enchantment4: enchantment4 ?? self.enchantment4,
      allocationPct0: allocationPct0 ?? self.allocationPct0,
      allocationPct1: allocationPct1 ?? self.allocationPct1,
      allocationPct2: allocationPct2 ?? self.allocationPct2,
      allocationPct3: allocationPct3 ?? self.allocationPct3,
      allocationPct4: allocationPct4 ?? self.allocationPct4,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemRandomSuffixEntity;
    return {
      'ID': self.id,
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
      'InternalName': self.internalName,
      'Enchantment0': self.enchantment0,
      'Enchantment1': self.enchantment1,
      'Enchantment2': self.enchantment2,
      'Enchantment3': self.enchantment3,
      'Enchantment4': self.enchantment4,
      'AllocationPct0': self.allocationPct0,
      'AllocationPct1': self.allocationPct1,
      'AllocationPct2': self.allocationPct2,
      'AllocationPct3': self.allocationPct3,
      'AllocationPct4': self.allocationPct4,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemRandomSuffixEntity;
    return identical(self, other) ||
        other is ItemRandomSuffixEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
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
            self.nameLangFlags == other.nameLangFlags &&
            self.internalName == other.internalName &&
            self.enchantment0 == other.enchantment0 &&
            self.enchantment1 == other.enchantment1 &&
            self.enchantment2 == other.enchantment2 &&
            self.enchantment3 == other.enchantment3 &&
            self.enchantment4 == other.enchantment4 &&
            self.allocationPct0 == other.allocationPct0 &&
            self.allocationPct1 == other.allocationPct1 &&
            self.allocationPct2 == other.allocationPct2 &&
            self.allocationPct3 == other.allocationPct3 &&
            self.allocationPct4 == other.allocationPct4;
  }

  @override
  int get hashCode {
    final self = this as ItemRandomSuffixEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
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
      self.internalName,
      self.enchantment0,
      self.enchantment1,
      self.enchantment2,
      self.enchantment3,
      self.enchantment4,
      self.allocationPct0,
      self.allocationPct1,
      self.allocationPct2,
      self.allocationPct3,
      self.allocationPct4,
    ]);
  }

  @override
  String toString() {
    final self = this as ItemRandomSuffixEntity;
    return 'ItemRandomSuffixEntity('
        'id: ${self.id}, '
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
        'nameLangFlags: ${self.nameLangFlags}, '
        'internalName: ${self.internalName}, '
        'enchantment0: ${self.enchantment0}, '
        'enchantment1: ${self.enchantment1}, '
        'enchantment2: ${self.enchantment2}, '
        'enchantment3: ${self.enchantment3}, '
        'enchantment4: ${self.enchantment4}, '
        'allocationPct0: ${self.allocationPct0}, '
        'allocationPct1: ${self.allocationPct1}, '
        'allocationPct2: ${self.allocationPct2}, '
        'allocationPct3: ${self.allocationPct3}, '
        'allocationPct4: ${self.allocationPct4}'
        ')';
  }
}

final class BriefItemRandomSuffixEntity {
  final int id;
  final String nameLangZhCN;
  final String internalName;

  const BriefItemRandomSuffixEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.internalName = '',
  });

  factory BriefItemRandomSuffixEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemRandomSuffixEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      internalName: json['InternalName']?.toString() ?? '',
    );
  }

  int get key => id;
}
