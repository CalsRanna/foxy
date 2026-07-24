// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_criteria_entity.dart';

mixin _AchievementCriteriaEntityMixin {
  static AchievementCriteriaEntity fromJson(Map<String, dynamic> json) {
    return AchievementCriteriaEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      achievementId: (json['Achievement_ID'] as num?)?.toInt() ?? 0,
      type: (json['Type'] as num?)?.toInt() ?? 0,
      assetId: (json['Asset_ID'] as num?)?.toInt() ?? 0,
      quantity: (json['Quantity'] as num?)?.toInt() ?? 0,
      startEvent: (json['Start_event'] as num?)?.toInt() ?? 0,
      startAsset: (json['Start_asset'] as num?)?.toInt() ?? 0,
      failEvent: (json['Fail_event'] as num?)?.toInt() ?? 0,
      failAsset: (json['Fail_asset'] as num?)?.toInt() ?? 0,
      descriptionLangEnUS: json['Description_lang_enUS']?.toString() ?? '',
      descriptionLangKoKR: json['Description_lang_koKR']?.toString() ?? '',
      descriptionLangFrFR: json['Description_lang_frFR']?.toString() ?? '',
      descriptionLangDeDE: json['Description_lang_deDE']?.toString() ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN']?.toString() ?? '',
      descriptionLangZhTW: json['Description_lang_zhTW']?.toString() ?? '',
      descriptionLangEsES: json['Description_lang_esES']?.toString() ?? '',
      descriptionLangEsMX: json['Description_lang_esMX']?.toString() ?? '',
      descriptionLangRuRU: json['Description_lang_ruRU']?.toString() ?? '',
      descriptionLangJaJP: json['Description_lang_jaJP']?.toString() ?? '',
      descriptionLangPtPT: json['Description_lang_ptPT']?.toString() ?? '',
      descriptionLangPtBR: json['Description_lang_ptBR']?.toString() ?? '',
      descriptionLangItIT: json['Description_lang_itIT']?.toString() ?? '',
      descriptionLangUnk1: json['Description_lang_unk1']?.toString() ?? '',
      descriptionLangUnk2: json['Description_lang_unk2']?.toString() ?? '',
      descriptionLangUnk3: json['Description_lang_unk3']?.toString() ?? '',
      descriptionLangFlags:
          (json['Description_lang_Flags'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      timerStartEvent: (json['Timer_start_event'] as num?)?.toInt() ?? 0,
      timerAssetId: (json['Timer_asset_ID'] as num?)?.toInt() ?? 0,
      timerTime: (json['Timer_time'] as num?)?.toInt() ?? 0,
      uiOrder: (json['Ui_order'] as num?)?.toInt() ?? 0,
    );
  }

  AchievementCriteriaEntity copyWith({
    int? id,
    int? achievementId,
    int? type,
    int? assetId,
    int? quantity,
    int? startEvent,
    int? startAsset,
    int? failEvent,
    int? failAsset,
    String? descriptionLangEnUS,
    String? descriptionLangKoKR,
    String? descriptionLangFrFR,
    String? descriptionLangDeDE,
    String? descriptionLangZhCN,
    String? descriptionLangZhTW,
    String? descriptionLangEsES,
    String? descriptionLangEsMX,
    String? descriptionLangRuRU,
    String? descriptionLangJaJP,
    String? descriptionLangPtPT,
    String? descriptionLangPtBR,
    String? descriptionLangItIT,
    String? descriptionLangUnk1,
    String? descriptionLangUnk2,
    String? descriptionLangUnk3,
    int? descriptionLangFlags,
    int? flags,
    int? timerStartEvent,
    int? timerAssetId,
    int? timerTime,
    int? uiOrder,
  }) {
    final self = this as AchievementCriteriaEntity;
    return AchievementCriteriaEntity(
      id: id ?? self.id,
      achievementId: achievementId ?? self.achievementId,
      type: type ?? self.type,
      assetId: assetId ?? self.assetId,
      quantity: quantity ?? self.quantity,
      startEvent: startEvent ?? self.startEvent,
      startAsset: startAsset ?? self.startAsset,
      failEvent: failEvent ?? self.failEvent,
      failAsset: failAsset ?? self.failAsset,
      descriptionLangEnUS: descriptionLangEnUS ?? self.descriptionLangEnUS,
      descriptionLangKoKR: descriptionLangKoKR ?? self.descriptionLangKoKR,
      descriptionLangFrFR: descriptionLangFrFR ?? self.descriptionLangFrFR,
      descriptionLangDeDE: descriptionLangDeDE ?? self.descriptionLangDeDE,
      descriptionLangZhCN: descriptionLangZhCN ?? self.descriptionLangZhCN,
      descriptionLangZhTW: descriptionLangZhTW ?? self.descriptionLangZhTW,
      descriptionLangEsES: descriptionLangEsES ?? self.descriptionLangEsES,
      descriptionLangEsMX: descriptionLangEsMX ?? self.descriptionLangEsMX,
      descriptionLangRuRU: descriptionLangRuRU ?? self.descriptionLangRuRU,
      descriptionLangJaJP: descriptionLangJaJP ?? self.descriptionLangJaJP,
      descriptionLangPtPT: descriptionLangPtPT ?? self.descriptionLangPtPT,
      descriptionLangPtBR: descriptionLangPtBR ?? self.descriptionLangPtBR,
      descriptionLangItIT: descriptionLangItIT ?? self.descriptionLangItIT,
      descriptionLangUnk1: descriptionLangUnk1 ?? self.descriptionLangUnk1,
      descriptionLangUnk2: descriptionLangUnk2 ?? self.descriptionLangUnk2,
      descriptionLangUnk3: descriptionLangUnk3 ?? self.descriptionLangUnk3,
      descriptionLangFlags: descriptionLangFlags ?? self.descriptionLangFlags,
      flags: flags ?? self.flags,
      timerStartEvent: timerStartEvent ?? self.timerStartEvent,
      timerAssetId: timerAssetId ?? self.timerAssetId,
      timerTime: timerTime ?? self.timerTime,
      uiOrder: uiOrder ?? self.uiOrder,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as AchievementCriteriaEntity;
    return {
      'ID': self.id,
      'Achievement_ID': self.achievementId,
      'Type': self.type,
      'Asset_ID': self.assetId,
      'Quantity': self.quantity,
      'Start_event': self.startEvent,
      'Start_asset': self.startAsset,
      'Fail_event': self.failEvent,
      'Fail_asset': self.failAsset,
      'Description_lang_enUS': self.descriptionLangEnUS,
      'Description_lang_koKR': self.descriptionLangKoKR,
      'Description_lang_frFR': self.descriptionLangFrFR,
      'Description_lang_deDE': self.descriptionLangDeDE,
      'Description_lang_zhCN': self.descriptionLangZhCN,
      'Description_lang_zhTW': self.descriptionLangZhTW,
      'Description_lang_esES': self.descriptionLangEsES,
      'Description_lang_esMX': self.descriptionLangEsMX,
      'Description_lang_ruRU': self.descriptionLangRuRU,
      'Description_lang_jaJP': self.descriptionLangJaJP,
      'Description_lang_ptPT': self.descriptionLangPtPT,
      'Description_lang_ptBR': self.descriptionLangPtBR,
      'Description_lang_itIT': self.descriptionLangItIT,
      'Description_lang_unk1': self.descriptionLangUnk1,
      'Description_lang_unk2': self.descriptionLangUnk2,
      'Description_lang_unk3': self.descriptionLangUnk3,
      'Description_lang_Flags': self.descriptionLangFlags,
      'Flags': self.flags,
      'Timer_start_event': self.timerStartEvent,
      'Timer_asset_ID': self.timerAssetId,
      'Timer_time': self.timerTime,
      'Ui_order': self.uiOrder,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as AchievementCriteriaEntity;
    return identical(self, other) ||
        other is AchievementCriteriaEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.achievementId == other.achievementId &&
            self.type == other.type &&
            self.assetId == other.assetId &&
            self.quantity == other.quantity &&
            self.startEvent == other.startEvent &&
            self.startAsset == other.startAsset &&
            self.failEvent == other.failEvent &&
            self.failAsset == other.failAsset &&
            self.descriptionLangEnUS == other.descriptionLangEnUS &&
            self.descriptionLangKoKR == other.descriptionLangKoKR &&
            self.descriptionLangFrFR == other.descriptionLangFrFR &&
            self.descriptionLangDeDE == other.descriptionLangDeDE &&
            self.descriptionLangZhCN == other.descriptionLangZhCN &&
            self.descriptionLangZhTW == other.descriptionLangZhTW &&
            self.descriptionLangEsES == other.descriptionLangEsES &&
            self.descriptionLangEsMX == other.descriptionLangEsMX &&
            self.descriptionLangRuRU == other.descriptionLangRuRU &&
            self.descriptionLangJaJP == other.descriptionLangJaJP &&
            self.descriptionLangPtPT == other.descriptionLangPtPT &&
            self.descriptionLangPtBR == other.descriptionLangPtBR &&
            self.descriptionLangItIT == other.descriptionLangItIT &&
            self.descriptionLangUnk1 == other.descriptionLangUnk1 &&
            self.descriptionLangUnk2 == other.descriptionLangUnk2 &&
            self.descriptionLangUnk3 == other.descriptionLangUnk3 &&
            self.descriptionLangFlags == other.descriptionLangFlags &&
            self.flags == other.flags &&
            self.timerStartEvent == other.timerStartEvent &&
            self.timerAssetId == other.timerAssetId &&
            self.timerTime == other.timerTime &&
            self.uiOrder == other.uiOrder;
  }

  @override
  int get hashCode {
    final self = this as AchievementCriteriaEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.achievementId,
      self.type,
      self.assetId,
      self.quantity,
      self.startEvent,
      self.startAsset,
      self.failEvent,
      self.failAsset,
      self.descriptionLangEnUS,
      self.descriptionLangKoKR,
      self.descriptionLangFrFR,
      self.descriptionLangDeDE,
      self.descriptionLangZhCN,
      self.descriptionLangZhTW,
      self.descriptionLangEsES,
      self.descriptionLangEsMX,
      self.descriptionLangRuRU,
      self.descriptionLangJaJP,
      self.descriptionLangPtPT,
      self.descriptionLangPtBR,
      self.descriptionLangItIT,
      self.descriptionLangUnk1,
      self.descriptionLangUnk2,
      self.descriptionLangUnk3,
      self.descriptionLangFlags,
      self.flags,
      self.timerStartEvent,
      self.timerAssetId,
      self.timerTime,
      self.uiOrder,
    ]);
  }

  @override
  String toString() {
    final self = this as AchievementCriteriaEntity;
    return 'AchievementCriteriaEntity('
        'id: ${self.id}, '
        'achievementId: ${self.achievementId}, '
        'type: ${self.type}, '
        'assetId: ${self.assetId}, '
        'quantity: ${self.quantity}, '
        'startEvent: ${self.startEvent}, '
        'startAsset: ${self.startAsset}, '
        'failEvent: ${self.failEvent}, '
        'failAsset: ${self.failAsset}, '
        'descriptionLangEnUS: ${self.descriptionLangEnUS}, '
        'descriptionLangKoKR: ${self.descriptionLangKoKR}, '
        'descriptionLangFrFR: ${self.descriptionLangFrFR}, '
        'descriptionLangDeDE: ${self.descriptionLangDeDE}, '
        'descriptionLangZhCN: ${self.descriptionLangZhCN}, '
        'descriptionLangZhTW: ${self.descriptionLangZhTW}, '
        'descriptionLangEsES: ${self.descriptionLangEsES}, '
        'descriptionLangEsMX: ${self.descriptionLangEsMX}, '
        'descriptionLangRuRU: ${self.descriptionLangRuRU}, '
        'descriptionLangJaJP: ${self.descriptionLangJaJP}, '
        'descriptionLangPtPT: ${self.descriptionLangPtPT}, '
        'descriptionLangPtBR: ${self.descriptionLangPtBR}, '
        'descriptionLangItIT: ${self.descriptionLangItIT}, '
        'descriptionLangUnk1: ${self.descriptionLangUnk1}, '
        'descriptionLangUnk2: ${self.descriptionLangUnk2}, '
        'descriptionLangUnk3: ${self.descriptionLangUnk3}, '
        'descriptionLangFlags: ${self.descriptionLangFlags}, '
        'flags: ${self.flags}, '
        'timerStartEvent: ${self.timerStartEvent}, '
        'timerAssetId: ${self.timerAssetId}, '
        'timerTime: ${self.timerTime}, '
        'uiOrder: ${self.uiOrder}'
        ')';
  }
}
