class AchievementCriteriaEntity {
  final int id;
  final int achievementId;
  final int type;
  final int assetId;
  final int quantity;
  final int startEvent;
  final int startAsset;
  final int failEvent;
  final int failAsset;
  final String descriptionLangEnUS;
  final String descriptionLangKoKR;
  final String descriptionLangFrFR;
  final String descriptionLangDeDE;
  final String descriptionLangZhCN;
  final String descriptionLangZhTW;
  final String descriptionLangEsES;
  final String descriptionLangEsMX;
  final String descriptionLangRuRU;
  final String descriptionLangJaJP;
  final String descriptionLangPtPT;
  final String descriptionLangPtBR;
  final String descriptionLangItIT;
  final String descriptionLangUnk1;
  final String descriptionLangUnk2;
  final String descriptionLangUnk3;
  final int descriptionLangFlags;
  final int flags;
  final int timerStartEvent;
  final int timerAssetId;
  final int timerTime;
  final int uiOrder;

  const AchievementCriteriaEntity({
    this.id = 0,
    this.achievementId = 0,
    this.type = 0,
    this.assetId = 0,
    this.quantity = 0,
    this.startEvent = 0,
    this.startAsset = 0,
    this.failEvent = 0,
    this.failAsset = 0,
    this.descriptionLangEnUS = '',
    this.descriptionLangKoKR = '',
    this.descriptionLangFrFR = '',
    this.descriptionLangDeDE = '',
    this.descriptionLangZhCN = '',
    this.descriptionLangZhTW = '',
    this.descriptionLangEsES = '',
    this.descriptionLangEsMX = '',
    this.descriptionLangRuRU = '',
    this.descriptionLangJaJP = '',
    this.descriptionLangPtPT = '',
    this.descriptionLangPtBR = '',
    this.descriptionLangItIT = '',
    this.descriptionLangUnk1 = '',
    this.descriptionLangUnk2 = '',
    this.descriptionLangUnk3 = '',
    this.descriptionLangFlags = 0,
    this.flags = 0,
    this.timerStartEvent = 0,
    this.timerAssetId = 0,
    this.timerTime = 0,
    this.uiOrder = 0,
  });

  factory AchievementCriteriaEntity.fromJson(Map<String, dynamic> json) {
    return AchievementCriteriaEntity(
      id: json['ID'] ?? 0,
      achievementId: json['Achievement_ID'] ?? 0,
      type: json['Type'] ?? 0,
      assetId: json['Asset_ID'] ?? 0,
      quantity: json['Quantity'] ?? 0,
      startEvent: json['Start_event'] ?? 0,
      startAsset: json['Start_asset'] ?? 0,
      failEvent: json['Fail_event'] ?? 0,
      failAsset: json['Fail_asset'] ?? 0,
      descriptionLangEnUS: json['Description_lang_enUS'] ?? '',
      descriptionLangKoKR: json['Description_lang_koKR'] ?? '',
      descriptionLangFrFR: json['Description_lang_frFR'] ?? '',
      descriptionLangDeDE: json['Description_lang_deDE'] ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
      descriptionLangZhTW: json['Description_lang_zhTW'] ?? '',
      descriptionLangEsES: json['Description_lang_esES'] ?? '',
      descriptionLangEsMX: json['Description_lang_esMX'] ?? '',
      descriptionLangRuRU: json['Description_lang_ruRU'] ?? '',
      descriptionLangJaJP: json['Description_lang_jaJP'] ?? '',
      descriptionLangPtPT: json['Description_lang_ptPT'] ?? '',
      descriptionLangPtBR: json['Description_lang_ptBR'] ?? '',
      descriptionLangItIT: json['Description_lang_itIT'] ?? '',
      descriptionLangUnk1: json['Description_lang_unk1'] ?? '',
      descriptionLangUnk2: json['Description_lang_unk2'] ?? '',
      descriptionLangUnk3: json['Description_lang_unk3'] ?? '',
      descriptionLangFlags: json['Description_lang_Flags'] ?? 0,
      flags: json['Flags'] ?? 0,
      timerStartEvent: json['Timer_start_event'] ?? 0,
      timerAssetId: json['Timer_asset_ID'] ?? 0,
      timerTime: json['Timer_time'] ?? 0,
      uiOrder: json['Ui_order'] ?? 0,
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
  }) => AchievementCriteriaEntity(
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

  Map<String, dynamic> toJson() => {
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
