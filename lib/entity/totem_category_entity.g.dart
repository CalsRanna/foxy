// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totem_category_entity.dart';

mixin _TotemCategoryEntityMixin {
  static TotemCategoryEntity fromJson(Map<String, dynamic> json) {
    return TotemCategoryEntity(
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
      categoryType: (json['TotemCategoryType'] as num?)?.toInt() ?? 0,
      categoryMask: (json['TotemCategoryMask'] as num?)?.toInt() ?? 0,
    );
  }

  TotemCategoryEntity copyWith({
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
    int? categoryType,
    int? categoryMask,
  }) {
    final self = this as TotemCategoryEntity;
    return TotemCategoryEntity(
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
      categoryType: categoryType ?? self.categoryType,
      categoryMask: categoryMask ?? self.categoryMask,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as TotemCategoryEntity;
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
      'TotemCategoryType': self.categoryType,
      'TotemCategoryMask': self.categoryMask,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as TotemCategoryEntity;
    return identical(self, other) ||
        other is TotemCategoryEntity &&
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
            self.categoryType == other.categoryType &&
            self.categoryMask == other.categoryMask;
  }

  @override
  int get hashCode {
    final self = this as TotemCategoryEntity;
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
      self.categoryType,
      self.categoryMask,
    ]);
  }

  @override
  String toString() {
    final self = this as TotemCategoryEntity;
    return 'TotemCategoryEntity('
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
        'categoryType: ${self.categoryType}, '
        'categoryMask: ${self.categoryMask}'
        ')';
  }
}

final class BriefTotemCategoryEntity {
  final int id;
  final int categoryType;
  final int categoryMask;
  final String name;

  const BriefTotemCategoryEntity({
    this.id = 0,
    this.categoryType = 0,
    this.categoryMask = 0,
    this.name = '',
  });

  factory BriefTotemCategoryEntity.fromJson(Map<String, dynamic> json) {
    return BriefTotemCategoryEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      categoryType: (json['TotemCategoryType'] as num?)?.toInt() ?? 0,
      categoryMask: (json['TotemCategoryMask'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  int get key => id;
}
