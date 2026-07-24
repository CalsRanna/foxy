// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_entity.dart';

mixin _SkillLineEntityMixin {
  static SkillLineEntity fromJson(Map<String, dynamic> json) {
    return SkillLineEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      categoryId: (json['CategoryID'] as num?)?.toInt() ?? 0,
      skillCostsId: (json['SkillCostsID'] as num?)?.toInt() ?? 0,
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
      spellIconId: (json['SpellIconID'] as num?)?.toInt() ?? 0,
      alternateVerbLangEnUS: json['AlternateVerb_lang_enUS']?.toString() ?? '',
      alternateVerbLangKoKR: json['AlternateVerb_lang_koKR']?.toString() ?? '',
      alternateVerbLangFrFR: json['AlternateVerb_lang_frFR']?.toString() ?? '',
      alternateVerbLangDeDE: json['AlternateVerb_lang_deDE']?.toString() ?? '',
      alternateVerbLangZhCN: json['AlternateVerb_lang_zhCN']?.toString() ?? '',
      alternateVerbLangZhTW: json['AlternateVerb_lang_zhTW']?.toString() ?? '',
      alternateVerbLangEsES: json['AlternateVerb_lang_esES']?.toString() ?? '',
      alternateVerbLangEsMX: json['AlternateVerb_lang_esMX']?.toString() ?? '',
      alternateVerbLangRuRU: json['AlternateVerb_lang_ruRU']?.toString() ?? '',
      alternateVerbLangJaJP: json['AlternateVerb_lang_jaJP']?.toString() ?? '',
      alternateVerbLangPtPT: json['AlternateVerb_lang_ptPT']?.toString() ?? '',
      alternateVerbLangPtBR: json['AlternateVerb_lang_ptBR']?.toString() ?? '',
      alternateVerbLangItIT: json['AlternateVerb_lang_itIT']?.toString() ?? '',
      alternateVerbLangUnk1: json['AlternateVerb_lang_unk1']?.toString() ?? '',
      alternateVerbLangUnk2: json['AlternateVerb_lang_unk2']?.toString() ?? '',
      alternateVerbLangUnk3: json['AlternateVerb_lang_unk3']?.toString() ?? '',
      alternateVerbLangFlags:
          (json['AlternateVerb_lang_Flags'] as num?)?.toInt() ?? 0,
      canLink: (json['CanLink'] as num?)?.toInt() ?? 0,
    );
  }

  SkillLineEntity copyWith({
    int? id,
    int? categoryId,
    int? skillCostsId,
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
    int? spellIconId,
    String? alternateVerbLangEnUS,
    String? alternateVerbLangKoKR,
    String? alternateVerbLangFrFR,
    String? alternateVerbLangDeDE,
    String? alternateVerbLangZhCN,
    String? alternateVerbLangZhTW,
    String? alternateVerbLangEsES,
    String? alternateVerbLangEsMX,
    String? alternateVerbLangRuRU,
    String? alternateVerbLangJaJP,
    String? alternateVerbLangPtPT,
    String? alternateVerbLangPtBR,
    String? alternateVerbLangItIT,
    String? alternateVerbLangUnk1,
    String? alternateVerbLangUnk2,
    String? alternateVerbLangUnk3,
    int? alternateVerbLangFlags,
    int? canLink,
  }) {
    final self = this as SkillLineEntity;
    return SkillLineEntity(
      id: id ?? self.id,
      categoryId: categoryId ?? self.categoryId,
      skillCostsId: skillCostsId ?? self.skillCostsId,
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
      spellIconId: spellIconId ?? self.spellIconId,
      alternateVerbLangEnUS:
          alternateVerbLangEnUS ?? self.alternateVerbLangEnUS,
      alternateVerbLangKoKR:
          alternateVerbLangKoKR ?? self.alternateVerbLangKoKR,
      alternateVerbLangFrFR:
          alternateVerbLangFrFR ?? self.alternateVerbLangFrFR,
      alternateVerbLangDeDE:
          alternateVerbLangDeDE ?? self.alternateVerbLangDeDE,
      alternateVerbLangZhCN:
          alternateVerbLangZhCN ?? self.alternateVerbLangZhCN,
      alternateVerbLangZhTW:
          alternateVerbLangZhTW ?? self.alternateVerbLangZhTW,
      alternateVerbLangEsES:
          alternateVerbLangEsES ?? self.alternateVerbLangEsES,
      alternateVerbLangEsMX:
          alternateVerbLangEsMX ?? self.alternateVerbLangEsMX,
      alternateVerbLangRuRU:
          alternateVerbLangRuRU ?? self.alternateVerbLangRuRU,
      alternateVerbLangJaJP:
          alternateVerbLangJaJP ?? self.alternateVerbLangJaJP,
      alternateVerbLangPtPT:
          alternateVerbLangPtPT ?? self.alternateVerbLangPtPT,
      alternateVerbLangPtBR:
          alternateVerbLangPtBR ?? self.alternateVerbLangPtBR,
      alternateVerbLangItIT:
          alternateVerbLangItIT ?? self.alternateVerbLangItIT,
      alternateVerbLangUnk1:
          alternateVerbLangUnk1 ?? self.alternateVerbLangUnk1,
      alternateVerbLangUnk2:
          alternateVerbLangUnk2 ?? self.alternateVerbLangUnk2,
      alternateVerbLangUnk3:
          alternateVerbLangUnk3 ?? self.alternateVerbLangUnk3,
      alternateVerbLangFlags:
          alternateVerbLangFlags ?? self.alternateVerbLangFlags,
      canLink: canLink ?? self.canLink,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SkillLineEntity;
    return {
      'ID': self.id,
      'CategoryID': self.categoryId,
      'SkillCostsID': self.skillCostsId,
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
      'SpellIconID': self.spellIconId,
      'AlternateVerb_lang_enUS': self.alternateVerbLangEnUS,
      'AlternateVerb_lang_koKR': self.alternateVerbLangKoKR,
      'AlternateVerb_lang_frFR': self.alternateVerbLangFrFR,
      'AlternateVerb_lang_deDE': self.alternateVerbLangDeDE,
      'AlternateVerb_lang_zhCN': self.alternateVerbLangZhCN,
      'AlternateVerb_lang_zhTW': self.alternateVerbLangZhTW,
      'AlternateVerb_lang_esES': self.alternateVerbLangEsES,
      'AlternateVerb_lang_esMX': self.alternateVerbLangEsMX,
      'AlternateVerb_lang_ruRU': self.alternateVerbLangRuRU,
      'AlternateVerb_lang_jaJP': self.alternateVerbLangJaJP,
      'AlternateVerb_lang_ptPT': self.alternateVerbLangPtPT,
      'AlternateVerb_lang_ptBR': self.alternateVerbLangPtBR,
      'AlternateVerb_lang_itIT': self.alternateVerbLangItIT,
      'AlternateVerb_lang_unk1': self.alternateVerbLangUnk1,
      'AlternateVerb_lang_unk2': self.alternateVerbLangUnk2,
      'AlternateVerb_lang_unk3': self.alternateVerbLangUnk3,
      'AlternateVerb_lang_Flags': self.alternateVerbLangFlags,
      'CanLink': self.canLink,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SkillLineEntity;
    return identical(self, other) ||
        other is SkillLineEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.categoryId == other.categoryId &&
            self.skillCostsId == other.skillCostsId &&
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
            self.descriptionLangFlags == other.descriptionLangFlags &&
            self.spellIconId == other.spellIconId &&
            self.alternateVerbLangEnUS == other.alternateVerbLangEnUS &&
            self.alternateVerbLangKoKR == other.alternateVerbLangKoKR &&
            self.alternateVerbLangFrFR == other.alternateVerbLangFrFR &&
            self.alternateVerbLangDeDE == other.alternateVerbLangDeDE &&
            self.alternateVerbLangZhCN == other.alternateVerbLangZhCN &&
            self.alternateVerbLangZhTW == other.alternateVerbLangZhTW &&
            self.alternateVerbLangEsES == other.alternateVerbLangEsES &&
            self.alternateVerbLangEsMX == other.alternateVerbLangEsMX &&
            self.alternateVerbLangRuRU == other.alternateVerbLangRuRU &&
            self.alternateVerbLangJaJP == other.alternateVerbLangJaJP &&
            self.alternateVerbLangPtPT == other.alternateVerbLangPtPT &&
            self.alternateVerbLangPtBR == other.alternateVerbLangPtBR &&
            self.alternateVerbLangItIT == other.alternateVerbLangItIT &&
            self.alternateVerbLangUnk1 == other.alternateVerbLangUnk1 &&
            self.alternateVerbLangUnk2 == other.alternateVerbLangUnk2 &&
            self.alternateVerbLangUnk3 == other.alternateVerbLangUnk3 &&
            self.alternateVerbLangFlags == other.alternateVerbLangFlags &&
            self.canLink == other.canLink;
  }

  @override
  int get hashCode {
    final self = this as SkillLineEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.categoryId,
      self.skillCostsId,
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
      self.spellIconId,
      self.alternateVerbLangEnUS,
      self.alternateVerbLangKoKR,
      self.alternateVerbLangFrFR,
      self.alternateVerbLangDeDE,
      self.alternateVerbLangZhCN,
      self.alternateVerbLangZhTW,
      self.alternateVerbLangEsES,
      self.alternateVerbLangEsMX,
      self.alternateVerbLangRuRU,
      self.alternateVerbLangJaJP,
      self.alternateVerbLangPtPT,
      self.alternateVerbLangPtBR,
      self.alternateVerbLangItIT,
      self.alternateVerbLangUnk1,
      self.alternateVerbLangUnk2,
      self.alternateVerbLangUnk3,
      self.alternateVerbLangFlags,
      self.canLink,
    ]);
  }

  @override
  String toString() {
    final self = this as SkillLineEntity;
    return 'SkillLineEntity('
        'id: ${self.id}, '
        'categoryId: ${self.categoryId}, '
        'skillCostsId: ${self.skillCostsId}, '
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
        'descriptionLangFlags: ${self.descriptionLangFlags}, '
        'spellIconId: ${self.spellIconId}, '
        'alternateVerbLangEnUS: ${self.alternateVerbLangEnUS}, '
        'alternateVerbLangKoKR: ${self.alternateVerbLangKoKR}, '
        'alternateVerbLangFrFR: ${self.alternateVerbLangFrFR}, '
        'alternateVerbLangDeDE: ${self.alternateVerbLangDeDE}, '
        'alternateVerbLangZhCN: ${self.alternateVerbLangZhCN}, '
        'alternateVerbLangZhTW: ${self.alternateVerbLangZhTW}, '
        'alternateVerbLangEsES: ${self.alternateVerbLangEsES}, '
        'alternateVerbLangEsMX: ${self.alternateVerbLangEsMX}, '
        'alternateVerbLangRuRU: ${self.alternateVerbLangRuRU}, '
        'alternateVerbLangJaJP: ${self.alternateVerbLangJaJP}, '
        'alternateVerbLangPtPT: ${self.alternateVerbLangPtPT}, '
        'alternateVerbLangPtBR: ${self.alternateVerbLangPtBR}, '
        'alternateVerbLangItIT: ${self.alternateVerbLangItIT}, '
        'alternateVerbLangUnk1: ${self.alternateVerbLangUnk1}, '
        'alternateVerbLangUnk2: ${self.alternateVerbLangUnk2}, '
        'alternateVerbLangUnk3: ${self.alternateVerbLangUnk3}, '
        'alternateVerbLangFlags: ${self.alternateVerbLangFlags}, '
        'canLink: ${self.canLink}'
        ')';
  }
}

final class BriefSkillLineEntity {
  final int id;
  final int categoryId;
  final String displayNameZhCN;

  const BriefSkillLineEntity({
    this.id = 0,
    this.categoryId = 0,
    this.displayNameZhCN = '',
  });

  factory BriefSkillLineEntity.fromJson(Map<String, dynamic> json) {
    return BriefSkillLineEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      categoryId: (json['CategoryID'] as num?)?.toInt() ?? 0,
      displayNameZhCN: json['displayNameZhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
