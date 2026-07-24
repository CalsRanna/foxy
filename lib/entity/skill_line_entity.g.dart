// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_entity.dart';

mixin _SkillLineEntityMixin {
  int get id;
  int get categoryId;
  int get skillCostsId;
  String get displayNameLangEnUS;
  String get displayNameLangKoKR;
  String get displayNameLangFrFR;
  String get displayNameLangDeDE;
  String get displayNameLangZhCN;
  String get displayNameLangZhTW;
  String get displayNameLangEsES;
  String get displayNameLangEsMX;
  String get displayNameLangRuRU;
  String get displayNameLangJaJP;
  String get displayNameLangPtPT;
  String get displayNameLangPtBR;
  String get displayNameLangItIT;
  String get displayNameLangUnk1;
  String get displayNameLangUnk2;
  String get displayNameLangUnk3;
  int get displayNameLangFlags;
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
  int get spellIconId;
  String get alternateVerbLangEnUS;
  String get alternateVerbLangKoKR;
  String get alternateVerbLangFrFR;
  String get alternateVerbLangDeDE;
  String get alternateVerbLangZhCN;
  String get alternateVerbLangZhTW;
  String get alternateVerbLangEsES;
  String get alternateVerbLangEsMX;
  String get alternateVerbLangRuRU;
  String get alternateVerbLangJaJP;
  String get alternateVerbLangPtPT;
  String get alternateVerbLangPtBR;
  String get alternateVerbLangItIT;
  String get alternateVerbLangUnk1;
  String get alternateVerbLangUnk2;
  String get alternateVerbLangUnk3;
  int get alternateVerbLangFlags;
  int get canLink;

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
    return SkillLineEntity(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      skillCostsId: skillCostsId ?? this.skillCostsId,
      displayNameLangEnUS: displayNameLangEnUS ?? this.displayNameLangEnUS,
      displayNameLangKoKR: displayNameLangKoKR ?? this.displayNameLangKoKR,
      displayNameLangFrFR: displayNameLangFrFR ?? this.displayNameLangFrFR,
      displayNameLangDeDE: displayNameLangDeDE ?? this.displayNameLangDeDE,
      displayNameLangZhCN: displayNameLangZhCN ?? this.displayNameLangZhCN,
      displayNameLangZhTW: displayNameLangZhTW ?? this.displayNameLangZhTW,
      displayNameLangEsES: displayNameLangEsES ?? this.displayNameLangEsES,
      displayNameLangEsMX: displayNameLangEsMX ?? this.displayNameLangEsMX,
      displayNameLangRuRU: displayNameLangRuRU ?? this.displayNameLangRuRU,
      displayNameLangJaJP: displayNameLangJaJP ?? this.displayNameLangJaJP,
      displayNameLangPtPT: displayNameLangPtPT ?? this.displayNameLangPtPT,
      displayNameLangPtBR: displayNameLangPtBR ?? this.displayNameLangPtBR,
      displayNameLangItIT: displayNameLangItIT ?? this.displayNameLangItIT,
      displayNameLangUnk1: displayNameLangUnk1 ?? this.displayNameLangUnk1,
      displayNameLangUnk2: displayNameLangUnk2 ?? this.displayNameLangUnk2,
      displayNameLangUnk3: displayNameLangUnk3 ?? this.displayNameLangUnk3,
      displayNameLangFlags: displayNameLangFlags ?? this.displayNameLangFlags,
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
      spellIconId: spellIconId ?? this.spellIconId,
      alternateVerbLangEnUS:
          alternateVerbLangEnUS ?? this.alternateVerbLangEnUS,
      alternateVerbLangKoKR:
          alternateVerbLangKoKR ?? this.alternateVerbLangKoKR,
      alternateVerbLangFrFR:
          alternateVerbLangFrFR ?? this.alternateVerbLangFrFR,
      alternateVerbLangDeDE:
          alternateVerbLangDeDE ?? this.alternateVerbLangDeDE,
      alternateVerbLangZhCN:
          alternateVerbLangZhCN ?? this.alternateVerbLangZhCN,
      alternateVerbLangZhTW:
          alternateVerbLangZhTW ?? this.alternateVerbLangZhTW,
      alternateVerbLangEsES:
          alternateVerbLangEsES ?? this.alternateVerbLangEsES,
      alternateVerbLangEsMX:
          alternateVerbLangEsMX ?? this.alternateVerbLangEsMX,
      alternateVerbLangRuRU:
          alternateVerbLangRuRU ?? this.alternateVerbLangRuRU,
      alternateVerbLangJaJP:
          alternateVerbLangJaJP ?? this.alternateVerbLangJaJP,
      alternateVerbLangPtPT:
          alternateVerbLangPtPT ?? this.alternateVerbLangPtPT,
      alternateVerbLangPtBR:
          alternateVerbLangPtBR ?? this.alternateVerbLangPtBR,
      alternateVerbLangItIT:
          alternateVerbLangItIT ?? this.alternateVerbLangItIT,
      alternateVerbLangUnk1:
          alternateVerbLangUnk1 ?? this.alternateVerbLangUnk1,
      alternateVerbLangUnk2:
          alternateVerbLangUnk2 ?? this.alternateVerbLangUnk2,
      alternateVerbLangUnk3:
          alternateVerbLangUnk3 ?? this.alternateVerbLangUnk3,
      alternateVerbLangFlags:
          alternateVerbLangFlags ?? this.alternateVerbLangFlags,
      canLink: canLink ?? this.canLink,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CategoryID': categoryId,
      'SkillCostsID': skillCostsId,
      'DisplayName_lang_enUS': displayNameLangEnUS,
      'DisplayName_lang_koKR': displayNameLangKoKR,
      'DisplayName_lang_frFR': displayNameLangFrFR,
      'DisplayName_lang_deDE': displayNameLangDeDE,
      'DisplayName_lang_zhCN': displayNameLangZhCN,
      'DisplayName_lang_zhTW': displayNameLangZhTW,
      'DisplayName_lang_esES': displayNameLangEsES,
      'DisplayName_lang_esMX': displayNameLangEsMX,
      'DisplayName_lang_ruRU': displayNameLangRuRU,
      'DisplayName_lang_jaJP': displayNameLangJaJP,
      'DisplayName_lang_ptPT': displayNameLangPtPT,
      'DisplayName_lang_ptBR': displayNameLangPtBR,
      'DisplayName_lang_itIT': displayNameLangItIT,
      'DisplayName_lang_unk1': displayNameLangUnk1,
      'DisplayName_lang_unk2': displayNameLangUnk2,
      'DisplayName_lang_unk3': displayNameLangUnk3,
      'DisplayName_lang_Flags': displayNameLangFlags,
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
      'SpellIconID': spellIconId,
      'AlternateVerb_lang_enUS': alternateVerbLangEnUS,
      'AlternateVerb_lang_koKR': alternateVerbLangKoKR,
      'AlternateVerb_lang_frFR': alternateVerbLangFrFR,
      'AlternateVerb_lang_deDE': alternateVerbLangDeDE,
      'AlternateVerb_lang_zhCN': alternateVerbLangZhCN,
      'AlternateVerb_lang_zhTW': alternateVerbLangZhTW,
      'AlternateVerb_lang_esES': alternateVerbLangEsES,
      'AlternateVerb_lang_esMX': alternateVerbLangEsMX,
      'AlternateVerb_lang_ruRU': alternateVerbLangRuRU,
      'AlternateVerb_lang_jaJP': alternateVerbLangJaJP,
      'AlternateVerb_lang_ptPT': alternateVerbLangPtPT,
      'AlternateVerb_lang_ptBR': alternateVerbLangPtBR,
      'AlternateVerb_lang_itIT': alternateVerbLangItIT,
      'AlternateVerb_lang_unk1': alternateVerbLangUnk1,
      'AlternateVerb_lang_unk2': alternateVerbLangUnk2,
      'AlternateVerb_lang_unk3': alternateVerbLangUnk3,
      'AlternateVerb_lang_Flags': alternateVerbLangFlags,
      'CanLink': canLink,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SkillLineEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            categoryId == other.categoryId &&
            skillCostsId == other.skillCostsId &&
            displayNameLangEnUS == other.displayNameLangEnUS &&
            displayNameLangKoKR == other.displayNameLangKoKR &&
            displayNameLangFrFR == other.displayNameLangFrFR &&
            displayNameLangDeDE == other.displayNameLangDeDE &&
            displayNameLangZhCN == other.displayNameLangZhCN &&
            displayNameLangZhTW == other.displayNameLangZhTW &&
            displayNameLangEsES == other.displayNameLangEsES &&
            displayNameLangEsMX == other.displayNameLangEsMX &&
            displayNameLangRuRU == other.displayNameLangRuRU &&
            displayNameLangJaJP == other.displayNameLangJaJP &&
            displayNameLangPtPT == other.displayNameLangPtPT &&
            displayNameLangPtBR == other.displayNameLangPtBR &&
            displayNameLangItIT == other.displayNameLangItIT &&
            displayNameLangUnk1 == other.displayNameLangUnk1 &&
            displayNameLangUnk2 == other.displayNameLangUnk2 &&
            displayNameLangUnk3 == other.displayNameLangUnk3 &&
            displayNameLangFlags == other.displayNameLangFlags &&
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
            descriptionLangFlags == other.descriptionLangFlags &&
            spellIconId == other.spellIconId &&
            alternateVerbLangEnUS == other.alternateVerbLangEnUS &&
            alternateVerbLangKoKR == other.alternateVerbLangKoKR &&
            alternateVerbLangFrFR == other.alternateVerbLangFrFR &&
            alternateVerbLangDeDE == other.alternateVerbLangDeDE &&
            alternateVerbLangZhCN == other.alternateVerbLangZhCN &&
            alternateVerbLangZhTW == other.alternateVerbLangZhTW &&
            alternateVerbLangEsES == other.alternateVerbLangEsES &&
            alternateVerbLangEsMX == other.alternateVerbLangEsMX &&
            alternateVerbLangRuRU == other.alternateVerbLangRuRU &&
            alternateVerbLangJaJP == other.alternateVerbLangJaJP &&
            alternateVerbLangPtPT == other.alternateVerbLangPtPT &&
            alternateVerbLangPtBR == other.alternateVerbLangPtBR &&
            alternateVerbLangItIT == other.alternateVerbLangItIT &&
            alternateVerbLangUnk1 == other.alternateVerbLangUnk1 &&
            alternateVerbLangUnk2 == other.alternateVerbLangUnk2 &&
            alternateVerbLangUnk3 == other.alternateVerbLangUnk3 &&
            alternateVerbLangFlags == other.alternateVerbLangFlags &&
            canLink == other.canLink;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      categoryId,
      skillCostsId,
      displayNameLangEnUS,
      displayNameLangKoKR,
      displayNameLangFrFR,
      displayNameLangDeDE,
      displayNameLangZhCN,
      displayNameLangZhTW,
      displayNameLangEsES,
      displayNameLangEsMX,
      displayNameLangRuRU,
      displayNameLangJaJP,
      displayNameLangPtPT,
      displayNameLangPtBR,
      displayNameLangItIT,
      displayNameLangUnk1,
      displayNameLangUnk2,
      displayNameLangUnk3,
      displayNameLangFlags,
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
      spellIconId,
      alternateVerbLangEnUS,
      alternateVerbLangKoKR,
      alternateVerbLangFrFR,
      alternateVerbLangDeDE,
      alternateVerbLangZhCN,
      alternateVerbLangZhTW,
      alternateVerbLangEsES,
      alternateVerbLangEsMX,
      alternateVerbLangRuRU,
      alternateVerbLangJaJP,
      alternateVerbLangPtPT,
      alternateVerbLangPtBR,
      alternateVerbLangItIT,
      alternateVerbLangUnk1,
      alternateVerbLangUnk2,
      alternateVerbLangUnk3,
      alternateVerbLangFlags,
      canLink,
    ]);
  }

  @override
  String toString() {
    return 'SkillLineEntity('
        'id: $id, '
        'categoryId: $categoryId, '
        'skillCostsId: $skillCostsId, '
        'displayNameLangEnUS: $displayNameLangEnUS, '
        'displayNameLangKoKR: $displayNameLangKoKR, '
        'displayNameLangFrFR: $displayNameLangFrFR, '
        'displayNameLangDeDE: $displayNameLangDeDE, '
        'displayNameLangZhCN: $displayNameLangZhCN, '
        'displayNameLangZhTW: $displayNameLangZhTW, '
        'displayNameLangEsES: $displayNameLangEsES, '
        'displayNameLangEsMX: $displayNameLangEsMX, '
        'displayNameLangRuRU: $displayNameLangRuRU, '
        'displayNameLangJaJP: $displayNameLangJaJP, '
        'displayNameLangPtPT: $displayNameLangPtPT, '
        'displayNameLangPtBR: $displayNameLangPtBR, '
        'displayNameLangItIT: $displayNameLangItIT, '
        'displayNameLangUnk1: $displayNameLangUnk1, '
        'displayNameLangUnk2: $displayNameLangUnk2, '
        'displayNameLangUnk3: $displayNameLangUnk3, '
        'displayNameLangFlags: $displayNameLangFlags, '
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
        'descriptionLangFlags: $descriptionLangFlags, '
        'spellIconId: $spellIconId, '
        'alternateVerbLangEnUS: $alternateVerbLangEnUS, '
        'alternateVerbLangKoKR: $alternateVerbLangKoKR, '
        'alternateVerbLangFrFR: $alternateVerbLangFrFR, '
        'alternateVerbLangDeDE: $alternateVerbLangDeDE, '
        'alternateVerbLangZhCN: $alternateVerbLangZhCN, '
        'alternateVerbLangZhTW: $alternateVerbLangZhTW, '
        'alternateVerbLangEsES: $alternateVerbLangEsES, '
        'alternateVerbLangEsMX: $alternateVerbLangEsMX, '
        'alternateVerbLangRuRU: $alternateVerbLangRuRU, '
        'alternateVerbLangJaJP: $alternateVerbLangJaJP, '
        'alternateVerbLangPtPT: $alternateVerbLangPtPT, '
        'alternateVerbLangPtBR: $alternateVerbLangPtBR, '
        'alternateVerbLangItIT: $alternateVerbLangItIT, '
        'alternateVerbLangUnk1: $alternateVerbLangUnk1, '
        'alternateVerbLangUnk2: $alternateVerbLangUnk2, '
        'alternateVerbLangUnk3: $alternateVerbLangUnk3, '
        'alternateVerbLangFlags: $alternateVerbLangFlags, '
        'canLink: $canLink'
        ')';
  }
}
