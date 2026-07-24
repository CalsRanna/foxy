// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_info_entity.dart';

mixin _QuestInfoEntityMixin {
  int get id;
  String get infoNameLangEnUS;
  String get infoNameLangKoKR;
  String get infoNameLangFrFR;
  String get infoNameLangDeDE;
  String get infoNameLangZhCN;
  String get infoNameLangZhTW;
  String get infoNameLangEsES;
  String get infoNameLangEsMX;
  String get infoNameLangRuRU;
  String get infoNameLangJaJP;
  String get infoNameLangPtPT;
  String get infoNameLangPtBR;
  String get infoNameLangItIT;
  String get infoNameLangUnk1;
  String get infoNameLangUnk2;
  String get infoNameLangUnk3;
  int get infoNameLangFlags;

  static QuestInfoEntity fromJson(Map<String, dynamic> json) {
    return QuestInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      infoNameLangEnUS: json['InfoName_lang_enUS']?.toString() ?? '',
      infoNameLangKoKR: json['InfoName_lang_koKR']?.toString() ?? '',
      infoNameLangFrFR: json['InfoName_lang_frFR']?.toString() ?? '',
      infoNameLangDeDE: json['InfoName_lang_deDE']?.toString() ?? '',
      infoNameLangZhCN: json['InfoName_lang_zhCN']?.toString() ?? '',
      infoNameLangZhTW: json['InfoName_lang_zhTW']?.toString() ?? '',
      infoNameLangEsES: json['InfoName_lang_esES']?.toString() ?? '',
      infoNameLangEsMX: json['InfoName_lang_esMX']?.toString() ?? '',
      infoNameLangRuRU: json['InfoName_lang_ruRU']?.toString() ?? '',
      infoNameLangJaJP: json['InfoName_lang_jaJP']?.toString() ?? '',
      infoNameLangPtPT: json['InfoName_lang_ptPT']?.toString() ?? '',
      infoNameLangPtBR: json['InfoName_lang_ptBR']?.toString() ?? '',
      infoNameLangItIT: json['InfoName_lang_itIT']?.toString() ?? '',
      infoNameLangUnk1: json['InfoName_lang_unk1']?.toString() ?? '',
      infoNameLangUnk2: json['InfoName_lang_unk2']?.toString() ?? '',
      infoNameLangUnk3: json['InfoName_lang_unk3']?.toString() ?? '',
      infoNameLangFlags: (json['InfoName_lang_Flags'] as num?)?.toInt() ?? 0,
    );
  }

  QuestInfoEntity copyWith({
    int? id,
    String? infoNameLangEnUS,
    String? infoNameLangKoKR,
    String? infoNameLangFrFR,
    String? infoNameLangDeDE,
    String? infoNameLangZhCN,
    String? infoNameLangZhTW,
    String? infoNameLangEsES,
    String? infoNameLangEsMX,
    String? infoNameLangRuRU,
    String? infoNameLangJaJP,
    String? infoNameLangPtPT,
    String? infoNameLangPtBR,
    String? infoNameLangItIT,
    String? infoNameLangUnk1,
    String? infoNameLangUnk2,
    String? infoNameLangUnk3,
    int? infoNameLangFlags,
  }) {
    return QuestInfoEntity(
      id: id ?? this.id,
      infoNameLangEnUS: infoNameLangEnUS ?? this.infoNameLangEnUS,
      infoNameLangKoKR: infoNameLangKoKR ?? this.infoNameLangKoKR,
      infoNameLangFrFR: infoNameLangFrFR ?? this.infoNameLangFrFR,
      infoNameLangDeDE: infoNameLangDeDE ?? this.infoNameLangDeDE,
      infoNameLangZhCN: infoNameLangZhCN ?? this.infoNameLangZhCN,
      infoNameLangZhTW: infoNameLangZhTW ?? this.infoNameLangZhTW,
      infoNameLangEsES: infoNameLangEsES ?? this.infoNameLangEsES,
      infoNameLangEsMX: infoNameLangEsMX ?? this.infoNameLangEsMX,
      infoNameLangRuRU: infoNameLangRuRU ?? this.infoNameLangRuRU,
      infoNameLangJaJP: infoNameLangJaJP ?? this.infoNameLangJaJP,
      infoNameLangPtPT: infoNameLangPtPT ?? this.infoNameLangPtPT,
      infoNameLangPtBR: infoNameLangPtBR ?? this.infoNameLangPtBR,
      infoNameLangItIT: infoNameLangItIT ?? this.infoNameLangItIT,
      infoNameLangUnk1: infoNameLangUnk1 ?? this.infoNameLangUnk1,
      infoNameLangUnk2: infoNameLangUnk2 ?? this.infoNameLangUnk2,
      infoNameLangUnk3: infoNameLangUnk3 ?? this.infoNameLangUnk3,
      infoNameLangFlags: infoNameLangFlags ?? this.infoNameLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'InfoName_lang_enUS': infoNameLangEnUS,
      'InfoName_lang_koKR': infoNameLangKoKR,
      'InfoName_lang_frFR': infoNameLangFrFR,
      'InfoName_lang_deDE': infoNameLangDeDE,
      'InfoName_lang_zhCN': infoNameLangZhCN,
      'InfoName_lang_zhTW': infoNameLangZhTW,
      'InfoName_lang_esES': infoNameLangEsES,
      'InfoName_lang_esMX': infoNameLangEsMX,
      'InfoName_lang_ruRU': infoNameLangRuRU,
      'InfoName_lang_jaJP': infoNameLangJaJP,
      'InfoName_lang_ptPT': infoNameLangPtPT,
      'InfoName_lang_ptBR': infoNameLangPtBR,
      'InfoName_lang_itIT': infoNameLangItIT,
      'InfoName_lang_unk1': infoNameLangUnk1,
      'InfoName_lang_unk2': infoNameLangUnk2,
      'InfoName_lang_unk3': infoNameLangUnk3,
      'InfoName_lang_Flags': infoNameLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestInfoEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            infoNameLangEnUS == other.infoNameLangEnUS &&
            infoNameLangKoKR == other.infoNameLangKoKR &&
            infoNameLangFrFR == other.infoNameLangFrFR &&
            infoNameLangDeDE == other.infoNameLangDeDE &&
            infoNameLangZhCN == other.infoNameLangZhCN &&
            infoNameLangZhTW == other.infoNameLangZhTW &&
            infoNameLangEsES == other.infoNameLangEsES &&
            infoNameLangEsMX == other.infoNameLangEsMX &&
            infoNameLangRuRU == other.infoNameLangRuRU &&
            infoNameLangJaJP == other.infoNameLangJaJP &&
            infoNameLangPtPT == other.infoNameLangPtPT &&
            infoNameLangPtBR == other.infoNameLangPtBR &&
            infoNameLangItIT == other.infoNameLangItIT &&
            infoNameLangUnk1 == other.infoNameLangUnk1 &&
            infoNameLangUnk2 == other.infoNameLangUnk2 &&
            infoNameLangUnk3 == other.infoNameLangUnk3 &&
            infoNameLangFlags == other.infoNameLangFlags;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      infoNameLangEnUS,
      infoNameLangKoKR,
      infoNameLangFrFR,
      infoNameLangDeDE,
      infoNameLangZhCN,
      infoNameLangZhTW,
      infoNameLangEsES,
      infoNameLangEsMX,
      infoNameLangRuRU,
      infoNameLangJaJP,
      infoNameLangPtPT,
      infoNameLangPtBR,
      infoNameLangItIT,
      infoNameLangUnk1,
      infoNameLangUnk2,
      infoNameLangUnk3,
      infoNameLangFlags,
    ]);
  }

  @override
  String toString() {
    return 'QuestInfoEntity('
        'id: $id, '
        'infoNameLangEnUS: $infoNameLangEnUS, '
        'infoNameLangKoKR: $infoNameLangKoKR, '
        'infoNameLangFrFR: $infoNameLangFrFR, '
        'infoNameLangDeDE: $infoNameLangDeDE, '
        'infoNameLangZhCN: $infoNameLangZhCN, '
        'infoNameLangZhTW: $infoNameLangZhTW, '
        'infoNameLangEsES: $infoNameLangEsES, '
        'infoNameLangEsMX: $infoNameLangEsMX, '
        'infoNameLangRuRU: $infoNameLangRuRU, '
        'infoNameLangJaJP: $infoNameLangJaJP, '
        'infoNameLangPtPT: $infoNameLangPtPT, '
        'infoNameLangPtBR: $infoNameLangPtBR, '
        'infoNameLangItIT: $infoNameLangItIT, '
        'infoNameLangUnk1: $infoNameLangUnk1, '
        'infoNameLangUnk2: $infoNameLangUnk2, '
        'infoNameLangUnk3: $infoNameLangUnk3, '
        'infoNameLangFlags: $infoNameLangFlags'
        ')';
  }
}
