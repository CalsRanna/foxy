// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_info_entity.dart';

mixin _QuestInfoEntityMixin {
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
    final self = this as QuestInfoEntity;
    return QuestInfoEntity(
      id: id ?? self.id,
      infoNameLangEnUS: infoNameLangEnUS ?? self.infoNameLangEnUS,
      infoNameLangKoKR: infoNameLangKoKR ?? self.infoNameLangKoKR,
      infoNameLangFrFR: infoNameLangFrFR ?? self.infoNameLangFrFR,
      infoNameLangDeDE: infoNameLangDeDE ?? self.infoNameLangDeDE,
      infoNameLangZhCN: infoNameLangZhCN ?? self.infoNameLangZhCN,
      infoNameLangZhTW: infoNameLangZhTW ?? self.infoNameLangZhTW,
      infoNameLangEsES: infoNameLangEsES ?? self.infoNameLangEsES,
      infoNameLangEsMX: infoNameLangEsMX ?? self.infoNameLangEsMX,
      infoNameLangRuRU: infoNameLangRuRU ?? self.infoNameLangRuRU,
      infoNameLangJaJP: infoNameLangJaJP ?? self.infoNameLangJaJP,
      infoNameLangPtPT: infoNameLangPtPT ?? self.infoNameLangPtPT,
      infoNameLangPtBR: infoNameLangPtBR ?? self.infoNameLangPtBR,
      infoNameLangItIT: infoNameLangItIT ?? self.infoNameLangItIT,
      infoNameLangUnk1: infoNameLangUnk1 ?? self.infoNameLangUnk1,
      infoNameLangUnk2: infoNameLangUnk2 ?? self.infoNameLangUnk2,
      infoNameLangUnk3: infoNameLangUnk3 ?? self.infoNameLangUnk3,
      infoNameLangFlags: infoNameLangFlags ?? self.infoNameLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestInfoEntity;
    return {
      'ID': self.id,
      'InfoName_lang_enUS': self.infoNameLangEnUS,
      'InfoName_lang_koKR': self.infoNameLangKoKR,
      'InfoName_lang_frFR': self.infoNameLangFrFR,
      'InfoName_lang_deDE': self.infoNameLangDeDE,
      'InfoName_lang_zhCN': self.infoNameLangZhCN,
      'InfoName_lang_zhTW': self.infoNameLangZhTW,
      'InfoName_lang_esES': self.infoNameLangEsES,
      'InfoName_lang_esMX': self.infoNameLangEsMX,
      'InfoName_lang_ruRU': self.infoNameLangRuRU,
      'InfoName_lang_jaJP': self.infoNameLangJaJP,
      'InfoName_lang_ptPT': self.infoNameLangPtPT,
      'InfoName_lang_ptBR': self.infoNameLangPtBR,
      'InfoName_lang_itIT': self.infoNameLangItIT,
      'InfoName_lang_unk1': self.infoNameLangUnk1,
      'InfoName_lang_unk2': self.infoNameLangUnk2,
      'InfoName_lang_unk3': self.infoNameLangUnk3,
      'InfoName_lang_Flags': self.infoNameLangFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestInfoEntity;
    return identical(self, other) ||
        other is QuestInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.infoNameLangEnUS == other.infoNameLangEnUS &&
            self.infoNameLangKoKR == other.infoNameLangKoKR &&
            self.infoNameLangFrFR == other.infoNameLangFrFR &&
            self.infoNameLangDeDE == other.infoNameLangDeDE &&
            self.infoNameLangZhCN == other.infoNameLangZhCN &&
            self.infoNameLangZhTW == other.infoNameLangZhTW &&
            self.infoNameLangEsES == other.infoNameLangEsES &&
            self.infoNameLangEsMX == other.infoNameLangEsMX &&
            self.infoNameLangRuRU == other.infoNameLangRuRU &&
            self.infoNameLangJaJP == other.infoNameLangJaJP &&
            self.infoNameLangPtPT == other.infoNameLangPtPT &&
            self.infoNameLangPtBR == other.infoNameLangPtBR &&
            self.infoNameLangItIT == other.infoNameLangItIT &&
            self.infoNameLangUnk1 == other.infoNameLangUnk1 &&
            self.infoNameLangUnk2 == other.infoNameLangUnk2 &&
            self.infoNameLangUnk3 == other.infoNameLangUnk3 &&
            self.infoNameLangFlags == other.infoNameLangFlags;
  }

  @override
  int get hashCode {
    final self = this as QuestInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.infoNameLangEnUS,
      self.infoNameLangKoKR,
      self.infoNameLangFrFR,
      self.infoNameLangDeDE,
      self.infoNameLangZhCN,
      self.infoNameLangZhTW,
      self.infoNameLangEsES,
      self.infoNameLangEsMX,
      self.infoNameLangRuRU,
      self.infoNameLangJaJP,
      self.infoNameLangPtPT,
      self.infoNameLangPtBR,
      self.infoNameLangItIT,
      self.infoNameLangUnk1,
      self.infoNameLangUnk2,
      self.infoNameLangUnk3,
      self.infoNameLangFlags,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestInfoEntity;
    return 'QuestInfoEntity('
        'id: ${self.id}, '
        'infoNameLangEnUS: ${self.infoNameLangEnUS}, '
        'infoNameLangKoKR: ${self.infoNameLangKoKR}, '
        'infoNameLangFrFR: ${self.infoNameLangFrFR}, '
        'infoNameLangDeDE: ${self.infoNameLangDeDE}, '
        'infoNameLangZhCN: ${self.infoNameLangZhCN}, '
        'infoNameLangZhTW: ${self.infoNameLangZhTW}, '
        'infoNameLangEsES: ${self.infoNameLangEsES}, '
        'infoNameLangEsMX: ${self.infoNameLangEsMX}, '
        'infoNameLangRuRU: ${self.infoNameLangRuRU}, '
        'infoNameLangJaJP: ${self.infoNameLangJaJP}, '
        'infoNameLangPtPT: ${self.infoNameLangPtPT}, '
        'infoNameLangPtBR: ${self.infoNameLangPtBR}, '
        'infoNameLangItIT: ${self.infoNameLangItIT}, '
        'infoNameLangUnk1: ${self.infoNameLangUnk1}, '
        'infoNameLangUnk2: ${self.infoNameLangUnk2}, '
        'infoNameLangUnk3: ${self.infoNameLangUnk3}, '
        'infoNameLangFlags: ${self.infoNameLangFlags}'
        ')';
  }
}

final class BriefQuestInfoEntity {
  final int id;
  final String infoNameLangZhCN;

  const BriefQuestInfoEntity({this.id = 0, this.infoNameLangZhCN = ''});

  factory BriefQuestInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      infoNameLangZhCN: json['InfoName_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
