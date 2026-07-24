// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_template_entity.dart';

mixin _MailTemplateEntityMixin {
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
    final self = this as MailTemplateEntity;
    return MailTemplateEntity(
      id: id ?? self.id,
      subjectLangEnUS: subjectLangEnUS ?? self.subjectLangEnUS,
      subjectLangKoKR: subjectLangKoKR ?? self.subjectLangKoKR,
      subjectLangFrFR: subjectLangFrFR ?? self.subjectLangFrFR,
      subjectLangDeDE: subjectLangDeDE ?? self.subjectLangDeDE,
      subjectLangZhCN: subjectLangZhCN ?? self.subjectLangZhCN,
      subjectLangZhTW: subjectLangZhTW ?? self.subjectLangZhTW,
      subjectLangEsES: subjectLangEsES ?? self.subjectLangEsES,
      subjectLangEsMX: subjectLangEsMX ?? self.subjectLangEsMX,
      subjectLangRuRU: subjectLangRuRU ?? self.subjectLangRuRU,
      subjectLangJaJP: subjectLangJaJP ?? self.subjectLangJaJP,
      subjectLangPtPT: subjectLangPtPT ?? self.subjectLangPtPT,
      subjectLangPtBR: subjectLangPtBR ?? self.subjectLangPtBR,
      subjectLangItIT: subjectLangItIT ?? self.subjectLangItIT,
      subjectLangUnk1: subjectLangUnk1 ?? self.subjectLangUnk1,
      subjectLangUnk2: subjectLangUnk2 ?? self.subjectLangUnk2,
      subjectLangUnk3: subjectLangUnk3 ?? self.subjectLangUnk3,
      subjectLangFlags: subjectLangFlags ?? self.subjectLangFlags,
      bodyLangEnUS: bodyLangEnUS ?? self.bodyLangEnUS,
      bodyLangKoKR: bodyLangKoKR ?? self.bodyLangKoKR,
      bodyLangFrFR: bodyLangFrFR ?? self.bodyLangFrFR,
      bodyLangDeDE: bodyLangDeDE ?? self.bodyLangDeDE,
      bodyLangZhCN: bodyLangZhCN ?? self.bodyLangZhCN,
      bodyLangZhTW: bodyLangZhTW ?? self.bodyLangZhTW,
      bodyLangEsES: bodyLangEsES ?? self.bodyLangEsES,
      bodyLangEsMX: bodyLangEsMX ?? self.bodyLangEsMX,
      bodyLangRuRU: bodyLangRuRU ?? self.bodyLangRuRU,
      bodyLangJaJP: bodyLangJaJP ?? self.bodyLangJaJP,
      bodyLangPtPT: bodyLangPtPT ?? self.bodyLangPtPT,
      bodyLangPtBR: bodyLangPtBR ?? self.bodyLangPtBR,
      bodyLangItIT: bodyLangItIT ?? self.bodyLangItIT,
      bodyLangUnk1: bodyLangUnk1 ?? self.bodyLangUnk1,
      bodyLangUnk2: bodyLangUnk2 ?? self.bodyLangUnk2,
      bodyLangUnk3: bodyLangUnk3 ?? self.bodyLangUnk3,
      bodyLangFlags: bodyLangFlags ?? self.bodyLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as MailTemplateEntity;
    return {
      'ID': self.id,
      'Subject_lang_enUS': self.subjectLangEnUS,
      'Subject_lang_koKR': self.subjectLangKoKR,
      'Subject_lang_frFR': self.subjectLangFrFR,
      'Subject_lang_deDE': self.subjectLangDeDE,
      'Subject_lang_zhCN': self.subjectLangZhCN,
      'Subject_lang_zhTW': self.subjectLangZhTW,
      'Subject_lang_esES': self.subjectLangEsES,
      'Subject_lang_esMX': self.subjectLangEsMX,
      'Subject_lang_ruRU': self.subjectLangRuRU,
      'Subject_lang_jaJP': self.subjectLangJaJP,
      'Subject_lang_ptPT': self.subjectLangPtPT,
      'Subject_lang_ptBR': self.subjectLangPtBR,
      'Subject_lang_itIT': self.subjectLangItIT,
      'Subject_lang_unk1': self.subjectLangUnk1,
      'Subject_lang_unk2': self.subjectLangUnk2,
      'Subject_lang_unk3': self.subjectLangUnk3,
      'Subject_lang_Flags': self.subjectLangFlags,
      'Body_lang_enUS': self.bodyLangEnUS,
      'Body_lang_koKR': self.bodyLangKoKR,
      'Body_lang_frFR': self.bodyLangFrFR,
      'Body_lang_deDE': self.bodyLangDeDE,
      'Body_lang_zhCN': self.bodyLangZhCN,
      'Body_lang_zhTW': self.bodyLangZhTW,
      'Body_lang_esES': self.bodyLangEsES,
      'Body_lang_esMX': self.bodyLangEsMX,
      'Body_lang_ruRU': self.bodyLangRuRU,
      'Body_lang_jaJP': self.bodyLangJaJP,
      'Body_lang_ptPT': self.bodyLangPtPT,
      'Body_lang_ptBR': self.bodyLangPtBR,
      'Body_lang_itIT': self.bodyLangItIT,
      'Body_lang_unk1': self.bodyLangUnk1,
      'Body_lang_unk2': self.bodyLangUnk2,
      'Body_lang_unk3': self.bodyLangUnk3,
      'Body_lang_Flags': self.bodyLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as MailTemplateEntity;
    return identical(self, other) ||
        other is MailTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.subjectLangEnUS == other.subjectLangEnUS &&
            self.subjectLangKoKR == other.subjectLangKoKR &&
            self.subjectLangFrFR == other.subjectLangFrFR &&
            self.subjectLangDeDE == other.subjectLangDeDE &&
            self.subjectLangZhCN == other.subjectLangZhCN &&
            self.subjectLangZhTW == other.subjectLangZhTW &&
            self.subjectLangEsES == other.subjectLangEsES &&
            self.subjectLangEsMX == other.subjectLangEsMX &&
            self.subjectLangRuRU == other.subjectLangRuRU &&
            self.subjectLangJaJP == other.subjectLangJaJP &&
            self.subjectLangPtPT == other.subjectLangPtPT &&
            self.subjectLangPtBR == other.subjectLangPtBR &&
            self.subjectLangItIT == other.subjectLangItIT &&
            self.subjectLangUnk1 == other.subjectLangUnk1 &&
            self.subjectLangUnk2 == other.subjectLangUnk2 &&
            self.subjectLangUnk3 == other.subjectLangUnk3 &&
            self.subjectLangFlags == other.subjectLangFlags &&
            self.bodyLangEnUS == other.bodyLangEnUS &&
            self.bodyLangKoKR == other.bodyLangKoKR &&
            self.bodyLangFrFR == other.bodyLangFrFR &&
            self.bodyLangDeDE == other.bodyLangDeDE &&
            self.bodyLangZhCN == other.bodyLangZhCN &&
            self.bodyLangZhTW == other.bodyLangZhTW &&
            self.bodyLangEsES == other.bodyLangEsES &&
            self.bodyLangEsMX == other.bodyLangEsMX &&
            self.bodyLangRuRU == other.bodyLangRuRU &&
            self.bodyLangJaJP == other.bodyLangJaJP &&
            self.bodyLangPtPT == other.bodyLangPtPT &&
            self.bodyLangPtBR == other.bodyLangPtBR &&
            self.bodyLangItIT == other.bodyLangItIT &&
            self.bodyLangUnk1 == other.bodyLangUnk1 &&
            self.bodyLangUnk2 == other.bodyLangUnk2 &&
            self.bodyLangUnk3 == other.bodyLangUnk3 &&
            self.bodyLangFlags == other.bodyLangFlags;
  }

  @override
  int get hashCode {
    final self = this as MailTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.subjectLangEnUS,
      self.subjectLangKoKR,
      self.subjectLangFrFR,
      self.subjectLangDeDE,
      self.subjectLangZhCN,
      self.subjectLangZhTW,
      self.subjectLangEsES,
      self.subjectLangEsMX,
      self.subjectLangRuRU,
      self.subjectLangJaJP,
      self.subjectLangPtPT,
      self.subjectLangPtBR,
      self.subjectLangItIT,
      self.subjectLangUnk1,
      self.subjectLangUnk2,
      self.subjectLangUnk3,
      self.subjectLangFlags,
      self.bodyLangEnUS,
      self.bodyLangKoKR,
      self.bodyLangFrFR,
      self.bodyLangDeDE,
      self.bodyLangZhCN,
      self.bodyLangZhTW,
      self.bodyLangEsES,
      self.bodyLangEsMX,
      self.bodyLangRuRU,
      self.bodyLangJaJP,
      self.bodyLangPtPT,
      self.bodyLangPtBR,
      self.bodyLangItIT,
      self.bodyLangUnk1,
      self.bodyLangUnk2,
      self.bodyLangUnk3,
      self.bodyLangFlags,
    ]);
  }

  @override
  String toString() {
    final self = this as MailTemplateEntity;
    return 'MailTemplateEntity('
        'id: ${self.id}, '
        'subjectLangEnUS: ${self.subjectLangEnUS}, '
        'subjectLangKoKR: ${self.subjectLangKoKR}, '
        'subjectLangFrFR: ${self.subjectLangFrFR}, '
        'subjectLangDeDE: ${self.subjectLangDeDE}, '
        'subjectLangZhCN: ${self.subjectLangZhCN}, '
        'subjectLangZhTW: ${self.subjectLangZhTW}, '
        'subjectLangEsES: ${self.subjectLangEsES}, '
        'subjectLangEsMX: ${self.subjectLangEsMX}, '
        'subjectLangRuRU: ${self.subjectLangRuRU}, '
        'subjectLangJaJP: ${self.subjectLangJaJP}, '
        'subjectLangPtPT: ${self.subjectLangPtPT}, '
        'subjectLangPtBR: ${self.subjectLangPtBR}, '
        'subjectLangItIT: ${self.subjectLangItIT}, '
        'subjectLangUnk1: ${self.subjectLangUnk1}, '
        'subjectLangUnk2: ${self.subjectLangUnk2}, '
        'subjectLangUnk3: ${self.subjectLangUnk3}, '
        'subjectLangFlags: ${self.subjectLangFlags}, '
        'bodyLangEnUS: ${self.bodyLangEnUS}, '
        'bodyLangKoKR: ${self.bodyLangKoKR}, '
        'bodyLangFrFR: ${self.bodyLangFrFR}, '
        'bodyLangDeDE: ${self.bodyLangDeDE}, '
        'bodyLangZhCN: ${self.bodyLangZhCN}, '
        'bodyLangZhTW: ${self.bodyLangZhTW}, '
        'bodyLangEsES: ${self.bodyLangEsES}, '
        'bodyLangEsMX: ${self.bodyLangEsMX}, '
        'bodyLangRuRU: ${self.bodyLangRuRU}, '
        'bodyLangJaJP: ${self.bodyLangJaJP}, '
        'bodyLangPtPT: ${self.bodyLangPtPT}, '
        'bodyLangPtBR: ${self.bodyLangPtBR}, '
        'bodyLangItIT: ${self.bodyLangItIT}, '
        'bodyLangUnk1: ${self.bodyLangUnk1}, '
        'bodyLangUnk2: ${self.bodyLangUnk2}, '
        'bodyLangUnk3: ${self.bodyLangUnk3}, '
        'bodyLangFlags: ${self.bodyLangFlags}'
        ')';
  }
}
