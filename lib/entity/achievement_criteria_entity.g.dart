// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_criteria_entity.dart';

mixin _AchievementCriteriaEntityMixin {
  int get id;
  int get achievementId;
  int get type;
  int get assetId;
  int get quantity;
  int get startEvent;
  int get startAsset;
  int get failEvent;
  int get failAsset;
  String get descriptionLangEnUS;
  String get descriptionLangKoKR;
  String get descriptionLangFrFR;
  String get descriptionLangDeDE;
  String get descriptionLangZhCN;
  String get descriptionLangZhTW;
  String get descriptionLangEsES;
  String get descriptionLangEsMX;
  String get descriptionLangRuRU;
  String get descriptionLangJaJP;
  String get descriptionLangPtPT;
  String get descriptionLangPtBR;
  String get descriptionLangItIT;
  String get descriptionLangUnk1;
  String get descriptionLangUnk2;
  String get descriptionLangUnk3;
  int get descriptionLangFlags;
  int get flags;
  int get timerStartEvent;
  int get timerAssetId;
  int get timerTime;
  int get uiOrder;

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
    return AchievementCriteriaEntity(
      id: id ?? this.id,
      achievementId: achievementId ?? this.achievementId,
      type: type ?? this.type,
      assetId: assetId ?? this.assetId,
      quantity: quantity ?? this.quantity,
      startEvent: startEvent ?? this.startEvent,
      startAsset: startAsset ?? this.startAsset,
      failEvent: failEvent ?? this.failEvent,
      failAsset: failAsset ?? this.failAsset,
      descriptionLangEnUS: descriptionLangEnUS ?? this.descriptionLangEnUS,
      descriptionLangKoKR: descriptionLangKoKR ?? this.descriptionLangKoKR,
      descriptionLangFrFR: descriptionLangFrFR ?? this.descriptionLangFrFR,
      descriptionLangDeDE: descriptionLangDeDE ?? this.descriptionLangDeDE,
      descriptionLangZhCN: descriptionLangZhCN ?? this.descriptionLangZhCN,
      descriptionLangZhTW: descriptionLangZhTW ?? this.descriptionLangZhTW,
      descriptionLangEsES: descriptionLangEsES ?? this.descriptionLangEsES,
      descriptionLangEsMX: descriptionLangEsMX ?? this.descriptionLangEsMX,
      descriptionLangRuRU: descriptionLangRuRU ?? this.descriptionLangRuRU,
      descriptionLangJaJP: descriptionLangJaJP ?? this.descriptionLangJaJP,
      descriptionLangPtPT: descriptionLangPtPT ?? this.descriptionLangPtPT,
      descriptionLangPtBR: descriptionLangPtBR ?? this.descriptionLangPtBR,
      descriptionLangItIT: descriptionLangItIT ?? this.descriptionLangItIT,
      descriptionLangUnk1: descriptionLangUnk1 ?? this.descriptionLangUnk1,
      descriptionLangUnk2: descriptionLangUnk2 ?? this.descriptionLangUnk2,
      descriptionLangUnk3: descriptionLangUnk3 ?? this.descriptionLangUnk3,
      descriptionLangFlags: descriptionLangFlags ?? this.descriptionLangFlags,
      flags: flags ?? this.flags,
      timerStartEvent: timerStartEvent ?? this.timerStartEvent,
      timerAssetId: timerAssetId ?? this.timerAssetId,
      timerTime: timerTime ?? this.timerTime,
      uiOrder: uiOrder ?? this.uiOrder,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Achievement_ID': achievementId,
      'Type': type,
      'Asset_ID': assetId,
      'Quantity': quantity,
      'Start_event': startEvent,
      'Start_asset': startAsset,
      'Fail_event': failEvent,
      'Fail_asset': failAsset,
      'Description_lang_enUS': descriptionLangEnUS,
      'Description_lang_koKR': descriptionLangKoKR,
      'Description_lang_frFR': descriptionLangFrFR,
      'Description_lang_deDE': descriptionLangDeDE,
      'Description_lang_zhCN': descriptionLangZhCN,
      'Description_lang_zhTW': descriptionLangZhTW,
      'Description_lang_esES': descriptionLangEsES,
      'Description_lang_esMX': descriptionLangEsMX,
      'Description_lang_ruRU': descriptionLangRuRU,
      'Description_lang_jaJP': descriptionLangJaJP,
      'Description_lang_ptPT': descriptionLangPtPT,
      'Description_lang_ptBR': descriptionLangPtBR,
      'Description_lang_itIT': descriptionLangItIT,
      'Description_lang_unk1': descriptionLangUnk1,
      'Description_lang_unk2': descriptionLangUnk2,
      'Description_lang_unk3': descriptionLangUnk3,
      'Description_lang_Flags': descriptionLangFlags,
      'Flags': flags,
      'Timer_start_event': timerStartEvent,
      'Timer_asset_ID': timerAssetId,
      'Timer_time': timerTime,
      'Ui_order': uiOrder,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AchievementCriteriaEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            achievementId == other.achievementId &&
            type == other.type &&
            assetId == other.assetId &&
            quantity == other.quantity &&
            startEvent == other.startEvent &&
            startAsset == other.startAsset &&
            failEvent == other.failEvent &&
            failAsset == other.failAsset &&
            descriptionLangEnUS == other.descriptionLangEnUS &&
            descriptionLangKoKR == other.descriptionLangKoKR &&
            descriptionLangFrFR == other.descriptionLangFrFR &&
            descriptionLangDeDE == other.descriptionLangDeDE &&
            descriptionLangZhCN == other.descriptionLangZhCN &&
            descriptionLangZhTW == other.descriptionLangZhTW &&
            descriptionLangEsES == other.descriptionLangEsES &&
            descriptionLangEsMX == other.descriptionLangEsMX &&
            descriptionLangRuRU == other.descriptionLangRuRU &&
            descriptionLangJaJP == other.descriptionLangJaJP &&
            descriptionLangPtPT == other.descriptionLangPtPT &&
            descriptionLangPtBR == other.descriptionLangPtBR &&
            descriptionLangItIT == other.descriptionLangItIT &&
            descriptionLangUnk1 == other.descriptionLangUnk1 &&
            descriptionLangUnk2 == other.descriptionLangUnk2 &&
            descriptionLangUnk3 == other.descriptionLangUnk3 &&
            descriptionLangFlags == other.descriptionLangFlags &&
            flags == other.flags &&
            timerStartEvent == other.timerStartEvent &&
            timerAssetId == other.timerAssetId &&
            timerTime == other.timerTime &&
            uiOrder == other.uiOrder;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      achievementId,
      type,
      assetId,
      quantity,
      startEvent,
      startAsset,
      failEvent,
      failAsset,
      descriptionLangEnUS,
      descriptionLangKoKR,
      descriptionLangFrFR,
      descriptionLangDeDE,
      descriptionLangZhCN,
      descriptionLangZhTW,
      descriptionLangEsES,
      descriptionLangEsMX,
      descriptionLangRuRU,
      descriptionLangJaJP,
      descriptionLangPtPT,
      descriptionLangPtBR,
      descriptionLangItIT,
      descriptionLangUnk1,
      descriptionLangUnk2,
      descriptionLangUnk3,
      descriptionLangFlags,
      flags,
      timerStartEvent,
      timerAssetId,
      timerTime,
      uiOrder,
    ]);
  }

  @override
  String toString() {
    return 'AchievementCriteriaEntity('
        'id: $id, '
        'achievementId: $achievementId, '
        'type: $type, '
        'assetId: $assetId, '
        'quantity: $quantity, '
        'startEvent: $startEvent, '
        'startAsset: $startAsset, '
        'failEvent: $failEvent, '
        'failAsset: $failAsset, '
        'descriptionLangEnUS: $descriptionLangEnUS, '
        'descriptionLangKoKR: $descriptionLangKoKR, '
        'descriptionLangFrFR: $descriptionLangFrFR, '
        'descriptionLangDeDE: $descriptionLangDeDE, '
        'descriptionLangZhCN: $descriptionLangZhCN, '
        'descriptionLangZhTW: $descriptionLangZhTW, '
        'descriptionLangEsES: $descriptionLangEsES, '
        'descriptionLangEsMX: $descriptionLangEsMX, '
        'descriptionLangRuRU: $descriptionLangRuRU, '
        'descriptionLangJaJP: $descriptionLangJaJP, '
        'descriptionLangPtPT: $descriptionLangPtPT, '
        'descriptionLangPtBR: $descriptionLangPtBR, '
        'descriptionLangItIT: $descriptionLangItIT, '
        'descriptionLangUnk1: $descriptionLangUnk1, '
        'descriptionLangUnk2: $descriptionLangUnk2, '
        'descriptionLangUnk3: $descriptionLangUnk3, '
        'descriptionLangFlags: $descriptionLangFlags, '
        'flags: $flags, '
        'timerStartEvent: $timerStartEvent, '
        'timerAssetId: $timerAssetId, '
        'timerTime: $timerTime, '
        'uiOrder: $uiOrder'
        ')';
  }
}
