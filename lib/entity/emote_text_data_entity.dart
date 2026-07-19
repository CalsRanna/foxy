class EmoteTextDataEntity {
  final int id;
  final String textLangEnUS;
  final String textLangKoKR;
  final String textLangFrFR;
  final String textLangDeDE;
  final String textLangZhCN;
  final String textLangZhTW;
  final String textLangEsES;
  final String textLangEsMX;
  final String textLangRuRU;
  final String textLangJaJP;
  final String textLangPtPT;
  final String textLangPtBR;
  final String textLangItIT;
  final String textLangUnk1;
  final String textLangUnk2;
  final String textLangUnk3;
  final int textLangFlags;

  const EmoteTextDataEntity({
    this.id = 0,
    this.textLangEnUS = '',
    this.textLangKoKR = '',
    this.textLangFrFR = '',
    this.textLangDeDE = '',
    this.textLangZhCN = '',
    this.textLangZhTW = '',
    this.textLangEsES = '',
    this.textLangEsMX = '',
    this.textLangRuRU = '',
    this.textLangJaJP = '',
    this.textLangPtPT = '',
    this.textLangPtBR = '',
    this.textLangItIT = '',
    this.textLangUnk1 = '',
    this.textLangUnk2 = '',
    this.textLangUnk3 = '',
    this.textLangFlags = 0,
  });

  factory EmoteTextDataEntity.fromJson(Map<String, dynamic> json) {
    return EmoteTextDataEntity(
      id: json['ID'] ?? 0,
      textLangEnUS: json['Text_lang_enUS'] ?? '',
      textLangKoKR: json['Text_lang_koKR'] ?? '',
      textLangFrFR: json['Text_lang_frFR'] ?? '',
      textLangDeDE: json['Text_lang_deDE'] ?? '',
      textLangZhCN: json['Text_lang_zhCN'] ?? '',
      textLangZhTW: json['Text_lang_zhTW'] ?? '',
      textLangEsES: json['Text_lang_esES'] ?? '',
      textLangEsMX: json['Text_lang_esMX'] ?? '',
      textLangRuRU: json['Text_lang_ruRU'] ?? '',
      textLangJaJP: json['Text_lang_jaJP'] ?? '',
      textLangPtPT: json['Text_lang_ptPT'] ?? '',
      textLangPtBR: json['Text_lang_ptBR'] ?? '',
      textLangItIT: json['Text_lang_itIT'] ?? '',
      textLangUnk1: json['Text_lang_unk1'] ?? '',
      textLangUnk2: json['Text_lang_unk2'] ?? '',
      textLangUnk3: json['Text_lang_unk3'] ?? '',
      textLangFlags: json['Text_lang_Flags'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'Text_lang_enUS': textLangEnUS,
    'Text_lang_koKR': textLangKoKR,
    'Text_lang_frFR': textLangFrFR,
    'Text_lang_deDE': textLangDeDE,
    'Text_lang_zhCN': textLangZhCN,
    'Text_lang_zhTW': textLangZhTW,
    'Text_lang_esES': textLangEsES,
    'Text_lang_esMX': textLangEsMX,
    'Text_lang_ruRU': textLangRuRU,
    'Text_lang_jaJP': textLangJaJP,
    'Text_lang_ptPT': textLangPtPT,
    'Text_lang_ptBR': textLangPtBR,
    'Text_lang_itIT': textLangItIT,
    'Text_lang_unk1': textLangUnk1,
    'Text_lang_unk2': textLangUnk2,
    'Text_lang_unk3': textLangUnk3,
    'Text_lang_Flags': textLangFlags,
  };
}
