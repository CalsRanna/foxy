// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'char_title_entity.dart';

mixin _CharTitleEntityMixin {
  int get id;
  int get conditionId;
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
  String get name1LangEnUS;
  String get name1LangKoKR;
  String get name1LangFrFR;
  String get name1LangDeDE;
  String get name1LangZhCN;
  String get name1LangZhTW;
  String get name1LangEsES;
  String get name1LangEsMX;
  String get name1LangRuRU;
  String get name1LangJaJP;
  String get name1LangPtPT;
  String get name1LangPtBR;
  String get name1LangItIT;
  String get name1LangUnk1;
  String get name1LangUnk2;
  String get name1LangUnk3;
  int get name1LangFlags;
  int get maskId;

  static CharTitleEntity fromJson(Map<String, dynamic> json) {
    return CharTitleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      conditionId: (json['Condition_ID'] as num?)?.toInt() ?? 0,
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
      name1LangEnUS: json['Name1_lang_enUS']?.toString() ?? '',
      name1LangKoKR: json['Name1_lang_koKR']?.toString() ?? '',
      name1LangFrFR: json['Name1_lang_frFR']?.toString() ?? '',
      name1LangDeDE: json['Name1_lang_deDE']?.toString() ?? '',
      name1LangZhCN: json['Name1_lang_zhCN']?.toString() ?? '',
      name1LangZhTW: json['Name1_lang_zhTW']?.toString() ?? '',
      name1LangEsES: json['Name1_lang_esES']?.toString() ?? '',
      name1LangEsMX: json['Name1_lang_esMX']?.toString() ?? '',
      name1LangRuRU: json['Name1_lang_ruRU']?.toString() ?? '',
      name1LangJaJP: json['Name1_lang_jaJP']?.toString() ?? '',
      name1LangPtPT: json['Name1_lang_ptPT']?.toString() ?? '',
      name1LangPtBR: json['Name1_lang_ptBR']?.toString() ?? '',
      name1LangItIT: json['Name1_lang_itIT']?.toString() ?? '',
      name1LangUnk1: json['Name1_lang_unk1']?.toString() ?? '',
      name1LangUnk2: json['Name1_lang_unk2']?.toString() ?? '',
      name1LangUnk3: json['Name1_lang_unk3']?.toString() ?? '',
      name1LangFlags: (json['Name1_lang_Flags'] as num?)?.toInt() ?? 0,
      maskId: (json['Mask_ID'] as num?)?.toInt() ?? 0,
    );
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CharTitleEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            conditionId == other.conditionId &&
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
            name1LangEnUS == other.name1LangEnUS &&
            name1LangKoKR == other.name1LangKoKR &&
            name1LangFrFR == other.name1LangFrFR &&
            name1LangDeDE == other.name1LangDeDE &&
            name1LangZhCN == other.name1LangZhCN &&
            name1LangZhTW == other.name1LangZhTW &&
            name1LangEsES == other.name1LangEsES &&
            name1LangEsMX == other.name1LangEsMX &&
            name1LangRuRU == other.name1LangRuRU &&
            name1LangJaJP == other.name1LangJaJP &&
            name1LangPtPT == other.name1LangPtPT &&
            name1LangPtBR == other.name1LangPtBR &&
            name1LangItIT == other.name1LangItIT &&
            name1LangUnk1 == other.name1LangUnk1 &&
            name1LangUnk2 == other.name1LangUnk2 &&
            name1LangUnk3 == other.name1LangUnk3 &&
            name1LangFlags == other.name1LangFlags &&
            maskId == other.maskId;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      conditionId,
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
      name1LangEnUS,
      name1LangKoKR,
      name1LangFrFR,
      name1LangDeDE,
      name1LangZhCN,
      name1LangZhTW,
      name1LangEsES,
      name1LangEsMX,
      name1LangRuRU,
      name1LangJaJP,
      name1LangPtPT,
      name1LangPtBR,
      name1LangItIT,
      name1LangUnk1,
      name1LangUnk2,
      name1LangUnk3,
      name1LangFlags,
      maskId,
    ]);
  }

  @override
  String toString() {
    return 'CharTitleEntity('
        'id: $id, '
        'conditionId: $conditionId, '
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
        'name1LangEnUS: $name1LangEnUS, '
        'name1LangKoKR: $name1LangKoKR, '
        'name1LangFrFR: $name1LangFrFR, '
        'name1LangDeDE: $name1LangDeDE, '
        'name1LangZhCN: $name1LangZhCN, '
        'name1LangZhTW: $name1LangZhTW, '
        'name1LangEsES: $name1LangEsES, '
        'name1LangEsMX: $name1LangEsMX, '
        'name1LangRuRU: $name1LangRuRU, '
        'name1LangJaJP: $name1LangJaJP, '
        'name1LangPtPT: $name1LangPtPT, '
        'name1LangPtBR: $name1LangPtBR, '
        'name1LangItIT: $name1LangItIT, '
        'name1LangUnk1: $name1LangUnk1, '
        'name1LangUnk2: $name1LangUnk2, '
        'name1LangUnk3: $name1LangUnk3, '
        'name1LangFlags: $name1LangFlags, '
        'maskId: $maskId'
        ')';
  }
}
