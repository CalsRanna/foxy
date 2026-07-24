// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_entity.dart';

mixin _DbcFactionEntityMixin {
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
    final self = this as DbcFactionEntity;
    return DbcFactionEntity(
      id: id ?? self.id,
      reputationIndex: reputationIndex ?? self.reputationIndex,
      reputationRaceMask0: reputationRaceMask0 ?? self.reputationRaceMask0,
      reputationRaceMask1: reputationRaceMask1 ?? self.reputationRaceMask1,
      reputationRaceMask2: reputationRaceMask2 ?? self.reputationRaceMask2,
      reputationRaceMask3: reputationRaceMask3 ?? self.reputationRaceMask3,
      reputationClassMask0: reputationClassMask0 ?? self.reputationClassMask0,
      reputationClassMask1: reputationClassMask1 ?? self.reputationClassMask1,
      reputationClassMask2: reputationClassMask2 ?? self.reputationClassMask2,
      reputationClassMask3: reputationClassMask3 ?? self.reputationClassMask3,
      reputationBase0: reputationBase0 ?? self.reputationBase0,
      reputationBase1: reputationBase1 ?? self.reputationBase1,
      reputationBase2: reputationBase2 ?? self.reputationBase2,
      reputationBase3: reputationBase3 ?? self.reputationBase3,
      reputationFlags0: reputationFlags0 ?? self.reputationFlags0,
      reputationFlags1: reputationFlags1 ?? self.reputationFlags1,
      reputationFlags2: reputationFlags2 ?? self.reputationFlags2,
      reputationFlags3: reputationFlags3 ?? self.reputationFlags3,
      parentFactionId: parentFactionId ?? self.parentFactionId,
      parentFactionMod0: parentFactionMod0 ?? self.parentFactionMod0,
      parentFactionMod1: parentFactionMod1 ?? self.parentFactionMod1,
      parentFactionCap0: parentFactionCap0 ?? self.parentFactionCap0,
      parentFactionCap1: parentFactionCap1 ?? self.parentFactionCap1,
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
      descriptionLangEnUS: descriptionLangEnUS ?? self.descriptionLangEnUS,
      descriptionLangKoKR: descriptionLangKoKR ?? self.descriptionLangKoKR,
      descriptionLangFrFR: descriptionLangFrFR ?? self.descriptionLangFrFR,
      descriptionLangDeDE: descriptionLangDeDE ?? self.descriptionLangDeDE,
      descriptionLangZhCN: descriptionLangZhCN ?? self.descriptionLangZhCN,
      descriptionLangZhTW: descriptionLangZhTW ?? self.descriptionLangZhTW,
      descriptionLangEsES: descriptionLangEsES ?? self.descriptionLangEsES,
      descriptionLangEsMX: descriptionLangEsMX ?? self.descriptionLangEsMX,
      descriptionLangRuRU: descriptionLangRuRU ?? self.descriptionLangRuRU,
      descriptionLangJaJP: descriptionLangJaJP ?? self.descriptionLangJaJP,
      descriptionLangPtPT: descriptionLangPtPT ?? self.descriptionLangPtPT,
      descriptionLangPtBR: descriptionLangPtBR ?? self.descriptionLangPtBR,
      descriptionLangItIT: descriptionLangItIT ?? self.descriptionLangItIT,
      descriptionLangUnk1: descriptionLangUnk1 ?? self.descriptionLangUnk1,
      descriptionLangUnk2: descriptionLangUnk2 ?? self.descriptionLangUnk2,
      descriptionLangUnk3: descriptionLangUnk3 ?? self.descriptionLangUnk3,
      descriptionLangFlags: descriptionLangFlags ?? self.descriptionLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as DbcFactionEntity;
    return {
      'ID': self.id,
      'ReputationIndex': self.reputationIndex,
      'ReputationRaceMask0': self.reputationRaceMask0,
      'ReputationRaceMask1': self.reputationRaceMask1,
      'ReputationRaceMask2': self.reputationRaceMask2,
      'ReputationRaceMask3': self.reputationRaceMask3,
      'ReputationClassMask0': self.reputationClassMask0,
      'ReputationClassMask1': self.reputationClassMask1,
      'ReputationClassMask2': self.reputationClassMask2,
      'ReputationClassMask3': self.reputationClassMask3,
      'ReputationBase0': self.reputationBase0,
      'ReputationBase1': self.reputationBase1,
      'ReputationBase2': self.reputationBase2,
      'ReputationBase3': self.reputationBase3,
      'ReputationFlags0': self.reputationFlags0,
      'ReputationFlags1': self.reputationFlags1,
      'ReputationFlags2': self.reputationFlags2,
      'ReputationFlags3': self.reputationFlags3,
      'ParentFactionID': self.parentFactionId,
      'ParentFactionMod0': self.parentFactionMod0,
      'ParentFactionMod1': self.parentFactionMod1,
      'ParentFactionCap0': self.parentFactionCap0,
      'ParentFactionCap1': self.parentFactionCap1,
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
      'Description_lang_enUS': self.descriptionLangEnUS,
      'Description_lang_koKR': self.descriptionLangKoKR,
      'Description_lang_frFR': self.descriptionLangFrFR,
      'Description_lang_deDE': self.descriptionLangDeDE,
      'Description_lang_zhCN': self.descriptionLangZhCN,
      'Description_lang_zhTW': self.descriptionLangZhTW,
      'Description_lang_esES': self.descriptionLangEsES,
      'Description_lang_esMX': self.descriptionLangEsMX,
      'Description_lang_ruRU': self.descriptionLangRuRU,
      'Description_lang_jaJP': self.descriptionLangJaJP,
      'Description_lang_ptPT': self.descriptionLangPtPT,
      'Description_lang_ptBR': self.descriptionLangPtBR,
      'Description_lang_itIT': self.descriptionLangItIT,
      'Description_lang_unk1': self.descriptionLangUnk1,
      'Description_lang_unk2': self.descriptionLangUnk2,
      'Description_lang_unk3': self.descriptionLangUnk3,
      'Description_lang_Flags': self.descriptionLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as DbcFactionEntity;
    return identical(self, other) ||
        other is DbcFactionEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.reputationIndex == other.reputationIndex &&
            self.reputationRaceMask0 == other.reputationRaceMask0 &&
            self.reputationRaceMask1 == other.reputationRaceMask1 &&
            self.reputationRaceMask2 == other.reputationRaceMask2 &&
            self.reputationRaceMask3 == other.reputationRaceMask3 &&
            self.reputationClassMask0 == other.reputationClassMask0 &&
            self.reputationClassMask1 == other.reputationClassMask1 &&
            self.reputationClassMask2 == other.reputationClassMask2 &&
            self.reputationClassMask3 == other.reputationClassMask3 &&
            self.reputationBase0 == other.reputationBase0 &&
            self.reputationBase1 == other.reputationBase1 &&
            self.reputationBase2 == other.reputationBase2 &&
            self.reputationBase3 == other.reputationBase3 &&
            self.reputationFlags0 == other.reputationFlags0 &&
            self.reputationFlags1 == other.reputationFlags1 &&
            self.reputationFlags2 == other.reputationFlags2 &&
            self.reputationFlags3 == other.reputationFlags3 &&
            self.parentFactionId == other.parentFactionId &&
            self.parentFactionMod0 == other.parentFactionMod0 &&
            self.parentFactionMod1 == other.parentFactionMod1 &&
            self.parentFactionCap0 == other.parentFactionCap0 &&
            self.parentFactionCap1 == other.parentFactionCap1 &&
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
            self.descriptionLangEnUS == other.descriptionLangEnUS &&
            self.descriptionLangKoKR == other.descriptionLangKoKR &&
            self.descriptionLangFrFR == other.descriptionLangFrFR &&
            self.descriptionLangDeDE == other.descriptionLangDeDE &&
            self.descriptionLangZhCN == other.descriptionLangZhCN &&
            self.descriptionLangZhTW == other.descriptionLangZhTW &&
            self.descriptionLangEsES == other.descriptionLangEsES &&
            self.descriptionLangEsMX == other.descriptionLangEsMX &&
            self.descriptionLangRuRU == other.descriptionLangRuRU &&
            self.descriptionLangJaJP == other.descriptionLangJaJP &&
            self.descriptionLangPtPT == other.descriptionLangPtPT &&
            self.descriptionLangPtBR == other.descriptionLangPtBR &&
            self.descriptionLangItIT == other.descriptionLangItIT &&
            self.descriptionLangUnk1 == other.descriptionLangUnk1 &&
            self.descriptionLangUnk2 == other.descriptionLangUnk2 &&
            self.descriptionLangUnk3 == other.descriptionLangUnk3 &&
            self.descriptionLangFlags == other.descriptionLangFlags;
  }

  @override
  int get hashCode {
    final self = this as DbcFactionEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.reputationIndex,
      self.reputationRaceMask0,
      self.reputationRaceMask1,
      self.reputationRaceMask2,
      self.reputationRaceMask3,
      self.reputationClassMask0,
      self.reputationClassMask1,
      self.reputationClassMask2,
      self.reputationClassMask3,
      self.reputationBase0,
      self.reputationBase1,
      self.reputationBase2,
      self.reputationBase3,
      self.reputationFlags0,
      self.reputationFlags1,
      self.reputationFlags2,
      self.reputationFlags3,
      self.parentFactionId,
      self.parentFactionMod0,
      self.parentFactionMod1,
      self.parentFactionCap0,
      self.parentFactionCap1,
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
      self.descriptionLangEnUS,
      self.descriptionLangKoKR,
      self.descriptionLangFrFR,
      self.descriptionLangDeDE,
      self.descriptionLangZhCN,
      self.descriptionLangZhTW,
      self.descriptionLangEsES,
      self.descriptionLangEsMX,
      self.descriptionLangRuRU,
      self.descriptionLangJaJP,
      self.descriptionLangPtPT,
      self.descriptionLangPtBR,
      self.descriptionLangItIT,
      self.descriptionLangUnk1,
      self.descriptionLangUnk2,
      self.descriptionLangUnk3,
      self.descriptionLangFlags,
    ]);
  }

  @override
  String toString() {
    final self = this as DbcFactionEntity;
    return 'DbcFactionEntity('
        'id: ${self.id}, '
        'reputationIndex: ${self.reputationIndex}, '
        'reputationRaceMask0: ${self.reputationRaceMask0}, '
        'reputationRaceMask1: ${self.reputationRaceMask1}, '
        'reputationRaceMask2: ${self.reputationRaceMask2}, '
        'reputationRaceMask3: ${self.reputationRaceMask3}, '
        'reputationClassMask0: ${self.reputationClassMask0}, '
        'reputationClassMask1: ${self.reputationClassMask1}, '
        'reputationClassMask2: ${self.reputationClassMask2}, '
        'reputationClassMask3: ${self.reputationClassMask3}, '
        'reputationBase0: ${self.reputationBase0}, '
        'reputationBase1: ${self.reputationBase1}, '
        'reputationBase2: ${self.reputationBase2}, '
        'reputationBase3: ${self.reputationBase3}, '
        'reputationFlags0: ${self.reputationFlags0}, '
        'reputationFlags1: ${self.reputationFlags1}, '
        'reputationFlags2: ${self.reputationFlags2}, '
        'reputationFlags3: ${self.reputationFlags3}, '
        'parentFactionId: ${self.parentFactionId}, '
        'parentFactionMod0: ${self.parentFactionMod0}, '
        'parentFactionMod1: ${self.parentFactionMod1}, '
        'parentFactionCap0: ${self.parentFactionCap0}, '
        'parentFactionCap1: ${self.parentFactionCap1}, '
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
        'descriptionLangEnUS: ${self.descriptionLangEnUS}, '
        'descriptionLangKoKR: ${self.descriptionLangKoKR}, '
        'descriptionLangFrFR: ${self.descriptionLangFrFR}, '
        'descriptionLangDeDE: ${self.descriptionLangDeDE}, '
        'descriptionLangZhCN: ${self.descriptionLangZhCN}, '
        'descriptionLangZhTW: ${self.descriptionLangZhTW}, '
        'descriptionLangEsES: ${self.descriptionLangEsES}, '
        'descriptionLangEsMX: ${self.descriptionLangEsMX}, '
        'descriptionLangRuRU: ${self.descriptionLangRuRU}, '
        'descriptionLangJaJP: ${self.descriptionLangJaJP}, '
        'descriptionLangPtPT: ${self.descriptionLangPtPT}, '
        'descriptionLangPtBR: ${self.descriptionLangPtBR}, '
        'descriptionLangItIT: ${self.descriptionLangItIT}, '
        'descriptionLangUnk1: ${self.descriptionLangUnk1}, '
        'descriptionLangUnk2: ${self.descriptionLangUnk2}, '
        'descriptionLangUnk3: ${self.descriptionLangUnk3}, '
        'descriptionLangFlags: ${self.descriptionLangFlags}'
        ')';
  }
}
