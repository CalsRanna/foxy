class SkillLineEntity {
  final int id;
  final int categoryId;
  final int skillCostsId;
  final String displayNameLangEnUS;
  final String displayNameLangKoKR;
  final String displayNameLangFrFR;
  final String displayNameLangDeDE;
  final String displayNameLangZhCN;
  final String displayNameLangZhTW;
  final String displayNameLangEsES;
  final String displayNameLangEsMX;
  final String displayNameLangRuRU;
  final String displayNameLangJaJP;
  final String displayNameLangPtPT;
  final String displayNameLangPtBR;
  final String displayNameLangItIT;
  final String displayNameLangUnk1;
  final String displayNameLangUnk2;
  final String displayNameLangUnk3;
  final int displayNameLangFlags;
  final String descriptionLangEnUS;
  final String descriptionLangKoKR;
  final String descriptionLangFrFR;
  final String descriptionLangDeDE;
  final String descriptionLangZhCN;
  final String descriptionLangZhTW;
  final String descriptionLangEsES;
  final String descriptionLangEsMX;
  final String descriptionLangRuRU;
  final String descriptionLangJaJP;
  final String descriptionLangPtPT;
  final String descriptionLangPtBR;
  final String descriptionLangItIT;
  final String descriptionLangUnk1;
  final String descriptionLangUnk2;
  final String descriptionLangUnk3;
  final int descriptionLangFlags;
  final int spellIconId;
  final String alternateVerbLangEnUS;
  final String alternateVerbLangKoKR;
  final String alternateVerbLangFrFR;
  final String alternateVerbLangDeDE;
  final String alternateVerbLangZhCN;
  final String alternateVerbLangZhTW;
  final String alternateVerbLangEsES;
  final String alternateVerbLangEsMX;
  final String alternateVerbLangRuRU;
  final String alternateVerbLangJaJP;
  final String alternateVerbLangPtPT;
  final String alternateVerbLangPtBR;
  final String alternateVerbLangItIT;
  final String alternateVerbLangUnk1;
  final String alternateVerbLangUnk2;
  final String alternateVerbLangUnk3;
  final int alternateVerbLangFlags;
  final int canLink;

  const SkillLineEntity({
    this.id = 0,
    this.categoryId = 0,
    this.skillCostsId = 0,
    this.displayNameLangEnUS = '',
    this.displayNameLangKoKR = '',
    this.displayNameLangFrFR = '',
    this.displayNameLangDeDE = '',
    this.displayNameLangZhCN = '',
    this.displayNameLangZhTW = '',
    this.displayNameLangEsES = '',
    this.displayNameLangEsMX = '',
    this.displayNameLangRuRU = '',
    this.displayNameLangJaJP = '',
    this.displayNameLangPtPT = '',
    this.displayNameLangPtBR = '',
    this.displayNameLangItIT = '',
    this.displayNameLangUnk1 = '',
    this.displayNameLangUnk2 = '',
    this.displayNameLangUnk3 = '',
    this.displayNameLangFlags = 0,
    this.descriptionLangEnUS = '',
    this.descriptionLangKoKR = '',
    this.descriptionLangFrFR = '',
    this.descriptionLangDeDE = '',
    this.descriptionLangZhCN = '',
    this.descriptionLangZhTW = '',
    this.descriptionLangEsES = '',
    this.descriptionLangEsMX = '',
    this.descriptionLangRuRU = '',
    this.descriptionLangJaJP = '',
    this.descriptionLangPtPT = '',
    this.descriptionLangPtBR = '',
    this.descriptionLangItIT = '',
    this.descriptionLangUnk1 = '',
    this.descriptionLangUnk2 = '',
    this.descriptionLangUnk3 = '',
    this.descriptionLangFlags = 0,
    this.spellIconId = 0,
    this.alternateVerbLangEnUS = '',
    this.alternateVerbLangKoKR = '',
    this.alternateVerbLangFrFR = '',
    this.alternateVerbLangDeDE = '',
    this.alternateVerbLangZhCN = '',
    this.alternateVerbLangZhTW = '',
    this.alternateVerbLangEsES = '',
    this.alternateVerbLangEsMX = '',
    this.alternateVerbLangRuRU = '',
    this.alternateVerbLangJaJP = '',
    this.alternateVerbLangPtPT = '',
    this.alternateVerbLangPtBR = '',
    this.alternateVerbLangItIT = '',
    this.alternateVerbLangUnk1 = '',
    this.alternateVerbLangUnk2 = '',
    this.alternateVerbLangUnk3 = '',
    this.alternateVerbLangFlags = 0,
    this.canLink = 0,
  });

  factory SkillLineEntity.fromJson(Map<String, dynamic> json) {
    return SkillLineEntity(
      id: json['ID'] ?? 0,
      categoryId: json['CategoryID'] ?? 0,
      skillCostsId: json['SkillCostsID'] ?? 0,
      displayNameLangEnUS: json['DisplayName_lang_enUS'] ?? '',
      displayNameLangKoKR: json['DisplayName_lang_koKR'] ?? '',
      displayNameLangFrFR: json['DisplayName_lang_frFR'] ?? '',
      displayNameLangDeDE: json['DisplayName_lang_deDE'] ?? '',
      displayNameLangZhCN: json['DisplayName_lang_zhCN'] ?? '',
      displayNameLangZhTW: json['DisplayName_lang_zhTW'] ?? '',
      displayNameLangEsES: json['DisplayName_lang_esES'] ?? '',
      displayNameLangEsMX: json['DisplayName_lang_esMX'] ?? '',
      displayNameLangRuRU: json['DisplayName_lang_ruRU'] ?? '',
      displayNameLangJaJP: json['DisplayName_lang_jaJP'] ?? '',
      displayNameLangPtPT: json['DisplayName_lang_ptPT'] ?? '',
      displayNameLangPtBR: json['DisplayName_lang_ptBR'] ?? '',
      displayNameLangItIT: json['DisplayName_lang_itIT'] ?? '',
      displayNameLangUnk1: json['DisplayName_lang_unk1'] ?? '',
      displayNameLangUnk2: json['DisplayName_lang_unk2'] ?? '',
      displayNameLangUnk3: json['DisplayName_lang_unk3'] ?? '',
      displayNameLangFlags: json['DisplayName_lang_Flags'] ?? 0,
      descriptionLangEnUS: json['Description_lang_enUS'] ?? '',
      descriptionLangKoKR: json['Description_lang_koKR'] ?? '',
      descriptionLangFrFR: json['Description_lang_frFR'] ?? '',
      descriptionLangDeDE: json['Description_lang_deDE'] ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
      descriptionLangZhTW: json['Description_lang_zhTW'] ?? '',
      descriptionLangEsES: json['Description_lang_esES'] ?? '',
      descriptionLangEsMX: json['Description_lang_esMX'] ?? '',
      descriptionLangRuRU: json['Description_lang_ruRU'] ?? '',
      descriptionLangJaJP: json['Description_lang_jaJP'] ?? '',
      descriptionLangPtPT: json['Description_lang_ptPT'] ?? '',
      descriptionLangPtBR: json['Description_lang_ptBR'] ?? '',
      descriptionLangItIT: json['Description_lang_itIT'] ?? '',
      descriptionLangUnk1: json['Description_lang_unk1'] ?? '',
      descriptionLangUnk2: json['Description_lang_unk2'] ?? '',
      descriptionLangUnk3: json['Description_lang_unk3'] ?? '',
      descriptionLangFlags: json['Description_lang_Flags'] ?? 0,
      spellIconId: json['SpellIconID'] ?? 0,
      alternateVerbLangEnUS: json['AlternateVerb_lang_enUS'] ?? '',
      alternateVerbLangKoKR: json['AlternateVerb_lang_koKR'] ?? '',
      alternateVerbLangFrFR: json['AlternateVerb_lang_frFR'] ?? '',
      alternateVerbLangDeDE: json['AlternateVerb_lang_deDE'] ?? '',
      alternateVerbLangZhCN: json['AlternateVerb_lang_zhCN'] ?? '',
      alternateVerbLangZhTW: json['AlternateVerb_lang_zhTW'] ?? '',
      alternateVerbLangEsES: json['AlternateVerb_lang_esES'] ?? '',
      alternateVerbLangEsMX: json['AlternateVerb_lang_esMX'] ?? '',
      alternateVerbLangRuRU: json['AlternateVerb_lang_ruRU'] ?? '',
      alternateVerbLangJaJP: json['AlternateVerb_lang_jaJP'] ?? '',
      alternateVerbLangPtPT: json['AlternateVerb_lang_ptPT'] ?? '',
      alternateVerbLangPtBR: json['AlternateVerb_lang_ptBR'] ?? '',
      alternateVerbLangItIT: json['AlternateVerb_lang_itIT'] ?? '',
      alternateVerbLangUnk1: json['AlternateVerb_lang_unk1'] ?? '',
      alternateVerbLangUnk2: json['AlternateVerb_lang_unk2'] ?? '',
      alternateVerbLangUnk3: json['AlternateVerb_lang_unk3'] ?? '',
      alternateVerbLangFlags: json['AlternateVerb_lang_Flags'] ?? 0,
      canLink: json['CanLink'] ?? 0,
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
}
