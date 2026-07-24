// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_sort_entity.dart';

mixin _QuestSortEntityMixin {
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
    final self = this as QuestSortEntity;
    return QuestSortEntity(
      id: id ?? self.id,
      sortNameLangEnUS: sortNameLangEnUS ?? self.sortNameLangEnUS,
      sortNameLangKoKR: sortNameLangKoKR ?? self.sortNameLangKoKR,
      sortNameLangFrFR: sortNameLangFrFR ?? self.sortNameLangFrFR,
      sortNameLangDeDE: sortNameLangDeDE ?? self.sortNameLangDeDE,
      sortNameLangZhCN: sortNameLangZhCN ?? self.sortNameLangZhCN,
      sortNameLangZhTW: sortNameLangZhTW ?? self.sortNameLangZhTW,
      sortNameLangEsES: sortNameLangEsES ?? self.sortNameLangEsES,
      sortNameLangEsMX: sortNameLangEsMX ?? self.sortNameLangEsMX,
      sortNameLangRuRU: sortNameLangRuRU ?? self.sortNameLangRuRU,
      sortNameLangJaJP: sortNameLangJaJP ?? self.sortNameLangJaJP,
      sortNameLangPtPT: sortNameLangPtPT ?? self.sortNameLangPtPT,
      sortNameLangPtBR: sortNameLangPtBR ?? self.sortNameLangPtBR,
      sortNameLangItIT: sortNameLangItIT ?? self.sortNameLangItIT,
      sortNameLangUnk1: sortNameLangUnk1 ?? self.sortNameLangUnk1,
      sortNameLangUnk2: sortNameLangUnk2 ?? self.sortNameLangUnk2,
      sortNameLangUnk3: sortNameLangUnk3 ?? self.sortNameLangUnk3,
      sortNameLangFlags: sortNameLangFlags ?? self.sortNameLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestSortEntity;
    return {
      'ID': self.id,
      'SortName_lang_enUS': self.sortNameLangEnUS,
      'SortName_lang_koKR': self.sortNameLangKoKR,
      'SortName_lang_frFR': self.sortNameLangFrFR,
      'SortName_lang_deDE': self.sortNameLangDeDE,
      'SortName_lang_zhCN': self.sortNameLangZhCN,
      'SortName_lang_zhTW': self.sortNameLangZhTW,
      'SortName_lang_esES': self.sortNameLangEsES,
      'SortName_lang_esMX': self.sortNameLangEsMX,
      'SortName_lang_ruRU': self.sortNameLangRuRU,
      'SortName_lang_jaJP': self.sortNameLangJaJP,
      'SortName_lang_ptPT': self.sortNameLangPtPT,
      'SortName_lang_ptBR': self.sortNameLangPtBR,
      'SortName_lang_itIT': self.sortNameLangItIT,
      'SortName_lang_unk1': self.sortNameLangUnk1,
      'SortName_lang_unk2': self.sortNameLangUnk2,
      'SortName_lang_unk3': self.sortNameLangUnk3,
      'SortName_lang_Flags': self.sortNameLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestSortEntity;
    return identical(self, other) ||
        other is QuestSortEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.sortNameLangEnUS == other.sortNameLangEnUS &&
            self.sortNameLangKoKR == other.sortNameLangKoKR &&
            self.sortNameLangFrFR == other.sortNameLangFrFR &&
            self.sortNameLangDeDE == other.sortNameLangDeDE &&
            self.sortNameLangZhCN == other.sortNameLangZhCN &&
            self.sortNameLangZhTW == other.sortNameLangZhTW &&
            self.sortNameLangEsES == other.sortNameLangEsES &&
            self.sortNameLangEsMX == other.sortNameLangEsMX &&
            self.sortNameLangRuRU == other.sortNameLangRuRU &&
            self.sortNameLangJaJP == other.sortNameLangJaJP &&
            self.sortNameLangPtPT == other.sortNameLangPtPT &&
            self.sortNameLangPtBR == other.sortNameLangPtBR &&
            self.sortNameLangItIT == other.sortNameLangItIT &&
            self.sortNameLangUnk1 == other.sortNameLangUnk1 &&
            self.sortNameLangUnk2 == other.sortNameLangUnk2 &&
            self.sortNameLangUnk3 == other.sortNameLangUnk3 &&
            self.sortNameLangFlags == other.sortNameLangFlags;
  }

  @override
  int get hashCode {
    final self = this as QuestSortEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.sortNameLangEnUS,
      self.sortNameLangKoKR,
      self.sortNameLangFrFR,
      self.sortNameLangDeDE,
      self.sortNameLangZhCN,
      self.sortNameLangZhTW,
      self.sortNameLangEsES,
      self.sortNameLangEsMX,
      self.sortNameLangRuRU,
      self.sortNameLangJaJP,
      self.sortNameLangPtPT,
      self.sortNameLangPtBR,
      self.sortNameLangItIT,
      self.sortNameLangUnk1,
      self.sortNameLangUnk2,
      self.sortNameLangUnk3,
      self.sortNameLangFlags,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestSortEntity;
    return 'QuestSortEntity('
        'id: ${self.id}, '
        'sortNameLangEnUS: ${self.sortNameLangEnUS}, '
        'sortNameLangKoKR: ${self.sortNameLangKoKR}, '
        'sortNameLangFrFR: ${self.sortNameLangFrFR}, '
        'sortNameLangDeDE: ${self.sortNameLangDeDE}, '
        'sortNameLangZhCN: ${self.sortNameLangZhCN}, '
        'sortNameLangZhTW: ${self.sortNameLangZhTW}, '
        'sortNameLangEsES: ${self.sortNameLangEsES}, '
        'sortNameLangEsMX: ${self.sortNameLangEsMX}, '
        'sortNameLangRuRU: ${self.sortNameLangRuRU}, '
        'sortNameLangJaJP: ${self.sortNameLangJaJP}, '
        'sortNameLangPtPT: ${self.sortNameLangPtPT}, '
        'sortNameLangPtBR: ${self.sortNameLangPtBR}, '
        'sortNameLangItIT: ${self.sortNameLangItIT}, '
        'sortNameLangUnk1: ${self.sortNameLangUnk1}, '
        'sortNameLangUnk2: ${self.sortNameLangUnk2}, '
        'sortNameLangUnk3: ${self.sortNameLangUnk3}, '
        'sortNameLangFlags: ${self.sortNameLangFlags}'
        ')';
  }
}
