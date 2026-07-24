// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_data_entity.dart';

mixin _EmoteTextDataEntityMixin {
  static EmoteTextDataEntity fromJson(Map<String, dynamic> json) {
    return EmoteTextDataEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      textLangEnUS: json['Text_lang_enUS']?.toString() ?? '',
      textLangKoKR: json['Text_lang_koKR']?.toString() ?? '',
      textLangFrFR: json['Text_lang_frFR']?.toString() ?? '',
      textLangDeDE: json['Text_lang_deDE']?.toString() ?? '',
      textLangZhCN: json['Text_lang_zhCN']?.toString() ?? '',
      textLangZhTW: json['Text_lang_zhTW']?.toString() ?? '',
      textLangEsES: json['Text_lang_esES']?.toString() ?? '',
      textLangEsMX: json['Text_lang_esMX']?.toString() ?? '',
      textLangRuRU: json['Text_lang_ruRU']?.toString() ?? '',
      textLangJaJP: json['Text_lang_jaJP']?.toString() ?? '',
      textLangPtPT: json['Text_lang_ptPT']?.toString() ?? '',
      textLangPtBR: json['Text_lang_ptBR']?.toString() ?? '',
      textLangItIT: json['Text_lang_itIT']?.toString() ?? '',
      textLangUnk1: json['Text_lang_unk1']?.toString() ?? '',
      textLangUnk2: json['Text_lang_unk2']?.toString() ?? '',
      textLangUnk3: json['Text_lang_unk3']?.toString() ?? '',
      textLangFlags: (json['Text_lang_Flags'] as num?)?.toInt() ?? 0,
    );
  }

  EmoteTextDataEntity copyWith({
    int? id,
    String? textLangEnUS,
    String? textLangKoKR,
    String? textLangFrFR,
    String? textLangDeDE,
    String? textLangZhCN,
    String? textLangZhTW,
    String? textLangEsES,
    String? textLangEsMX,
    String? textLangRuRU,
    String? textLangJaJP,
    String? textLangPtPT,
    String? textLangPtBR,
    String? textLangItIT,
    String? textLangUnk1,
    String? textLangUnk2,
    String? textLangUnk3,
    int? textLangFlags,
  }) {
    final self = this as EmoteTextDataEntity;
    return EmoteTextDataEntity(
      id: id ?? self.id,
      textLangEnUS: textLangEnUS ?? self.textLangEnUS,
      textLangKoKR: textLangKoKR ?? self.textLangKoKR,
      textLangFrFR: textLangFrFR ?? self.textLangFrFR,
      textLangDeDE: textLangDeDE ?? self.textLangDeDE,
      textLangZhCN: textLangZhCN ?? self.textLangZhCN,
      textLangZhTW: textLangZhTW ?? self.textLangZhTW,
      textLangEsES: textLangEsES ?? self.textLangEsES,
      textLangEsMX: textLangEsMX ?? self.textLangEsMX,
      textLangRuRU: textLangRuRU ?? self.textLangRuRU,
      textLangJaJP: textLangJaJP ?? self.textLangJaJP,
      textLangPtPT: textLangPtPT ?? self.textLangPtPT,
      textLangPtBR: textLangPtBR ?? self.textLangPtBR,
      textLangItIT: textLangItIT ?? self.textLangItIT,
      textLangUnk1: textLangUnk1 ?? self.textLangUnk1,
      textLangUnk2: textLangUnk2 ?? self.textLangUnk2,
      textLangUnk3: textLangUnk3 ?? self.textLangUnk3,
      textLangFlags: textLangFlags ?? self.textLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as EmoteTextDataEntity;
    return {
      'ID': self.id,
      'Text_lang_enUS': self.textLangEnUS,
      'Text_lang_koKR': self.textLangKoKR,
      'Text_lang_frFR': self.textLangFrFR,
      'Text_lang_deDE': self.textLangDeDE,
      'Text_lang_zhCN': self.textLangZhCN,
      'Text_lang_zhTW': self.textLangZhTW,
      'Text_lang_esES': self.textLangEsES,
      'Text_lang_esMX': self.textLangEsMX,
      'Text_lang_ruRU': self.textLangRuRU,
      'Text_lang_jaJP': self.textLangJaJP,
      'Text_lang_ptPT': self.textLangPtPT,
      'Text_lang_ptBR': self.textLangPtBR,
      'Text_lang_itIT': self.textLangItIT,
      'Text_lang_unk1': self.textLangUnk1,
      'Text_lang_unk2': self.textLangUnk2,
      'Text_lang_unk3': self.textLangUnk3,
      'Text_lang_Flags': self.textLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as EmoteTextDataEntity;
    return identical(self, other) ||
        other is EmoteTextDataEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.textLangEnUS == other.textLangEnUS &&
            self.textLangKoKR == other.textLangKoKR &&
            self.textLangFrFR == other.textLangFrFR &&
            self.textLangDeDE == other.textLangDeDE &&
            self.textLangZhCN == other.textLangZhCN &&
            self.textLangZhTW == other.textLangZhTW &&
            self.textLangEsES == other.textLangEsES &&
            self.textLangEsMX == other.textLangEsMX &&
            self.textLangRuRU == other.textLangRuRU &&
            self.textLangJaJP == other.textLangJaJP &&
            self.textLangPtPT == other.textLangPtPT &&
            self.textLangPtBR == other.textLangPtBR &&
            self.textLangItIT == other.textLangItIT &&
            self.textLangUnk1 == other.textLangUnk1 &&
            self.textLangUnk2 == other.textLangUnk2 &&
            self.textLangUnk3 == other.textLangUnk3 &&
            self.textLangFlags == other.textLangFlags;
  }

  @override
  int get hashCode {
    final self = this as EmoteTextDataEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.textLangEnUS,
      self.textLangKoKR,
      self.textLangFrFR,
      self.textLangDeDE,
      self.textLangZhCN,
      self.textLangZhTW,
      self.textLangEsES,
      self.textLangEsMX,
      self.textLangRuRU,
      self.textLangJaJP,
      self.textLangPtPT,
      self.textLangPtBR,
      self.textLangItIT,
      self.textLangUnk1,
      self.textLangUnk2,
      self.textLangUnk3,
      self.textLangFlags,
    ]);
  }

  @override
  String toString() {
    final self = this as EmoteTextDataEntity;
    return 'EmoteTextDataEntity('
        'id: ${self.id}, '
        'textLangEnUS: ${self.textLangEnUS}, '
        'textLangKoKR: ${self.textLangKoKR}, '
        'textLangFrFR: ${self.textLangFrFR}, '
        'textLangDeDE: ${self.textLangDeDE}, '
        'textLangZhCN: ${self.textLangZhCN}, '
        'textLangZhTW: ${self.textLangZhTW}, '
        'textLangEsES: ${self.textLangEsES}, '
        'textLangEsMX: ${self.textLangEsMX}, '
        'textLangRuRU: ${self.textLangRuRU}, '
        'textLangJaJP: ${self.textLangJaJP}, '
        'textLangPtPT: ${self.textLangPtPT}, '
        'textLangPtBR: ${self.textLangPtBR}, '
        'textLangItIT: ${self.textLangItIT}, '
        'textLangUnk1: ${self.textLangUnk1}, '
        'textLangUnk2: ${self.textLangUnk2}, '
        'textLangUnk3: ${self.textLangUnk3}, '
        'textLangFlags: ${self.textLangFlags}'
        ')';
  }
}
