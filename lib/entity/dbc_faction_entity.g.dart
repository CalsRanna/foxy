// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_entity.dart';

mixin _DbcFactionEntityMixin {
  int get id;
  int get reputationIndex;
  int get reputationRaceMask0;
  int get reputationRaceMask1;
  int get reputationRaceMask2;
  int get reputationRaceMask3;
  int get reputationClassMask0;
  int get reputationClassMask1;
  int get reputationClassMask2;
  int get reputationClassMask3;
  int get reputationBase0;
  int get reputationBase1;
  int get reputationBase2;
  int get reputationBase3;
  int get reputationFlags0;
  int get reputationFlags1;
  int get reputationFlags2;
  int get reputationFlags3;
  int get parentFactionId;
  double get parentFactionMod0;
  double get parentFactionMod1;
  int get parentFactionCap0;
  int get parentFactionCap1;
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
  String get descriptionLangEnUS;
  String get descriptionLangKoKR;
  String get descriptionLangFrFR;
  String get descriptionLangDeDE;
  String get descriptionLangZhCN;
  String get descriptionLangZhTW;
  String get descriptionLangEsES;
  String get descriptionLangEsMX;
  String get descriptionLangRuRU;
  String get descriptionLangJaJP;
  String get descriptionLangPtPT;
  String get descriptionLangPtBR;
  String get descriptionLangItIT;
  String get descriptionLangUnk1;
  String get descriptionLangUnk2;
  String get descriptionLangUnk3;
  int get descriptionLangFlags;

  static DbcFactionEntity fromJson(Map<String, dynamic> json) {
    return DbcFactionEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      reputationIndex: (json['ReputationIndex'] as num?)?.toInt() ?? 0,
      reputationRaceMask0: (json['ReputationRaceMask0'] as num?)?.toInt() ?? 0,
      reputationRaceMask1: (json['ReputationRaceMask1'] as num?)?.toInt() ?? 0,
      reputationRaceMask2: (json['ReputationRaceMask2'] as num?)?.toInt() ?? 0,
      reputationRaceMask3: (json['ReputationRaceMask3'] as num?)?.toInt() ?? 0,
      reputationClassMask0:
          (json['ReputationClassMask0'] as num?)?.toInt() ?? 0,
      reputationClassMask1:
          (json['ReputationClassMask1'] as num?)?.toInt() ?? 0,
      reputationClassMask2:
          (json['ReputationClassMask2'] as num?)?.toInt() ?? 0,
      reputationClassMask3:
          (json['ReputationClassMask3'] as num?)?.toInt() ?? 0,
      reputationBase0: (json['ReputationBase0'] as num?)?.toInt() ?? 0,
      reputationBase1: (json['ReputationBase1'] as num?)?.toInt() ?? 0,
      reputationBase2: (json['ReputationBase2'] as num?)?.toInt() ?? 0,
      reputationBase3: (json['ReputationBase3'] as num?)?.toInt() ?? 0,
      reputationFlags0: (json['ReputationFlags0'] as num?)?.toInt() ?? 0,
      reputationFlags1: (json['ReputationFlags1'] as num?)?.toInt() ?? 0,
      reputationFlags2: (json['ReputationFlags2'] as num?)?.toInt() ?? 0,
      reputationFlags3: (json['ReputationFlags3'] as num?)?.toInt() ?? 0,
      parentFactionId: (json['ParentFactionID'] as num?)?.toInt() ?? 0,
      parentFactionMod0: (json['ParentFactionMod0'] as num?)?.toDouble() ?? 0.0,
      parentFactionMod1: (json['ParentFactionMod1'] as num?)?.toDouble() ?? 0.0,
      parentFactionCap0: (json['ParentFactionCap0'] as num?)?.toInt() ?? 0,
      parentFactionCap1: (json['ParentFactionCap1'] as num?)?.toInt() ?? 0,
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
      descriptionLangEnUS: json['Description_lang_enUS']?.toString() ?? '',
      descriptionLangKoKR: json['Description_lang_koKR']?.toString() ?? '',
      descriptionLangFrFR: json['Description_lang_frFR']?.toString() ?? '',
      descriptionLangDeDE: json['Description_lang_deDE']?.toString() ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN']?.toString() ?? '',
      descriptionLangZhTW: json['Description_lang_zhTW']?.toString() ?? '',
      descriptionLangEsES: json['Description_lang_esES']?.toString() ?? '',
      descriptionLangEsMX: json['Description_lang_esMX']?.toString() ?? '',
      descriptionLangRuRU: json['Description_lang_ruRU']?.toString() ?? '',
      descriptionLangJaJP: json['Description_lang_jaJP']?.toString() ?? '',
      descriptionLangPtPT: json['Description_lang_ptPT']?.toString() ?? '',
      descriptionLangPtBR: json['Description_lang_ptBR']?.toString() ?? '',
      descriptionLangItIT: json['Description_lang_itIT']?.toString() ?? '',
      descriptionLangUnk1: json['Description_lang_unk1']?.toString() ?? '',
      descriptionLangUnk2: json['Description_lang_unk2']?.toString() ?? '',
      descriptionLangUnk3: json['Description_lang_unk3']?.toString() ?? '',
      descriptionLangFlags:
          (json['Description_lang_Flags'] as num?)?.toInt() ?? 0,
    );
  }

  DbcFactionEntity copyWith({
    int? id,
    int? reputationIndex,
    int? reputationRaceMask0,
    int? reputationRaceMask1,
    int? reputationRaceMask2,
    int? reputationRaceMask3,
    int? reputationClassMask0,
    int? reputationClassMask1,
    int? reputationClassMask2,
    int? reputationClassMask3,
    int? reputationBase0,
    int? reputationBase1,
    int? reputationBase2,
    int? reputationBase3,
    int? reputationFlags0,
    int? reputationFlags1,
    int? reputationFlags2,
    int? reputationFlags3,
    int? parentFactionId,
    double? parentFactionMod0,
    double? parentFactionMod1,
    int? parentFactionCap0,
    int? parentFactionCap1,
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
    String? descriptionLangEnUS,
    String? descriptionLangKoKR,
    String? descriptionLangFrFR,
    String? descriptionLangDeDE,
    String? descriptionLangZhCN,
    String? descriptionLangZhTW,
    String? descriptionLangEsES,
    String? descriptionLangEsMX,
    String? descriptionLangRuRU,
    String? descriptionLangJaJP,
    String? descriptionLangPtPT,
    String? descriptionLangPtBR,
    String? descriptionLangItIT,
    String? descriptionLangUnk1,
    String? descriptionLangUnk2,
    String? descriptionLangUnk3,
    int? descriptionLangFlags,
  }) {
    return DbcFactionEntity(
      id: id ?? this.id,
      reputationIndex: reputationIndex ?? this.reputationIndex,
      reputationRaceMask0: reputationRaceMask0 ?? this.reputationRaceMask0,
      reputationRaceMask1: reputationRaceMask1 ?? this.reputationRaceMask1,
      reputationRaceMask2: reputationRaceMask2 ?? this.reputationRaceMask2,
      reputationRaceMask3: reputationRaceMask3 ?? this.reputationRaceMask3,
      reputationClassMask0: reputationClassMask0 ?? this.reputationClassMask0,
      reputationClassMask1: reputationClassMask1 ?? this.reputationClassMask1,
      reputationClassMask2: reputationClassMask2 ?? this.reputationClassMask2,
      reputationClassMask3: reputationClassMask3 ?? this.reputationClassMask3,
      reputationBase0: reputationBase0 ?? this.reputationBase0,
      reputationBase1: reputationBase1 ?? this.reputationBase1,
      reputationBase2: reputationBase2 ?? this.reputationBase2,
      reputationBase3: reputationBase3 ?? this.reputationBase3,
      reputationFlags0: reputationFlags0 ?? this.reputationFlags0,
      reputationFlags1: reputationFlags1 ?? this.reputationFlags1,
      reputationFlags2: reputationFlags2 ?? this.reputationFlags2,
      reputationFlags3: reputationFlags3 ?? this.reputationFlags3,
      parentFactionId: parentFactionId ?? this.parentFactionId,
      parentFactionMod0: parentFactionMod0 ?? this.parentFactionMod0,
      parentFactionMod1: parentFactionMod1 ?? this.parentFactionMod1,
      parentFactionCap0: parentFactionCap0 ?? this.parentFactionCap0,
      parentFactionCap1: parentFactionCap1 ?? this.parentFactionCap1,
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
      descriptionLangEnUS: descriptionLangEnUS ?? this.descriptionLangEnUS,
      descriptionLangKoKR: descriptionLangKoKR ?? this.descriptionLangKoKR,
      descriptionLangFrFR: descriptionLangFrFR ?? this.descriptionLangFrFR,
      descriptionLangDeDE: descriptionLangDeDE ?? this.descriptionLangDeDE,
      descriptionLangZhCN: descriptionLangZhCN ?? this.descriptionLangZhCN,
      descriptionLangZhTW: descriptionLangZhTW ?? this.descriptionLangZhTW,
      descriptionLangEsES: descriptionLangEsES ?? this.descriptionLangEsES,
      descriptionLangEsMX: descriptionLangEsMX ?? this.descriptionLangEsMX,
      descriptionLangRuRU: descriptionLangRuRU ?? this.descriptionLangRuRU,
      descriptionLangJaJP: descriptionLangJaJP ?? this.descriptionLangJaJP,
      descriptionLangPtPT: descriptionLangPtPT ?? this.descriptionLangPtPT,
      descriptionLangPtBR: descriptionLangPtBR ?? this.descriptionLangPtBR,
      descriptionLangItIT: descriptionLangItIT ?? this.descriptionLangItIT,
      descriptionLangUnk1: descriptionLangUnk1 ?? this.descriptionLangUnk1,
      descriptionLangUnk2: descriptionLangUnk2 ?? this.descriptionLangUnk2,
      descriptionLangUnk3: descriptionLangUnk3 ?? this.descriptionLangUnk3,
      descriptionLangFlags: descriptionLangFlags ?? this.descriptionLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ReputationIndex': reputationIndex,
      'ReputationRaceMask0': reputationRaceMask0,
      'ReputationRaceMask1': reputationRaceMask1,
      'ReputationRaceMask2': reputationRaceMask2,
      'ReputationRaceMask3': reputationRaceMask3,
      'ReputationClassMask0': reputationClassMask0,
      'ReputationClassMask1': reputationClassMask1,
      'ReputationClassMask2': reputationClassMask2,
      'ReputationClassMask3': reputationClassMask3,
      'ReputationBase0': reputationBase0,
      'ReputationBase1': reputationBase1,
      'ReputationBase2': reputationBase2,
      'ReputationBase3': reputationBase3,
      'ReputationFlags0': reputationFlags0,
      'ReputationFlags1': reputationFlags1,
      'ReputationFlags2': reputationFlags2,
      'ReputationFlags3': reputationFlags3,
      'ParentFactionID': parentFactionId,
      'ParentFactionMod0': parentFactionMod0,
      'ParentFactionMod1': parentFactionMod1,
      'ParentFactionCap0': parentFactionCap0,
      'ParentFactionCap1': parentFactionCap1,
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
      'Description_lang_enUS': descriptionLangEnUS,
      'Description_lang_koKR': descriptionLangKoKR,
      'Description_lang_frFR': descriptionLangFrFR,
      'Description_lang_deDE': descriptionLangDeDE,
      'Description_lang_zhCN': descriptionLangZhCN,
      'Description_lang_zhTW': descriptionLangZhTW,
      'Description_lang_esES': descriptionLangEsES,
      'Description_lang_esMX': descriptionLangEsMX,
      'Description_lang_ruRU': descriptionLangRuRU,
      'Description_lang_jaJP': descriptionLangJaJP,
      'Description_lang_ptPT': descriptionLangPtPT,
      'Description_lang_ptBR': descriptionLangPtBR,
      'Description_lang_itIT': descriptionLangItIT,
      'Description_lang_unk1': descriptionLangUnk1,
      'Description_lang_unk2': descriptionLangUnk2,
      'Description_lang_unk3': descriptionLangUnk3,
      'Description_lang_Flags': descriptionLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DbcFactionEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            reputationIndex == other.reputationIndex &&
            reputationRaceMask0 == other.reputationRaceMask0 &&
            reputationRaceMask1 == other.reputationRaceMask1 &&
            reputationRaceMask2 == other.reputationRaceMask2 &&
            reputationRaceMask3 == other.reputationRaceMask3 &&
            reputationClassMask0 == other.reputationClassMask0 &&
            reputationClassMask1 == other.reputationClassMask1 &&
            reputationClassMask2 == other.reputationClassMask2 &&
            reputationClassMask3 == other.reputationClassMask3 &&
            reputationBase0 == other.reputationBase0 &&
            reputationBase1 == other.reputationBase1 &&
            reputationBase2 == other.reputationBase2 &&
            reputationBase3 == other.reputationBase3 &&
            reputationFlags0 == other.reputationFlags0 &&
            reputationFlags1 == other.reputationFlags1 &&
            reputationFlags2 == other.reputationFlags2 &&
            reputationFlags3 == other.reputationFlags3 &&
            parentFactionId == other.parentFactionId &&
            parentFactionMod0 == other.parentFactionMod0 &&
            parentFactionMod1 == other.parentFactionMod1 &&
            parentFactionCap0 == other.parentFactionCap0 &&
            parentFactionCap1 == other.parentFactionCap1 &&
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
            descriptionLangEnUS == other.descriptionLangEnUS &&
            descriptionLangKoKR == other.descriptionLangKoKR &&
            descriptionLangFrFR == other.descriptionLangFrFR &&
            descriptionLangDeDE == other.descriptionLangDeDE &&
            descriptionLangZhCN == other.descriptionLangZhCN &&
            descriptionLangZhTW == other.descriptionLangZhTW &&
            descriptionLangEsES == other.descriptionLangEsES &&
            descriptionLangEsMX == other.descriptionLangEsMX &&
            descriptionLangRuRU == other.descriptionLangRuRU &&
            descriptionLangJaJP == other.descriptionLangJaJP &&
            descriptionLangPtPT == other.descriptionLangPtPT &&
            descriptionLangPtBR == other.descriptionLangPtBR &&
            descriptionLangItIT == other.descriptionLangItIT &&
            descriptionLangUnk1 == other.descriptionLangUnk1 &&
            descriptionLangUnk2 == other.descriptionLangUnk2 &&
            descriptionLangUnk3 == other.descriptionLangUnk3 &&
            descriptionLangFlags == other.descriptionLangFlags;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      reputationIndex,
      reputationRaceMask0,
      reputationRaceMask1,
      reputationRaceMask2,
      reputationRaceMask3,
      reputationClassMask0,
      reputationClassMask1,
      reputationClassMask2,
      reputationClassMask3,
      reputationBase0,
      reputationBase1,
      reputationBase2,
      reputationBase3,
      reputationFlags0,
      reputationFlags1,
      reputationFlags2,
      reputationFlags3,
      parentFactionId,
      parentFactionMod0,
      parentFactionMod1,
      parentFactionCap0,
      parentFactionCap1,
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
      descriptionLangEnUS,
      descriptionLangKoKR,
      descriptionLangFrFR,
      descriptionLangDeDE,
      descriptionLangZhCN,
      descriptionLangZhTW,
      descriptionLangEsES,
      descriptionLangEsMX,
      descriptionLangRuRU,
      descriptionLangJaJP,
      descriptionLangPtPT,
      descriptionLangPtBR,
      descriptionLangItIT,
      descriptionLangUnk1,
      descriptionLangUnk2,
      descriptionLangUnk3,
      descriptionLangFlags,
    ]);
  }

  @override
  String toString() {
    return 'DbcFactionEntity('
        'id: $id, '
        'reputationIndex: $reputationIndex, '
        'reputationRaceMask0: $reputationRaceMask0, '
        'reputationRaceMask1: $reputationRaceMask1, '
        'reputationRaceMask2: $reputationRaceMask2, '
        'reputationRaceMask3: $reputationRaceMask3, '
        'reputationClassMask0: $reputationClassMask0, '
        'reputationClassMask1: $reputationClassMask1, '
        'reputationClassMask2: $reputationClassMask2, '
        'reputationClassMask3: $reputationClassMask3, '
        'reputationBase0: $reputationBase0, '
        'reputationBase1: $reputationBase1, '
        'reputationBase2: $reputationBase2, '
        'reputationBase3: $reputationBase3, '
        'reputationFlags0: $reputationFlags0, '
        'reputationFlags1: $reputationFlags1, '
        'reputationFlags2: $reputationFlags2, '
        'reputationFlags3: $reputationFlags3, '
        'parentFactionId: $parentFactionId, '
        'parentFactionMod0: $parentFactionMod0, '
        'parentFactionMod1: $parentFactionMod1, '
        'parentFactionCap0: $parentFactionCap0, '
        'parentFactionCap1: $parentFactionCap1, '
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
        'descriptionLangEnUS: $descriptionLangEnUS, '
        'descriptionLangKoKR: $descriptionLangKoKR, '
        'descriptionLangFrFR: $descriptionLangFrFR, '
        'descriptionLangDeDE: $descriptionLangDeDE, '
        'descriptionLangZhCN: $descriptionLangZhCN, '
        'descriptionLangZhTW: $descriptionLangZhTW, '
        'descriptionLangEsES: $descriptionLangEsES, '
        'descriptionLangEsMX: $descriptionLangEsMX, '
        'descriptionLangRuRU: $descriptionLangRuRU, '
        'descriptionLangJaJP: $descriptionLangJaJP, '
        'descriptionLangPtPT: $descriptionLangPtPT, '
        'descriptionLangPtBR: $descriptionLangPtBR, '
        'descriptionLangItIT: $descriptionLangItIT, '
        'descriptionLangUnk1: $descriptionLangUnk1, '
        'descriptionLangUnk2: $descriptionLangUnk2, '
        'descriptionLangUnk3: $descriptionLangUnk3, '
        'descriptionLangFlags: $descriptionLangFlags'
        ')';
  }
}
