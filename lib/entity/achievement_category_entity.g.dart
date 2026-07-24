// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_category_entity.dart';

mixin _AchievementCategoryEntityMixin {
  int get id;
  int get parent;
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
  int get uiOrder;

  static AchievementCategoryEntity fromJson(Map<String, dynamic> json) {
    return AchievementCategoryEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      parent: (json['Parent'] as num?)?.toInt() ?? -1,
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
      uiOrder: (json['Ui_order'] as num?)?.toInt() ?? 0,
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
  }) {
    return AchievementCategoryEntity(
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
  }

  Map<String, dynamic> toJson() {
    return {
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AchievementCategoryEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            parent == other.parent &&
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
            nameLangFlags == other.nameLangFlags &&
            uiOrder == other.uiOrder;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      parent,
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
      uiOrder,
    ]);
  }

  @override
  String toString() {
    return 'AchievementCategoryEntity('
        'id: $id, '
        'parent: $parent, '
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
        'nameLangFlags: $nameLangFlags, '
        'uiOrder: $uiOrder'
        ')';
  }
}
