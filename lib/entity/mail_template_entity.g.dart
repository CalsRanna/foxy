// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_template_entity.dart';

mixin _MailTemplateEntityMixin {
  int get id;
  String get subjectLangEnUS;
  String get subjectLangKoKR;
  String get subjectLangFrFR;
  String get subjectLangDeDE;
  String get subjectLangZhCN;
  String get subjectLangZhTW;
  String get subjectLangEsES;
  String get subjectLangEsMX;
  String get subjectLangRuRU;
  String get subjectLangJaJP;
  String get subjectLangPtPT;
  String get subjectLangPtBR;
  String get subjectLangItIT;
  String get subjectLangUnk1;
  String get subjectLangUnk2;
  String get subjectLangUnk3;
  int get subjectLangFlags;
  String get bodyLangEnUS;
  String get bodyLangKoKR;
  String get bodyLangFrFR;
  String get bodyLangDeDE;
  String get bodyLangZhCN;
  String get bodyLangZhTW;
  String get bodyLangEsES;
  String get bodyLangEsMX;
  String get bodyLangRuRU;
  String get bodyLangJaJP;
  String get bodyLangPtPT;
  String get bodyLangPtBR;
  String get bodyLangItIT;
  String get bodyLangUnk1;
  String get bodyLangUnk2;
  String get bodyLangUnk3;
  int get bodyLangFlags;

  static MailTemplateEntity fromJson(Map<String, dynamic> json) {
    return MailTemplateEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      subjectLangEnUS: json['Subject_lang_enUS']?.toString() ?? '',
      subjectLangKoKR: json['Subject_lang_koKR']?.toString() ?? '',
      subjectLangFrFR: json['Subject_lang_frFR']?.toString() ?? '',
      subjectLangDeDE: json['Subject_lang_deDE']?.toString() ?? '',
      subjectLangZhCN: json['Subject_lang_zhCN']?.toString() ?? '',
      subjectLangZhTW: json['Subject_lang_zhTW']?.toString() ?? '',
      subjectLangEsES: json['Subject_lang_esES']?.toString() ?? '',
      subjectLangEsMX: json['Subject_lang_esMX']?.toString() ?? '',
      subjectLangRuRU: json['Subject_lang_ruRU']?.toString() ?? '',
      subjectLangJaJP: json['Subject_lang_jaJP']?.toString() ?? '',
      subjectLangPtPT: json['Subject_lang_ptPT']?.toString() ?? '',
      subjectLangPtBR: json['Subject_lang_ptBR']?.toString() ?? '',
      subjectLangItIT: json['Subject_lang_itIT']?.toString() ?? '',
      subjectLangUnk1: json['Subject_lang_unk1']?.toString() ?? '',
      subjectLangUnk2: json['Subject_lang_unk2']?.toString() ?? '',
      subjectLangUnk3: json['Subject_lang_unk3']?.toString() ?? '',
      subjectLangFlags: (json['Subject_lang_Flags'] as num?)?.toInt() ?? 0,
      bodyLangEnUS: json['Body_lang_enUS']?.toString() ?? '',
      bodyLangKoKR: json['Body_lang_koKR']?.toString() ?? '',
      bodyLangFrFR: json['Body_lang_frFR']?.toString() ?? '',
      bodyLangDeDE: json['Body_lang_deDE']?.toString() ?? '',
      bodyLangZhCN: json['Body_lang_zhCN']?.toString() ?? '',
      bodyLangZhTW: json['Body_lang_zhTW']?.toString() ?? '',
      bodyLangEsES: json['Body_lang_esES']?.toString() ?? '',
      bodyLangEsMX: json['Body_lang_esMX']?.toString() ?? '',
      bodyLangRuRU: json['Body_lang_ruRU']?.toString() ?? '',
      bodyLangJaJP: json['Body_lang_jaJP']?.toString() ?? '',
      bodyLangPtPT: json['Body_lang_ptPT']?.toString() ?? '',
      bodyLangPtBR: json['Body_lang_ptBR']?.toString() ?? '',
      bodyLangItIT: json['Body_lang_itIT']?.toString() ?? '',
      bodyLangUnk1: json['Body_lang_unk1']?.toString() ?? '',
      bodyLangUnk2: json['Body_lang_unk2']?.toString() ?? '',
      bodyLangUnk3: json['Body_lang_unk3']?.toString() ?? '',
      bodyLangFlags: (json['Body_lang_Flags'] as num?)?.toInt() ?? 0,
    );
  }

  MailTemplateEntity copyWith({
    int? id,
    String? subjectLangEnUS,
    String? subjectLangKoKR,
    String? subjectLangFrFR,
    String? subjectLangDeDE,
    String? subjectLangZhCN,
    String? subjectLangZhTW,
    String? subjectLangEsES,
    String? subjectLangEsMX,
    String? subjectLangRuRU,
    String? subjectLangJaJP,
    String? subjectLangPtPT,
    String? subjectLangPtBR,
    String? subjectLangItIT,
    String? subjectLangUnk1,
    String? subjectLangUnk2,
    String? subjectLangUnk3,
    int? subjectLangFlags,
    String? bodyLangEnUS,
    String? bodyLangKoKR,
    String? bodyLangFrFR,
    String? bodyLangDeDE,
    String? bodyLangZhCN,
    String? bodyLangZhTW,
    String? bodyLangEsES,
    String? bodyLangEsMX,
    String? bodyLangRuRU,
    String? bodyLangJaJP,
    String? bodyLangPtPT,
    String? bodyLangPtBR,
    String? bodyLangItIT,
    String? bodyLangUnk1,
    String? bodyLangUnk2,
    String? bodyLangUnk3,
    int? bodyLangFlags,
  }) {
    return MailTemplateEntity(
      id: id ?? this.id,
      subjectLangEnUS: subjectLangEnUS ?? this.subjectLangEnUS,
      subjectLangKoKR: subjectLangKoKR ?? this.subjectLangKoKR,
      subjectLangFrFR: subjectLangFrFR ?? this.subjectLangFrFR,
      subjectLangDeDE: subjectLangDeDE ?? this.subjectLangDeDE,
      subjectLangZhCN: subjectLangZhCN ?? this.subjectLangZhCN,
      subjectLangZhTW: subjectLangZhTW ?? this.subjectLangZhTW,
      subjectLangEsES: subjectLangEsES ?? this.subjectLangEsES,
      subjectLangEsMX: subjectLangEsMX ?? this.subjectLangEsMX,
      subjectLangRuRU: subjectLangRuRU ?? this.subjectLangRuRU,
      subjectLangJaJP: subjectLangJaJP ?? this.subjectLangJaJP,
      subjectLangPtPT: subjectLangPtPT ?? this.subjectLangPtPT,
      subjectLangPtBR: subjectLangPtBR ?? this.subjectLangPtBR,
      subjectLangItIT: subjectLangItIT ?? this.subjectLangItIT,
      subjectLangUnk1: subjectLangUnk1 ?? this.subjectLangUnk1,
      subjectLangUnk2: subjectLangUnk2 ?? this.subjectLangUnk2,
      subjectLangUnk3: subjectLangUnk3 ?? this.subjectLangUnk3,
      subjectLangFlags: subjectLangFlags ?? this.subjectLangFlags,
      bodyLangEnUS: bodyLangEnUS ?? this.bodyLangEnUS,
      bodyLangKoKR: bodyLangKoKR ?? this.bodyLangKoKR,
      bodyLangFrFR: bodyLangFrFR ?? this.bodyLangFrFR,
      bodyLangDeDE: bodyLangDeDE ?? this.bodyLangDeDE,
      bodyLangZhCN: bodyLangZhCN ?? this.bodyLangZhCN,
      bodyLangZhTW: bodyLangZhTW ?? this.bodyLangZhTW,
      bodyLangEsES: bodyLangEsES ?? this.bodyLangEsES,
      bodyLangEsMX: bodyLangEsMX ?? this.bodyLangEsMX,
      bodyLangRuRU: bodyLangRuRU ?? this.bodyLangRuRU,
      bodyLangJaJP: bodyLangJaJP ?? this.bodyLangJaJP,
      bodyLangPtPT: bodyLangPtPT ?? this.bodyLangPtPT,
      bodyLangPtBR: bodyLangPtBR ?? this.bodyLangPtBR,
      bodyLangItIT: bodyLangItIT ?? this.bodyLangItIT,
      bodyLangUnk1: bodyLangUnk1 ?? this.bodyLangUnk1,
      bodyLangUnk2: bodyLangUnk2 ?? this.bodyLangUnk2,
      bodyLangUnk3: bodyLangUnk3 ?? this.bodyLangUnk3,
      bodyLangFlags: bodyLangFlags ?? this.bodyLangFlags,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MailTemplateEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            subjectLangEnUS == other.subjectLangEnUS &&
            subjectLangKoKR == other.subjectLangKoKR &&
            subjectLangFrFR == other.subjectLangFrFR &&
            subjectLangDeDE == other.subjectLangDeDE &&
            subjectLangZhCN == other.subjectLangZhCN &&
            subjectLangZhTW == other.subjectLangZhTW &&
            subjectLangEsES == other.subjectLangEsES &&
            subjectLangEsMX == other.subjectLangEsMX &&
            subjectLangRuRU == other.subjectLangRuRU &&
            subjectLangJaJP == other.subjectLangJaJP &&
            subjectLangPtPT == other.subjectLangPtPT &&
            subjectLangPtBR == other.subjectLangPtBR &&
            subjectLangItIT == other.subjectLangItIT &&
            subjectLangUnk1 == other.subjectLangUnk1 &&
            subjectLangUnk2 == other.subjectLangUnk2 &&
            subjectLangUnk3 == other.subjectLangUnk3 &&
            subjectLangFlags == other.subjectLangFlags &&
            bodyLangEnUS == other.bodyLangEnUS &&
            bodyLangKoKR == other.bodyLangKoKR &&
            bodyLangFrFR == other.bodyLangFrFR &&
            bodyLangDeDE == other.bodyLangDeDE &&
            bodyLangZhCN == other.bodyLangZhCN &&
            bodyLangZhTW == other.bodyLangZhTW &&
            bodyLangEsES == other.bodyLangEsES &&
            bodyLangEsMX == other.bodyLangEsMX &&
            bodyLangRuRU == other.bodyLangRuRU &&
            bodyLangJaJP == other.bodyLangJaJP &&
            bodyLangPtPT == other.bodyLangPtPT &&
            bodyLangPtBR == other.bodyLangPtBR &&
            bodyLangItIT == other.bodyLangItIT &&
            bodyLangUnk1 == other.bodyLangUnk1 &&
            bodyLangUnk2 == other.bodyLangUnk2 &&
            bodyLangUnk3 == other.bodyLangUnk3 &&
            bodyLangFlags == other.bodyLangFlags;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      subjectLangEnUS,
      subjectLangKoKR,
      subjectLangFrFR,
      subjectLangDeDE,
      subjectLangZhCN,
      subjectLangZhTW,
      subjectLangEsES,
      subjectLangEsMX,
      subjectLangRuRU,
      subjectLangJaJP,
      subjectLangPtPT,
      subjectLangPtBR,
      subjectLangItIT,
      subjectLangUnk1,
      subjectLangUnk2,
      subjectLangUnk3,
      subjectLangFlags,
      bodyLangEnUS,
      bodyLangKoKR,
      bodyLangFrFR,
      bodyLangDeDE,
      bodyLangZhCN,
      bodyLangZhTW,
      bodyLangEsES,
      bodyLangEsMX,
      bodyLangRuRU,
      bodyLangJaJP,
      bodyLangPtPT,
      bodyLangPtBR,
      bodyLangItIT,
      bodyLangUnk1,
      bodyLangUnk2,
      bodyLangUnk3,
      bodyLangFlags,
    ]);
  }

  @override
  String toString() {
    return 'MailTemplateEntity('
        'id: $id, '
        'subjectLangEnUS: $subjectLangEnUS, '
        'subjectLangKoKR: $subjectLangKoKR, '
        'subjectLangFrFR: $subjectLangFrFR, '
        'subjectLangDeDE: $subjectLangDeDE, '
        'subjectLangZhCN: $subjectLangZhCN, '
        'subjectLangZhTW: $subjectLangZhTW, '
        'subjectLangEsES: $subjectLangEsES, '
        'subjectLangEsMX: $subjectLangEsMX, '
        'subjectLangRuRU: $subjectLangRuRU, '
        'subjectLangJaJP: $subjectLangJaJP, '
        'subjectLangPtPT: $subjectLangPtPT, '
        'subjectLangPtBR: $subjectLangPtBR, '
        'subjectLangItIT: $subjectLangItIT, '
        'subjectLangUnk1: $subjectLangUnk1, '
        'subjectLangUnk2: $subjectLangUnk2, '
        'subjectLangUnk3: $subjectLangUnk3, '
        'subjectLangFlags: $subjectLangFlags, '
        'bodyLangEnUS: $bodyLangEnUS, '
        'bodyLangKoKR: $bodyLangKoKR, '
        'bodyLangFrFR: $bodyLangFrFR, '
        'bodyLangDeDE: $bodyLangDeDE, '
        'bodyLangZhCN: $bodyLangZhCN, '
        'bodyLangZhTW: $bodyLangZhTW, '
        'bodyLangEsES: $bodyLangEsES, '
        'bodyLangEsMX: $bodyLangEsMX, '
        'bodyLangRuRU: $bodyLangRuRU, '
        'bodyLangJaJP: $bodyLangJaJP, '
        'bodyLangPtPT: $bodyLangPtPT, '
        'bodyLangPtBR: $bodyLangPtBR, '
        'bodyLangItIT: $bodyLangItIT, '
        'bodyLangUnk1: $bodyLangUnk1, '
        'bodyLangUnk2: $bodyLangUnk2, '
        'bodyLangUnk3: $bodyLangUnk3, '
        'bodyLangFlags: $bodyLangFlags'
        ')';
  }
}
