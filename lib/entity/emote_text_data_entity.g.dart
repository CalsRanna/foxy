// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_data_entity.dart';

mixin _EmoteTextDataEntityMixin {
  int get id;
  String get textLangEnUS;
  String get textLangKoKR;
  String get textLangFrFR;
  String get textLangDeDE;
  String get textLangZhCN;
  String get textLangZhTW;
  String get textLangEsES;
  String get textLangEsMX;
  String get textLangRuRU;
  String get textLangJaJP;
  String get textLangPtPT;
  String get textLangPtBR;
  String get textLangItIT;
  String get textLangUnk1;
  String get textLangUnk2;
  String get textLangUnk3;
  int get textLangFlags;

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
    return EmoteTextDataEntity(
      id: id ?? this.id,
      textLangEnUS: textLangEnUS ?? this.textLangEnUS,
      textLangKoKR: textLangKoKR ?? this.textLangKoKR,
      textLangFrFR: textLangFrFR ?? this.textLangFrFR,
      textLangDeDE: textLangDeDE ?? this.textLangDeDE,
      textLangZhCN: textLangZhCN ?? this.textLangZhCN,
      textLangZhTW: textLangZhTW ?? this.textLangZhTW,
      textLangEsES: textLangEsES ?? this.textLangEsES,
      textLangEsMX: textLangEsMX ?? this.textLangEsMX,
      textLangRuRU: textLangRuRU ?? this.textLangRuRU,
      textLangJaJP: textLangJaJP ?? this.textLangJaJP,
      textLangPtPT: textLangPtPT ?? this.textLangPtPT,
      textLangPtBR: textLangPtBR ?? this.textLangPtBR,
      textLangItIT: textLangItIT ?? this.textLangItIT,
      textLangUnk1: textLangUnk1 ?? this.textLangUnk1,
      textLangUnk2: textLangUnk2 ?? this.textLangUnk2,
      textLangUnk3: textLangUnk3 ?? this.textLangUnk3,
      textLangFlags: textLangFlags ?? this.textLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EmoteTextDataEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            textLangEnUS == other.textLangEnUS &&
            textLangKoKR == other.textLangKoKR &&
            textLangFrFR == other.textLangFrFR &&
            textLangDeDE == other.textLangDeDE &&
            textLangZhCN == other.textLangZhCN &&
            textLangZhTW == other.textLangZhTW &&
            textLangEsES == other.textLangEsES &&
            textLangEsMX == other.textLangEsMX &&
            textLangRuRU == other.textLangRuRU &&
            textLangJaJP == other.textLangJaJP &&
            textLangPtPT == other.textLangPtPT &&
            textLangPtBR == other.textLangPtBR &&
            textLangItIT == other.textLangItIT &&
            textLangUnk1 == other.textLangUnk1 &&
            textLangUnk2 == other.textLangUnk2 &&
            textLangUnk3 == other.textLangUnk3 &&
            textLangFlags == other.textLangFlags;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      textLangEnUS,
      textLangKoKR,
      textLangFrFR,
      textLangDeDE,
      textLangZhCN,
      textLangZhTW,
      textLangEsES,
      textLangEsMX,
      textLangRuRU,
      textLangJaJP,
      textLangPtPT,
      textLangPtBR,
      textLangItIT,
      textLangUnk1,
      textLangUnk2,
      textLangUnk3,
      textLangFlags,
    ]);
  }

  @override
  String toString() {
    return 'EmoteTextDataEntity('
        'id: $id, '
        'textLangEnUS: $textLangEnUS, '
        'textLangKoKR: $textLangKoKR, '
        'textLangFrFR: $textLangFrFR, '
        'textLangDeDE: $textLangDeDE, '
        'textLangZhCN: $textLangZhCN, '
        'textLangZhTW: $textLangZhTW, '
        'textLangEsES: $textLangEsES, '
        'textLangEsMX: $textLangEsMX, '
        'textLangRuRU: $textLangRuRU, '
        'textLangJaJP: $textLangJaJP, '
        'textLangPtPT: $textLangPtPT, '
        'textLangPtBR: $textLangPtBR, '
        'textLangItIT: $textLangItIT, '
        'textLangUnk1: $textLangUnk1, '
        'textLangUnk2: $textLangUnk2, '
        'textLangUnk3: $textLangUnk3, '
        'textLangFlags: $textLangFlags'
        ')';
  }
}
