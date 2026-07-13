class SpellFocusObjectEntity {
  final int id;
  final String nameLangEnUS;
  final String nameLangKoKR;
  final String nameLangFrFR;
  final String nameLangDeDE;
  final String nameLangZhCN;
  final String nameLangZhTW;
  final String nameLangEsES;
  final String nameLangEsMX;
  final String nameLangRuRU;
  final String nameLangJaJP;
  final String nameLangPtPT;
  final String nameLangPtBR;
  final String nameLangItIT;
  final String nameLangUnk1;
  final String nameLangUnk2;
  final String nameLangUnk3;
  final int nameLangFlags;

  const SpellFocusObjectEntity({
    this.id = 0,
    this.nameLangEnUS = '',
    this.nameLangKoKR = '',
    this.nameLangFrFR = '',
    this.nameLangDeDE = '',
    this.nameLangZhCN = '',
    this.nameLangZhTW = '',
    this.nameLangEsES = '',
    this.nameLangEsMX = '',
    this.nameLangRuRU = '',
    this.nameLangJaJP = '',
    this.nameLangPtPT = '',
    this.nameLangPtBR = '',
    this.nameLangItIT = '',
    this.nameLangUnk1 = '',
    this.nameLangUnk2 = '',
    this.nameLangUnk3 = '',
    this.nameLangFlags = 0,
  });

  factory SpellFocusObjectEntity.fromJson(Map<String, dynamic> json) {
    return SpellFocusObjectEntity(
      id: json['ID'] ?? 0,
      nameLangEnUS: json['Name_lang_enUS'] ?? '',
      nameLangKoKR: json['Name_lang_koKR'] ?? '',
      nameLangFrFR: json['Name_lang_frFR'] ?? '',
      nameLangDeDE: json['Name_lang_deDE'] ?? '',
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      nameLangZhTW: json['Name_lang_zhTW'] ?? '',
      nameLangEsES: json['Name_lang_esES'] ?? '',
      nameLangEsMX: json['Name_lang_esMX'] ?? '',
      nameLangRuRU: json['Name_lang_ruRU'] ?? '',
      nameLangJaJP: json['Name_lang_jaJP'] ?? '',
      nameLangPtPT: json['Name_lang_ptPT'] ?? '',
      nameLangPtBR: json['Name_lang_ptBR'] ?? '',
      nameLangItIT: json['Name_lang_itIT'] ?? '',
      nameLangUnk1: json['Name_lang_unk1'] ?? '',
      nameLangUnk2: json['Name_lang_unk2'] ?? '',
      nameLangUnk3: json['Name_lang_unk3'] ?? '',
      nameLangFlags: json['Name_lang_Flags'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
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
  };
}

class BriefSpellFocusObjectEntity {
  final int id;
  final String nameLangZhCN;
  final String nameLangEnUS;

  const BriefSpellFocusObjectEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.nameLangEnUS = '',
  });

  String get displayName =>
      nameLangZhCN.isNotEmpty ? nameLangZhCN : nameLangEnUS;

  factory BriefSpellFocusObjectEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellFocusObjectEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      nameLangEnUS: json['Name_lang_enUS'] ?? '',
    );
  }
}
