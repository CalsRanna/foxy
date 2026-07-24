// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_sort_entity.dart';

mixin _QuestSortEntityMixin {
  int get id;
  String get sortNameLangEnUS;
  String get sortNameLangKoKR;
  String get sortNameLangFrFR;
  String get sortNameLangDeDE;
  String get sortNameLangZhCN;
  String get sortNameLangZhTW;
  String get sortNameLangEsES;
  String get sortNameLangEsMX;
  String get sortNameLangRuRU;
  String get sortNameLangJaJP;
  String get sortNameLangPtPT;
  String get sortNameLangPtBR;
  String get sortNameLangItIT;
  String get sortNameLangUnk1;
  String get sortNameLangUnk2;
  String get sortNameLangUnk3;
  int get sortNameLangFlags;

  static QuestSortEntity fromJson(Map<String, dynamic> json) {
    return QuestSortEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      sortNameLangEnUS: json['SortName_lang_enUS']?.toString() ?? '',
      sortNameLangKoKR: json['SortName_lang_koKR']?.toString() ?? '',
      sortNameLangFrFR: json['SortName_lang_frFR']?.toString() ?? '',
      sortNameLangDeDE: json['SortName_lang_deDE']?.toString() ?? '',
      sortNameLangZhCN: json['SortName_lang_zhCN']?.toString() ?? '',
      sortNameLangZhTW: json['SortName_lang_zhTW']?.toString() ?? '',
      sortNameLangEsES: json['SortName_lang_esES']?.toString() ?? '',
      sortNameLangEsMX: json['SortName_lang_esMX']?.toString() ?? '',
      sortNameLangRuRU: json['SortName_lang_ruRU']?.toString() ?? '',
      sortNameLangJaJP: json['SortName_lang_jaJP']?.toString() ?? '',
      sortNameLangPtPT: json['SortName_lang_ptPT']?.toString() ?? '',
      sortNameLangPtBR: json['SortName_lang_ptBR']?.toString() ?? '',
      sortNameLangItIT: json['SortName_lang_itIT']?.toString() ?? '',
      sortNameLangUnk1: json['SortName_lang_unk1']?.toString() ?? '',
      sortNameLangUnk2: json['SortName_lang_unk2']?.toString() ?? '',
      sortNameLangUnk3: json['SortName_lang_unk3']?.toString() ?? '',
      sortNameLangFlags: (json['SortName_lang_Flags'] as num?)?.toInt() ?? 0,
    );
  }

  QuestSortEntity copyWith({
    int? id,
    String? sortNameLangEnUS,
    String? sortNameLangKoKR,
    String? sortNameLangFrFR,
    String? sortNameLangDeDE,
    String? sortNameLangZhCN,
    String? sortNameLangZhTW,
    String? sortNameLangEsES,
    String? sortNameLangEsMX,
    String? sortNameLangRuRU,
    String? sortNameLangJaJP,
    String? sortNameLangPtPT,
    String? sortNameLangPtBR,
    String? sortNameLangItIT,
    String? sortNameLangUnk1,
    String? sortNameLangUnk2,
    String? sortNameLangUnk3,
    int? sortNameLangFlags,
  }) {
    return QuestSortEntity(
      id: id ?? this.id,
      sortNameLangEnUS: sortNameLangEnUS ?? this.sortNameLangEnUS,
      sortNameLangKoKR: sortNameLangKoKR ?? this.sortNameLangKoKR,
      sortNameLangFrFR: sortNameLangFrFR ?? this.sortNameLangFrFR,
      sortNameLangDeDE: sortNameLangDeDE ?? this.sortNameLangDeDE,
      sortNameLangZhCN: sortNameLangZhCN ?? this.sortNameLangZhCN,
      sortNameLangZhTW: sortNameLangZhTW ?? this.sortNameLangZhTW,
      sortNameLangEsES: sortNameLangEsES ?? this.sortNameLangEsES,
      sortNameLangEsMX: sortNameLangEsMX ?? this.sortNameLangEsMX,
      sortNameLangRuRU: sortNameLangRuRU ?? this.sortNameLangRuRU,
      sortNameLangJaJP: sortNameLangJaJP ?? this.sortNameLangJaJP,
      sortNameLangPtPT: sortNameLangPtPT ?? this.sortNameLangPtPT,
      sortNameLangPtBR: sortNameLangPtBR ?? this.sortNameLangPtBR,
      sortNameLangItIT: sortNameLangItIT ?? this.sortNameLangItIT,
      sortNameLangUnk1: sortNameLangUnk1 ?? this.sortNameLangUnk1,
      sortNameLangUnk2: sortNameLangUnk2 ?? this.sortNameLangUnk2,
      sortNameLangUnk3: sortNameLangUnk3 ?? this.sortNameLangUnk3,
      sortNameLangFlags: sortNameLangFlags ?? this.sortNameLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SortName_lang_enUS': sortNameLangEnUS,
      'SortName_lang_koKR': sortNameLangKoKR,
      'SortName_lang_frFR': sortNameLangFrFR,
      'SortName_lang_deDE': sortNameLangDeDE,
      'SortName_lang_zhCN': sortNameLangZhCN,
      'SortName_lang_zhTW': sortNameLangZhTW,
      'SortName_lang_esES': sortNameLangEsES,
      'SortName_lang_esMX': sortNameLangEsMX,
      'SortName_lang_ruRU': sortNameLangRuRU,
      'SortName_lang_jaJP': sortNameLangJaJP,
      'SortName_lang_ptPT': sortNameLangPtPT,
      'SortName_lang_ptBR': sortNameLangPtBR,
      'SortName_lang_itIT': sortNameLangItIT,
      'SortName_lang_unk1': sortNameLangUnk1,
      'SortName_lang_unk2': sortNameLangUnk2,
      'SortName_lang_unk3': sortNameLangUnk3,
      'SortName_lang_Flags': sortNameLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestSortEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            sortNameLangEnUS == other.sortNameLangEnUS &&
            sortNameLangKoKR == other.sortNameLangKoKR &&
            sortNameLangFrFR == other.sortNameLangFrFR &&
            sortNameLangDeDE == other.sortNameLangDeDE &&
            sortNameLangZhCN == other.sortNameLangZhCN &&
            sortNameLangZhTW == other.sortNameLangZhTW &&
            sortNameLangEsES == other.sortNameLangEsES &&
            sortNameLangEsMX == other.sortNameLangEsMX &&
            sortNameLangRuRU == other.sortNameLangRuRU &&
            sortNameLangJaJP == other.sortNameLangJaJP &&
            sortNameLangPtPT == other.sortNameLangPtPT &&
            sortNameLangPtBR == other.sortNameLangPtBR &&
            sortNameLangItIT == other.sortNameLangItIT &&
            sortNameLangUnk1 == other.sortNameLangUnk1 &&
            sortNameLangUnk2 == other.sortNameLangUnk2 &&
            sortNameLangUnk3 == other.sortNameLangUnk3 &&
            sortNameLangFlags == other.sortNameLangFlags;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      sortNameLangEnUS,
      sortNameLangKoKR,
      sortNameLangFrFR,
      sortNameLangDeDE,
      sortNameLangZhCN,
      sortNameLangZhTW,
      sortNameLangEsES,
      sortNameLangEsMX,
      sortNameLangRuRU,
      sortNameLangJaJP,
      sortNameLangPtPT,
      sortNameLangPtBR,
      sortNameLangItIT,
      sortNameLangUnk1,
      sortNameLangUnk2,
      sortNameLangUnk3,
      sortNameLangFlags,
    ]);
  }

  @override
  String toString() {
    return 'QuestSortEntity('
        'id: $id, '
        'sortNameLangEnUS: $sortNameLangEnUS, '
        'sortNameLangKoKR: $sortNameLangKoKR, '
        'sortNameLangFrFR: $sortNameLangFrFR, '
        'sortNameLangDeDE: $sortNameLangDeDE, '
        'sortNameLangZhCN: $sortNameLangZhCN, '
        'sortNameLangZhTW: $sortNameLangZhTW, '
        'sortNameLangEsES: $sortNameLangEsES, '
        'sortNameLangEsMX: $sortNameLangEsMX, '
        'sortNameLangRuRU: $sortNameLangRuRU, '
        'sortNameLangJaJP: $sortNameLangJaJP, '
        'sortNameLangPtPT: $sortNameLangPtPT, '
        'sortNameLangPtBR: $sortNameLangPtBR, '
        'sortNameLangItIT: $sortNameLangItIT, '
        'sortNameLangUnk1: $sortNameLangUnk1, '
        'sortNameLangUnk2: $sortNameLangUnk2, '
        'sortNameLangUnk3: $sortNameLangUnk3, '
        'sortNameLangFlags: $sortNameLangFlags'
        ')';
  }
}
