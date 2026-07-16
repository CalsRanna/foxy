class BriefMailTemplateEntity {
  final int id;
  final String subjectLangZhCN;
  final String bodyLangZhCN;

  const BriefMailTemplateEntity({
    this.id = 0,
    this.subjectLangZhCN = '',
    this.bodyLangZhCN = '',
  });

  factory BriefMailTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefMailTemplateEntity(
      id: json['ID'] ?? 0,
      subjectLangZhCN: json['Subject_lang_zhCN'] ?? '',
      bodyLangZhCN: json['Body_lang_zhCN'] ?? '',
    );
  }
}

class MailTemplateEntity {
  final int id;
  final String subjectLangEnUS;
  final String subjectLangKoKR;
  final String subjectLangFrFR;
  final String subjectLangDeDE;
  final String subjectLangZhCN;
  final String subjectLangZhTW;
  final String subjectLangEsES;
  final String subjectLangEsMX;
  final String subjectLangRuRU;
  final String subjectLangJaJP;
  final String subjectLangPtPT;
  final String subjectLangPtBR;
  final String subjectLangItIT;
  final String subjectLangUnk1;
  final String subjectLangUnk2;
  final String subjectLangUnk3;
  final int subjectLangFlags;
  final String bodyLangEnUS;
  final String bodyLangKoKR;
  final String bodyLangFrFR;
  final String bodyLangDeDE;
  final String bodyLangZhCN;
  final String bodyLangZhTW;
  final String bodyLangEsES;
  final String bodyLangEsMX;
  final String bodyLangRuRU;
  final String bodyLangJaJP;
  final String bodyLangPtPT;
  final String bodyLangPtBR;
  final String bodyLangItIT;
  final String bodyLangUnk1;
  final String bodyLangUnk2;
  final String bodyLangUnk3;
  final int bodyLangFlags;

  const MailTemplateEntity({
    this.id = 0,
    this.subjectLangEnUS = '',
    this.subjectLangKoKR = '',
    this.subjectLangFrFR = '',
    this.subjectLangDeDE = '',
    this.subjectLangZhCN = '',
    this.subjectLangZhTW = '',
    this.subjectLangEsES = '',
    this.subjectLangEsMX = '',
    this.subjectLangRuRU = '',
    this.subjectLangJaJP = '',
    this.subjectLangPtPT = '',
    this.subjectLangPtBR = '',
    this.subjectLangItIT = '',
    this.subjectLangUnk1 = '',
    this.subjectLangUnk2 = '',
    this.subjectLangUnk3 = '',
    this.subjectLangFlags = 0,
    this.bodyLangEnUS = '',
    this.bodyLangKoKR = '',
    this.bodyLangFrFR = '',
    this.bodyLangDeDE = '',
    this.bodyLangZhCN = '',
    this.bodyLangZhTW = '',
    this.bodyLangEsES = '',
    this.bodyLangEsMX = '',
    this.bodyLangRuRU = '',
    this.bodyLangJaJP = '',
    this.bodyLangPtPT = '',
    this.bodyLangPtBR = '',
    this.bodyLangItIT = '',
    this.bodyLangUnk1 = '',
    this.bodyLangUnk2 = '',
    this.bodyLangUnk3 = '',
    this.bodyLangFlags = 0,
  });

  factory MailTemplateEntity.fromJson(Map<String, dynamic> json) {
    return MailTemplateEntity(
      id: json['ID'] ?? 0,
      subjectLangEnUS: json['Subject_lang_enUS'] ?? '',
      subjectLangKoKR: json['Subject_lang_koKR'] ?? '',
      subjectLangFrFR: json['Subject_lang_frFR'] ?? '',
      subjectLangDeDE: json['Subject_lang_deDE'] ?? '',
      subjectLangZhCN: json['Subject_lang_zhCN'] ?? '',
      subjectLangZhTW: json['Subject_lang_zhTW'] ?? '',
      subjectLangEsES: json['Subject_lang_esES'] ?? '',
      subjectLangEsMX: json['Subject_lang_esMX'] ?? '',
      subjectLangRuRU: json['Subject_lang_ruRU'] ?? '',
      subjectLangJaJP: json['Subject_lang_jaJP'] ?? '',
      subjectLangPtPT: json['Subject_lang_ptPT'] ?? '',
      subjectLangPtBR: json['Subject_lang_ptBR'] ?? '',
      subjectLangItIT: json['Subject_lang_itIT'] ?? '',
      subjectLangUnk1: json['Subject_lang_unk1'] ?? '',
      subjectLangUnk2: json['Subject_lang_unk2'] ?? '',
      subjectLangUnk3: json['Subject_lang_unk3'] ?? '',
      subjectLangFlags: json['Subject_lang_Flags'] ?? 0,
      bodyLangEnUS: json['Body_lang_enUS'] ?? '',
      bodyLangKoKR: json['Body_lang_koKR'] ?? '',
      bodyLangFrFR: json['Body_lang_frFR'] ?? '',
      bodyLangDeDE: json['Body_lang_deDE'] ?? '',
      bodyLangZhCN: json['Body_lang_zhCN'] ?? '',
      bodyLangZhTW: json['Body_lang_zhTW'] ?? '',
      bodyLangEsES: json['Body_lang_esES'] ?? '',
      bodyLangEsMX: json['Body_lang_esMX'] ?? '',
      bodyLangRuRU: json['Body_lang_ruRU'] ?? '',
      bodyLangJaJP: json['Body_lang_jaJP'] ?? '',
      bodyLangPtPT: json['Body_lang_ptPT'] ?? '',
      bodyLangPtBR: json['Body_lang_ptBR'] ?? '',
      bodyLangItIT: json['Body_lang_itIT'] ?? '',
      bodyLangUnk1: json['Body_lang_unk1'] ?? '',
      bodyLangUnk2: json['Body_lang_unk2'] ?? '',
      bodyLangUnk3: json['Body_lang_unk3'] ?? '',
      bodyLangFlags: json['Body_lang_Flags'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Subject_lang_enUS': subjectLangEnUS,
      'Subject_lang_koKR': subjectLangKoKR,
      'Subject_lang_frFR': subjectLangFrFR,
      'Subject_lang_deDE': subjectLangDeDE,
      'Subject_lang_zhCN': subjectLangZhCN,
      'Subject_lang_zhTW': subjectLangZhTW,
      'Subject_lang_esES': subjectLangEsES,
      'Subject_lang_esMX': subjectLangEsMX,
      'Subject_lang_ruRU': subjectLangRuRU,
      'Subject_lang_jaJP': subjectLangJaJP,
      'Subject_lang_ptPT': subjectLangPtPT,
      'Subject_lang_ptBR': subjectLangPtBR,
      'Subject_lang_itIT': subjectLangItIT,
      'Subject_lang_unk1': subjectLangUnk1,
      'Subject_lang_unk2': subjectLangUnk2,
      'Subject_lang_unk3': subjectLangUnk3,
      'Subject_lang_Flags': subjectLangFlags,
      'Body_lang_enUS': bodyLangEnUS,
      'Body_lang_koKR': bodyLangKoKR,
      'Body_lang_frFR': bodyLangFrFR,
      'Body_lang_deDE': bodyLangDeDE,
      'Body_lang_zhCN': bodyLangZhCN,
      'Body_lang_zhTW': bodyLangZhTW,
      'Body_lang_esES': bodyLangEsES,
      'Body_lang_esMX': bodyLangEsMX,
      'Body_lang_ruRU': bodyLangRuRU,
      'Body_lang_jaJP': bodyLangJaJP,
      'Body_lang_ptPT': bodyLangPtPT,
      'Body_lang_ptBR': bodyLangPtBR,
      'Body_lang_itIT': bodyLangItIT,
      'Body_lang_unk1': bodyLangUnk1,
      'Body_lang_unk2': bodyLangUnk2,
      'Body_lang_unk3': bodyLangUnk3,
      'Body_lang_Flags': bodyLangFlags,
    };
  }
}
