// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'char_title_entity.dart';

mixin _CharTitleEntityMixin {
  static CharTitleEntity fromJson(Map<String, dynamic> json) {
    return CharTitleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      conditionId: (json['Condition_ID'] as num?)?.toInt() ?? 0,
      nameLangEnUS: json['Name_lang_enUS']?.toString() ?? '',
      nameLangKoKR: json['Name_lang_koKR']?.toString() ?? '',
      nameLangFrFR: json['Name_lang_frFR']?.toString() ?? '',
      nameLangDeDE: json['Name_lang_deDE']?.toString() ?? '',
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      nameLangZhTW: json['Name_lang_zhTW']?.toString() ?? '',
      nameLangEsES: json['Name_lang_esES']?.toString() ?? '',
      nameLangEsMX: json['Name_lang_esMX']?.toString() ?? '',
      nameLangRuRU: json['Name_lang_ruRU']?.toString() ?? '',
      nameLangJaJP: json['Name_lang_jaJP']?.toString() ?? '',
      nameLangPtPT: json['Name_lang_ptPT']?.toString() ?? '',
      nameLangPtBR: json['Name_lang_ptBR']?.toString() ?? '',
      nameLangItIT: json['Name_lang_itIT']?.toString() ?? '',
      nameLangUnk1: json['Name_lang_unk1']?.toString() ?? '',
      nameLangUnk2: json['Name_lang_unk2']?.toString() ?? '',
      nameLangUnk3: json['Name_lang_unk3']?.toString() ?? '',
      nameLangFlags: (json['Name_lang_Flags'] as num?)?.toInt() ?? 0,
      name1LangEnUS: json['Name1_lang_enUS']?.toString() ?? '',
      name1LangKoKR: json['Name1_lang_koKR']?.toString() ?? '',
      name1LangFrFR: json['Name1_lang_frFR']?.toString() ?? '',
      name1LangDeDE: json['Name1_lang_deDE']?.toString() ?? '',
      name1LangZhCN: json['Name1_lang_zhCN']?.toString() ?? '',
      name1LangZhTW: json['Name1_lang_zhTW']?.toString() ?? '',
      name1LangEsES: json['Name1_lang_esES']?.toString() ?? '',
      name1LangEsMX: json['Name1_lang_esMX']?.toString() ?? '',
      name1LangRuRU: json['Name1_lang_ruRU']?.toString() ?? '',
      name1LangJaJP: json['Name1_lang_jaJP']?.toString() ?? '',
      name1LangPtPT: json['Name1_lang_ptPT']?.toString() ?? '',
      name1LangPtBR: json['Name1_lang_ptBR']?.toString() ?? '',
      name1LangItIT: json['Name1_lang_itIT']?.toString() ?? '',
      name1LangUnk1: json['Name1_lang_unk1']?.toString() ?? '',
      name1LangUnk2: json['Name1_lang_unk2']?.toString() ?? '',
      name1LangUnk3: json['Name1_lang_unk3']?.toString() ?? '',
      name1LangFlags: (json['Name1_lang_Flags'] as num?)?.toInt() ?? 0,
      maskId: (json['Mask_ID'] as num?)?.toInt() ?? 0,
    );
  }

  CharTitleEntity copyWith({
    int? id,
    int? conditionId,
    String? nameLangEnUS,
    String? nameLangKoKR,
    String? nameLangFrFR,
    String? nameLangDeDE,
    String? nameLangZhCN,
    String? nameLangZhTW,
    String? nameLangEsES,
    String? nameLangEsMX,
    String? nameLangRuRU,
    String? nameLangJaJP,
    String? nameLangPtPT,
    String? nameLangPtBR,
    String? nameLangItIT,
    String? nameLangUnk1,
    String? nameLangUnk2,
    String? nameLangUnk3,
    int? nameLangFlags,
    String? name1LangEnUS,
    String? name1LangKoKR,
    String? name1LangFrFR,
    String? name1LangDeDE,
    String? name1LangZhCN,
    String? name1LangZhTW,
    String? name1LangEsES,
    String? name1LangEsMX,
    String? name1LangRuRU,
    String? name1LangJaJP,
    String? name1LangPtPT,
    String? name1LangPtBR,
    String? name1LangItIT,
    String? name1LangUnk1,
    String? name1LangUnk2,
    String? name1LangUnk3,
    int? name1LangFlags,
    int? maskId,
  }) {
    final self = this as CharTitleEntity;
    return CharTitleEntity(
      id: id ?? self.id,
      conditionId: conditionId ?? self.conditionId,
      nameLangEnUS: nameLangEnUS ?? self.nameLangEnUS,
      nameLangKoKR: nameLangKoKR ?? self.nameLangKoKR,
      nameLangFrFR: nameLangFrFR ?? self.nameLangFrFR,
      nameLangDeDE: nameLangDeDE ?? self.nameLangDeDE,
      nameLangZhCN: nameLangZhCN ?? self.nameLangZhCN,
      nameLangZhTW: nameLangZhTW ?? self.nameLangZhTW,
      nameLangEsES: nameLangEsES ?? self.nameLangEsES,
      nameLangEsMX: nameLangEsMX ?? self.nameLangEsMX,
      nameLangRuRU: nameLangRuRU ?? self.nameLangRuRU,
      nameLangJaJP: nameLangJaJP ?? self.nameLangJaJP,
      nameLangPtPT: nameLangPtPT ?? self.nameLangPtPT,
      nameLangPtBR: nameLangPtBR ?? self.nameLangPtBR,
      nameLangItIT: nameLangItIT ?? self.nameLangItIT,
      nameLangUnk1: nameLangUnk1 ?? self.nameLangUnk1,
      nameLangUnk2: nameLangUnk2 ?? self.nameLangUnk2,
      nameLangUnk3: nameLangUnk3 ?? self.nameLangUnk3,
      nameLangFlags: nameLangFlags ?? self.nameLangFlags,
      name1LangEnUS: name1LangEnUS ?? self.name1LangEnUS,
      name1LangKoKR: name1LangKoKR ?? self.name1LangKoKR,
      name1LangFrFR: name1LangFrFR ?? self.name1LangFrFR,
      name1LangDeDE: name1LangDeDE ?? self.name1LangDeDE,
      name1LangZhCN: name1LangZhCN ?? self.name1LangZhCN,
      name1LangZhTW: name1LangZhTW ?? self.name1LangZhTW,
      name1LangEsES: name1LangEsES ?? self.name1LangEsES,
      name1LangEsMX: name1LangEsMX ?? self.name1LangEsMX,
      name1LangRuRU: name1LangRuRU ?? self.name1LangRuRU,
      name1LangJaJP: name1LangJaJP ?? self.name1LangJaJP,
      name1LangPtPT: name1LangPtPT ?? self.name1LangPtPT,
      name1LangPtBR: name1LangPtBR ?? self.name1LangPtBR,
      name1LangItIT: name1LangItIT ?? self.name1LangItIT,
      name1LangUnk1: name1LangUnk1 ?? self.name1LangUnk1,
      name1LangUnk2: name1LangUnk2 ?? self.name1LangUnk2,
      name1LangUnk3: name1LangUnk3 ?? self.name1LangUnk3,
      name1LangFlags: name1LangFlags ?? self.name1LangFlags,
      maskId: maskId ?? self.maskId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CharTitleEntity;
    return {
      'ID': self.id,
      'Condition_ID': self.conditionId,
      'Name_lang_enUS': self.nameLangEnUS,
      'Name_lang_koKR': self.nameLangKoKR,
      'Name_lang_frFR': self.nameLangFrFR,
      'Name_lang_deDE': self.nameLangDeDE,
      'Name_lang_zhCN': self.nameLangZhCN,
      'Name_lang_zhTW': self.nameLangZhTW,
      'Name_lang_esES': self.nameLangEsES,
      'Name_lang_esMX': self.nameLangEsMX,
      'Name_lang_ruRU': self.nameLangRuRU,
      'Name_lang_jaJP': self.nameLangJaJP,
      'Name_lang_ptPT': self.nameLangPtPT,
      'Name_lang_ptBR': self.nameLangPtBR,
      'Name_lang_itIT': self.nameLangItIT,
      'Name_lang_unk1': self.nameLangUnk1,
      'Name_lang_unk2': self.nameLangUnk2,
      'Name_lang_unk3': self.nameLangUnk3,
      'Name_lang_Flags': self.nameLangFlags,
      'Name1_lang_enUS': self.name1LangEnUS,
      'Name1_lang_koKR': self.name1LangKoKR,
      'Name1_lang_frFR': self.name1LangFrFR,
      'Name1_lang_deDE': self.name1LangDeDE,
      'Name1_lang_zhCN': self.name1LangZhCN,
      'Name1_lang_zhTW': self.name1LangZhTW,
      'Name1_lang_esES': self.name1LangEsES,
      'Name1_lang_esMX': self.name1LangEsMX,
      'Name1_lang_ruRU': self.name1LangRuRU,
      'Name1_lang_jaJP': self.name1LangJaJP,
      'Name1_lang_ptPT': self.name1LangPtPT,
      'Name1_lang_ptBR': self.name1LangPtBR,
      'Name1_lang_itIT': self.name1LangItIT,
      'Name1_lang_unk1': self.name1LangUnk1,
      'Name1_lang_unk2': self.name1LangUnk2,
      'Name1_lang_unk3': self.name1LangUnk3,
      'Name1_lang_Flags': self.name1LangFlags,
      'Mask_ID': self.maskId,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CharTitleEntity;
    return identical(self, other) ||
        other is CharTitleEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.conditionId == other.conditionId &&
            self.nameLangEnUS == other.nameLangEnUS &&
            self.nameLangKoKR == other.nameLangKoKR &&
            self.nameLangFrFR == other.nameLangFrFR &&
            self.nameLangDeDE == other.nameLangDeDE &&
            self.nameLangZhCN == other.nameLangZhCN &&
            self.nameLangZhTW == other.nameLangZhTW &&
            self.nameLangEsES == other.nameLangEsES &&
            self.nameLangEsMX == other.nameLangEsMX &&
            self.nameLangRuRU == other.nameLangRuRU &&
            self.nameLangJaJP == other.nameLangJaJP &&
            self.nameLangPtPT == other.nameLangPtPT &&
            self.nameLangPtBR == other.nameLangPtBR &&
            self.nameLangItIT == other.nameLangItIT &&
            self.nameLangUnk1 == other.nameLangUnk1 &&
            self.nameLangUnk2 == other.nameLangUnk2 &&
            self.nameLangUnk3 == other.nameLangUnk3 &&
            self.nameLangFlags == other.nameLangFlags &&
            self.name1LangEnUS == other.name1LangEnUS &&
            self.name1LangKoKR == other.name1LangKoKR &&
            self.name1LangFrFR == other.name1LangFrFR &&
            self.name1LangDeDE == other.name1LangDeDE &&
            self.name1LangZhCN == other.name1LangZhCN &&
            self.name1LangZhTW == other.name1LangZhTW &&
            self.name1LangEsES == other.name1LangEsES &&
            self.name1LangEsMX == other.name1LangEsMX &&
            self.name1LangRuRU == other.name1LangRuRU &&
            self.name1LangJaJP == other.name1LangJaJP &&
            self.name1LangPtPT == other.name1LangPtPT &&
            self.name1LangPtBR == other.name1LangPtBR &&
            self.name1LangItIT == other.name1LangItIT &&
            self.name1LangUnk1 == other.name1LangUnk1 &&
            self.name1LangUnk2 == other.name1LangUnk2 &&
            self.name1LangUnk3 == other.name1LangUnk3 &&
            self.name1LangFlags == other.name1LangFlags &&
            self.maskId == other.maskId;
  }

  @override
  int get hashCode {
    final self = this as CharTitleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.conditionId,
      self.nameLangEnUS,
      self.nameLangKoKR,
      self.nameLangFrFR,
      self.nameLangDeDE,
      self.nameLangZhCN,
      self.nameLangZhTW,
      self.nameLangEsES,
      self.nameLangEsMX,
      self.nameLangRuRU,
      self.nameLangJaJP,
      self.nameLangPtPT,
      self.nameLangPtBR,
      self.nameLangItIT,
      self.nameLangUnk1,
      self.nameLangUnk2,
      self.nameLangUnk3,
      self.nameLangFlags,
      self.name1LangEnUS,
      self.name1LangKoKR,
      self.name1LangFrFR,
      self.name1LangDeDE,
      self.name1LangZhCN,
      self.name1LangZhTW,
      self.name1LangEsES,
      self.name1LangEsMX,
      self.name1LangRuRU,
      self.name1LangJaJP,
      self.name1LangPtPT,
      self.name1LangPtBR,
      self.name1LangItIT,
      self.name1LangUnk1,
      self.name1LangUnk2,
      self.name1LangUnk3,
      self.name1LangFlags,
      self.maskId,
    ]);
  }

  @override
  String toString() {
    final self = this as CharTitleEntity;
    return 'CharTitleEntity('
        'id: ${self.id}, '
        'conditionId: ${self.conditionId}, '
        'nameLangEnUS: ${self.nameLangEnUS}, '
        'nameLangKoKR: ${self.nameLangKoKR}, '
        'nameLangFrFR: ${self.nameLangFrFR}, '
        'nameLangDeDE: ${self.nameLangDeDE}, '
        'nameLangZhCN: ${self.nameLangZhCN}, '
        'nameLangZhTW: ${self.nameLangZhTW}, '
        'nameLangEsES: ${self.nameLangEsES}, '
        'nameLangEsMX: ${self.nameLangEsMX}, '
        'nameLangRuRU: ${self.nameLangRuRU}, '
        'nameLangJaJP: ${self.nameLangJaJP}, '
        'nameLangPtPT: ${self.nameLangPtPT}, '
        'nameLangPtBR: ${self.nameLangPtBR}, '
        'nameLangItIT: ${self.nameLangItIT}, '
        'nameLangUnk1: ${self.nameLangUnk1}, '
        'nameLangUnk2: ${self.nameLangUnk2}, '
        'nameLangUnk3: ${self.nameLangUnk3}, '
        'nameLangFlags: ${self.nameLangFlags}, '
        'name1LangEnUS: ${self.name1LangEnUS}, '
        'name1LangKoKR: ${self.name1LangKoKR}, '
        'name1LangFrFR: ${self.name1LangFrFR}, '
        'name1LangDeDE: ${self.name1LangDeDE}, '
        'name1LangZhCN: ${self.name1LangZhCN}, '
        'name1LangZhTW: ${self.name1LangZhTW}, '
        'name1LangEsES: ${self.name1LangEsES}, '
        'name1LangEsMX: ${self.name1LangEsMX}, '
        'name1LangRuRU: ${self.name1LangRuRU}, '
        'name1LangJaJP: ${self.name1LangJaJP}, '
        'name1LangPtPT: ${self.name1LangPtPT}, '
        'name1LangPtBR: ${self.name1LangPtBR}, '
        'name1LangItIT: ${self.name1LangItIT}, '
        'name1LangUnk1: ${self.name1LangUnk1}, '
        'name1LangUnk2: ${self.name1LangUnk2}, '
        'name1LangUnk3: ${self.name1LangUnk3}, '
        'name1LangFlags: ${self.name1LangFlags}, '
        'maskId: ${self.maskId}'
        ')';
  }
}
