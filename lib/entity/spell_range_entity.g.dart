// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_range_entity.dart';

mixin _SpellRangeEntityMixin {
  static SpellRangeEntity fromJson(Map<String, dynamic> json) {
    return SpellRangeEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      rangeMin0: (json['RangeMin0'] as num?)?.toDouble() ?? 0.0,
      rangeMin1: (json['RangeMin1'] as num?)?.toDouble() ?? 0.0,
      rangeMax0: (json['RangeMax0'] as num?)?.toDouble() ?? 0.0,
      rangeMax1: (json['RangeMax1'] as num?)?.toDouble() ?? 0.0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      displayNameLangEnUS: json['DisplayName_lang_enUS']?.toString() ?? '',
      displayNameLangKoKR: json['DisplayName_lang_koKR']?.toString() ?? '',
      displayNameLangFrFR: json['DisplayName_lang_frFR']?.toString() ?? '',
      displayNameLangDeDE: json['DisplayName_lang_deDE']?.toString() ?? '',
      displayNameLangZhCN: json['DisplayName_lang_zhCN']?.toString() ?? '',
      displayNameLangZhTW: json['DisplayName_lang_zhTW']?.toString() ?? '',
      displayNameLangEsES: json['DisplayName_lang_esES']?.toString() ?? '',
      displayNameLangEsMX: json['DisplayName_lang_esMX']?.toString() ?? '',
      displayNameLangRuRU: json['DisplayName_lang_ruRU']?.toString() ?? '',
      displayNameLangJaJP: json['DisplayName_lang_jaJP']?.toString() ?? '',
      displayNameLangPtPT: json['DisplayName_lang_ptPT']?.toString() ?? '',
      displayNameLangPtBR: json['DisplayName_lang_ptBR']?.toString() ?? '',
      displayNameLangItIT: json['DisplayName_lang_itIT']?.toString() ?? '',
      displayNameLangUnk1: json['DisplayName_lang_unk1']?.toString() ?? '',
      displayNameLangUnk2: json['DisplayName_lang_unk2']?.toString() ?? '',
      displayNameLangUnk3: json['DisplayName_lang_unk3']?.toString() ?? '',
      displayNameLangFlags:
          (json['DisplayName_lang_Flags'] as num?)?.toInt() ?? 0,
      displayNameShortLangEnUS:
          json['DisplayNameShort_lang_enUS']?.toString() ?? '',
      displayNameShortLangKoKR:
          json['DisplayNameShort_lang_koKR']?.toString() ?? '',
      displayNameShortLangFrFR:
          json['DisplayNameShort_lang_frFR']?.toString() ?? '',
      displayNameShortLangDeDE:
          json['DisplayNameShort_lang_deDE']?.toString() ?? '',
      displayNameShortLangZhCN:
          json['DisplayNameShort_lang_zhCN']?.toString() ?? '',
      displayNameShortLangZhTW:
          json['DisplayNameShort_lang_zhTW']?.toString() ?? '',
      displayNameShortLangEsES:
          json['DisplayNameShort_lang_esES']?.toString() ?? '',
      displayNameShortLangEsMX:
          json['DisplayNameShort_lang_esMX']?.toString() ?? '',
      displayNameShortLangRuRU:
          json['DisplayNameShort_lang_ruRU']?.toString() ?? '',
      displayNameShortLangJaJP:
          json['DisplayNameShort_lang_jaJP']?.toString() ?? '',
      displayNameShortLangPtPT:
          json['DisplayNameShort_lang_ptPT']?.toString() ?? '',
      displayNameShortLangPtBR:
          json['DisplayNameShort_lang_ptBR']?.toString() ?? '',
      displayNameShortLangItIT:
          json['DisplayNameShort_lang_itIT']?.toString() ?? '',
      displayNameShortLangUnk1:
          json['DisplayNameShort_lang_unk1']?.toString() ?? '',
      displayNameShortLangUnk2:
          json['DisplayNameShort_lang_unk2']?.toString() ?? '',
      displayNameShortLangUnk3:
          json['DisplayNameShort_lang_unk3']?.toString() ?? '',
      displayNameShortLangFlags:
          (json['DisplayNameShort_lang_Flags'] as num?)?.toInt() ?? 0,
    );
  }

  SpellRangeEntity copyWith({
    int? id,
    double? rangeMin0,
    double? rangeMin1,
    double? rangeMax0,
    double? rangeMax1,
    int? flags,
    String? displayNameLangEnUS,
    String? displayNameLangKoKR,
    String? displayNameLangFrFR,
    String? displayNameLangDeDE,
    String? displayNameLangZhCN,
    String? displayNameLangZhTW,
    String? displayNameLangEsES,
    String? displayNameLangEsMX,
    String? displayNameLangRuRU,
    String? displayNameLangJaJP,
    String? displayNameLangPtPT,
    String? displayNameLangPtBR,
    String? displayNameLangItIT,
    String? displayNameLangUnk1,
    String? displayNameLangUnk2,
    String? displayNameLangUnk3,
    int? displayNameLangFlags,
    String? displayNameShortLangEnUS,
    String? displayNameShortLangKoKR,
    String? displayNameShortLangFrFR,
    String? displayNameShortLangDeDE,
    String? displayNameShortLangZhCN,
    String? displayNameShortLangZhTW,
    String? displayNameShortLangEsES,
    String? displayNameShortLangEsMX,
    String? displayNameShortLangRuRU,
    String? displayNameShortLangJaJP,
    String? displayNameShortLangPtPT,
    String? displayNameShortLangPtBR,
    String? displayNameShortLangItIT,
    String? displayNameShortLangUnk1,
    String? displayNameShortLangUnk2,
    String? displayNameShortLangUnk3,
    int? displayNameShortLangFlags,
  }) {
    final self = this as SpellRangeEntity;
    return SpellRangeEntity(
      id: id ?? self.id,
      rangeMin0: rangeMin0 ?? self.rangeMin0,
      rangeMin1: rangeMin1 ?? self.rangeMin1,
      rangeMax0: rangeMax0 ?? self.rangeMax0,
      rangeMax1: rangeMax1 ?? self.rangeMax1,
      flags: flags ?? self.flags,
      displayNameLangEnUS: displayNameLangEnUS ?? self.displayNameLangEnUS,
      displayNameLangKoKR: displayNameLangKoKR ?? self.displayNameLangKoKR,
      displayNameLangFrFR: displayNameLangFrFR ?? self.displayNameLangFrFR,
      displayNameLangDeDE: displayNameLangDeDE ?? self.displayNameLangDeDE,
      displayNameLangZhCN: displayNameLangZhCN ?? self.displayNameLangZhCN,
      displayNameLangZhTW: displayNameLangZhTW ?? self.displayNameLangZhTW,
      displayNameLangEsES: displayNameLangEsES ?? self.displayNameLangEsES,
      displayNameLangEsMX: displayNameLangEsMX ?? self.displayNameLangEsMX,
      displayNameLangRuRU: displayNameLangRuRU ?? self.displayNameLangRuRU,
      displayNameLangJaJP: displayNameLangJaJP ?? self.displayNameLangJaJP,
      displayNameLangPtPT: displayNameLangPtPT ?? self.displayNameLangPtPT,
      displayNameLangPtBR: displayNameLangPtBR ?? self.displayNameLangPtBR,
      displayNameLangItIT: displayNameLangItIT ?? self.displayNameLangItIT,
      displayNameLangUnk1: displayNameLangUnk1 ?? self.displayNameLangUnk1,
      displayNameLangUnk2: displayNameLangUnk2 ?? self.displayNameLangUnk2,
      displayNameLangUnk3: displayNameLangUnk3 ?? self.displayNameLangUnk3,
      displayNameLangFlags: displayNameLangFlags ?? self.displayNameLangFlags,
      displayNameShortLangEnUS:
          displayNameShortLangEnUS ?? self.displayNameShortLangEnUS,
      displayNameShortLangKoKR:
          displayNameShortLangKoKR ?? self.displayNameShortLangKoKR,
      displayNameShortLangFrFR:
          displayNameShortLangFrFR ?? self.displayNameShortLangFrFR,
      displayNameShortLangDeDE:
          displayNameShortLangDeDE ?? self.displayNameShortLangDeDE,
      displayNameShortLangZhCN:
          displayNameShortLangZhCN ?? self.displayNameShortLangZhCN,
      displayNameShortLangZhTW:
          displayNameShortLangZhTW ?? self.displayNameShortLangZhTW,
      displayNameShortLangEsES:
          displayNameShortLangEsES ?? self.displayNameShortLangEsES,
      displayNameShortLangEsMX:
          displayNameShortLangEsMX ?? self.displayNameShortLangEsMX,
      displayNameShortLangRuRU:
          displayNameShortLangRuRU ?? self.displayNameShortLangRuRU,
      displayNameShortLangJaJP:
          displayNameShortLangJaJP ?? self.displayNameShortLangJaJP,
      displayNameShortLangPtPT:
          displayNameShortLangPtPT ?? self.displayNameShortLangPtPT,
      displayNameShortLangPtBR:
          displayNameShortLangPtBR ?? self.displayNameShortLangPtBR,
      displayNameShortLangItIT:
          displayNameShortLangItIT ?? self.displayNameShortLangItIT,
      displayNameShortLangUnk1:
          displayNameShortLangUnk1 ?? self.displayNameShortLangUnk1,
      displayNameShortLangUnk2:
          displayNameShortLangUnk2 ?? self.displayNameShortLangUnk2,
      displayNameShortLangUnk3:
          displayNameShortLangUnk3 ?? self.displayNameShortLangUnk3,
      displayNameShortLangFlags:
          displayNameShortLangFlags ?? self.displayNameShortLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellRangeEntity;
    return {
      'ID': self.id,
      'RangeMin0': self.rangeMin0,
      'RangeMin1': self.rangeMin1,
      'RangeMax0': self.rangeMax0,
      'RangeMax1': self.rangeMax1,
      'Flags': self.flags,
      'DisplayName_lang_enUS': self.displayNameLangEnUS,
      'DisplayName_lang_koKR': self.displayNameLangKoKR,
      'DisplayName_lang_frFR': self.displayNameLangFrFR,
      'DisplayName_lang_deDE': self.displayNameLangDeDE,
      'DisplayName_lang_zhCN': self.displayNameLangZhCN,
      'DisplayName_lang_zhTW': self.displayNameLangZhTW,
      'DisplayName_lang_esES': self.displayNameLangEsES,
      'DisplayName_lang_esMX': self.displayNameLangEsMX,
      'DisplayName_lang_ruRU': self.displayNameLangRuRU,
      'DisplayName_lang_jaJP': self.displayNameLangJaJP,
      'DisplayName_lang_ptPT': self.displayNameLangPtPT,
      'DisplayName_lang_ptBR': self.displayNameLangPtBR,
      'DisplayName_lang_itIT': self.displayNameLangItIT,
      'DisplayName_lang_unk1': self.displayNameLangUnk1,
      'DisplayName_lang_unk2': self.displayNameLangUnk2,
      'DisplayName_lang_unk3': self.displayNameLangUnk3,
      'DisplayName_lang_Flags': self.displayNameLangFlags,
      'DisplayNameShort_lang_enUS': self.displayNameShortLangEnUS,
      'DisplayNameShort_lang_koKR': self.displayNameShortLangKoKR,
      'DisplayNameShort_lang_frFR': self.displayNameShortLangFrFR,
      'DisplayNameShort_lang_deDE': self.displayNameShortLangDeDE,
      'DisplayNameShort_lang_zhCN': self.displayNameShortLangZhCN,
      'DisplayNameShort_lang_zhTW': self.displayNameShortLangZhTW,
      'DisplayNameShort_lang_esES': self.displayNameShortLangEsES,
      'DisplayNameShort_lang_esMX': self.displayNameShortLangEsMX,
      'DisplayNameShort_lang_ruRU': self.displayNameShortLangRuRU,
      'DisplayNameShort_lang_jaJP': self.displayNameShortLangJaJP,
      'DisplayNameShort_lang_ptPT': self.displayNameShortLangPtPT,
      'DisplayNameShort_lang_ptBR': self.displayNameShortLangPtBR,
      'DisplayNameShort_lang_itIT': self.displayNameShortLangItIT,
      'DisplayNameShort_lang_unk1': self.displayNameShortLangUnk1,
      'DisplayNameShort_lang_unk2': self.displayNameShortLangUnk2,
      'DisplayNameShort_lang_unk3': self.displayNameShortLangUnk3,
      'DisplayNameShort_lang_Flags': self.displayNameShortLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellRangeEntity;
    return identical(self, other) ||
        other is SpellRangeEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.rangeMin0 == other.rangeMin0 &&
            self.rangeMin1 == other.rangeMin1 &&
            self.rangeMax0 == other.rangeMax0 &&
            self.rangeMax1 == other.rangeMax1 &&
            self.flags == other.flags &&
            self.displayNameLangEnUS == other.displayNameLangEnUS &&
            self.displayNameLangKoKR == other.displayNameLangKoKR &&
            self.displayNameLangFrFR == other.displayNameLangFrFR &&
            self.displayNameLangDeDE == other.displayNameLangDeDE &&
            self.displayNameLangZhCN == other.displayNameLangZhCN &&
            self.displayNameLangZhTW == other.displayNameLangZhTW &&
            self.displayNameLangEsES == other.displayNameLangEsES &&
            self.displayNameLangEsMX == other.displayNameLangEsMX &&
            self.displayNameLangRuRU == other.displayNameLangRuRU &&
            self.displayNameLangJaJP == other.displayNameLangJaJP &&
            self.displayNameLangPtPT == other.displayNameLangPtPT &&
            self.displayNameLangPtBR == other.displayNameLangPtBR &&
            self.displayNameLangItIT == other.displayNameLangItIT &&
            self.displayNameLangUnk1 == other.displayNameLangUnk1 &&
            self.displayNameLangUnk2 == other.displayNameLangUnk2 &&
            self.displayNameLangUnk3 == other.displayNameLangUnk3 &&
            self.displayNameLangFlags == other.displayNameLangFlags &&
            self.displayNameShortLangEnUS == other.displayNameShortLangEnUS &&
            self.displayNameShortLangKoKR == other.displayNameShortLangKoKR &&
            self.displayNameShortLangFrFR == other.displayNameShortLangFrFR &&
            self.displayNameShortLangDeDE == other.displayNameShortLangDeDE &&
            self.displayNameShortLangZhCN == other.displayNameShortLangZhCN &&
            self.displayNameShortLangZhTW == other.displayNameShortLangZhTW &&
            self.displayNameShortLangEsES == other.displayNameShortLangEsES &&
            self.displayNameShortLangEsMX == other.displayNameShortLangEsMX &&
            self.displayNameShortLangRuRU == other.displayNameShortLangRuRU &&
            self.displayNameShortLangJaJP == other.displayNameShortLangJaJP &&
            self.displayNameShortLangPtPT == other.displayNameShortLangPtPT &&
            self.displayNameShortLangPtBR == other.displayNameShortLangPtBR &&
            self.displayNameShortLangItIT == other.displayNameShortLangItIT &&
            self.displayNameShortLangUnk1 == other.displayNameShortLangUnk1 &&
            self.displayNameShortLangUnk2 == other.displayNameShortLangUnk2 &&
            self.displayNameShortLangUnk3 == other.displayNameShortLangUnk3 &&
            self.displayNameShortLangFlags == other.displayNameShortLangFlags;
  }

  @override
  int get hashCode {
    final self = this as SpellRangeEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.rangeMin0,
      self.rangeMin1,
      self.rangeMax0,
      self.rangeMax1,
      self.flags,
      self.displayNameLangEnUS,
      self.displayNameLangKoKR,
      self.displayNameLangFrFR,
      self.displayNameLangDeDE,
      self.displayNameLangZhCN,
      self.displayNameLangZhTW,
      self.displayNameLangEsES,
      self.displayNameLangEsMX,
      self.displayNameLangRuRU,
      self.displayNameLangJaJP,
      self.displayNameLangPtPT,
      self.displayNameLangPtBR,
      self.displayNameLangItIT,
      self.displayNameLangUnk1,
      self.displayNameLangUnk2,
      self.displayNameLangUnk3,
      self.displayNameLangFlags,
      self.displayNameShortLangEnUS,
      self.displayNameShortLangKoKR,
      self.displayNameShortLangFrFR,
      self.displayNameShortLangDeDE,
      self.displayNameShortLangZhCN,
      self.displayNameShortLangZhTW,
      self.displayNameShortLangEsES,
      self.displayNameShortLangEsMX,
      self.displayNameShortLangRuRU,
      self.displayNameShortLangJaJP,
      self.displayNameShortLangPtPT,
      self.displayNameShortLangPtBR,
      self.displayNameShortLangItIT,
      self.displayNameShortLangUnk1,
      self.displayNameShortLangUnk2,
      self.displayNameShortLangUnk3,
      self.displayNameShortLangFlags,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellRangeEntity;
    return 'SpellRangeEntity('
        'id: ${self.id}, '
        'rangeMin0: ${self.rangeMin0}, '
        'rangeMin1: ${self.rangeMin1}, '
        'rangeMax0: ${self.rangeMax0}, '
        'rangeMax1: ${self.rangeMax1}, '
        'flags: ${self.flags}, '
        'displayNameLangEnUS: ${self.displayNameLangEnUS}, '
        'displayNameLangKoKR: ${self.displayNameLangKoKR}, '
        'displayNameLangFrFR: ${self.displayNameLangFrFR}, '
        'displayNameLangDeDE: ${self.displayNameLangDeDE}, '
        'displayNameLangZhCN: ${self.displayNameLangZhCN}, '
        'displayNameLangZhTW: ${self.displayNameLangZhTW}, '
        'displayNameLangEsES: ${self.displayNameLangEsES}, '
        'displayNameLangEsMX: ${self.displayNameLangEsMX}, '
        'displayNameLangRuRU: ${self.displayNameLangRuRU}, '
        'displayNameLangJaJP: ${self.displayNameLangJaJP}, '
        'displayNameLangPtPT: ${self.displayNameLangPtPT}, '
        'displayNameLangPtBR: ${self.displayNameLangPtBR}, '
        'displayNameLangItIT: ${self.displayNameLangItIT}, '
        'displayNameLangUnk1: ${self.displayNameLangUnk1}, '
        'displayNameLangUnk2: ${self.displayNameLangUnk2}, '
        'displayNameLangUnk3: ${self.displayNameLangUnk3}, '
        'displayNameLangFlags: ${self.displayNameLangFlags}, '
        'displayNameShortLangEnUS: ${self.displayNameShortLangEnUS}, '
        'displayNameShortLangKoKR: ${self.displayNameShortLangKoKR}, '
        'displayNameShortLangFrFR: ${self.displayNameShortLangFrFR}, '
        'displayNameShortLangDeDE: ${self.displayNameShortLangDeDE}, '
        'displayNameShortLangZhCN: ${self.displayNameShortLangZhCN}, '
        'displayNameShortLangZhTW: ${self.displayNameShortLangZhTW}, '
        'displayNameShortLangEsES: ${self.displayNameShortLangEsES}, '
        'displayNameShortLangEsMX: ${self.displayNameShortLangEsMX}, '
        'displayNameShortLangRuRU: ${self.displayNameShortLangRuRU}, '
        'displayNameShortLangJaJP: ${self.displayNameShortLangJaJP}, '
        'displayNameShortLangPtPT: ${self.displayNameShortLangPtPT}, '
        'displayNameShortLangPtBR: ${self.displayNameShortLangPtBR}, '
        'displayNameShortLangItIT: ${self.displayNameShortLangItIT}, '
        'displayNameShortLangUnk1: ${self.displayNameShortLangUnk1}, '
        'displayNameShortLangUnk2: ${self.displayNameShortLangUnk2}, '
        'displayNameShortLangUnk3: ${self.displayNameShortLangUnk3}, '
        'displayNameShortLangFlags: ${self.displayNameShortLangFlags}'
        ')';
  }
}

final class BriefSpellRangeEntity {
  final int id;
  final double rangeMin0;
  final double rangeMax0;
  final String displayNameLangZhCN;

  const BriefSpellRangeEntity({
    this.id = 0,
    this.rangeMin0 = 0.0,
    this.rangeMax0 = 0.0,
    this.displayNameLangZhCN = '',
  });

  factory BriefSpellRangeEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellRangeEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      rangeMin0: (json['RangeMin0'] as num?)?.toDouble() ?? 0.0,
      rangeMax0: (json['RangeMax0'] as num?)?.toDouble() ?? 0.0,
      displayNameLangZhCN: json['DisplayName_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
