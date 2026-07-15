class AreaTableEntity {
  final int id;
  final int continentId;
  final int parentAreaId;
  final int areaBit;
  final int flags;
  final int soundProviderPref;
  final int soundProviderPrefUnderwater;
  final int ambienceId;
  final int zoneMusic;
  final int introSound;
  final int explorationLevel;
  final String areaNameLangEnUS;
  final String areaNameLangKoKR;
  final String areaNameLangFrFR;
  final String areaNameLangDeDE;
  final String areaNameLangZhCN;
  final String areaNameLangZhTW;
  final String areaNameLangEsES;
  final String areaNameLangEsMX;
  final String areaNameLangRuRU;
  final String areaNameLangJaJP;
  final String areaNameLangPtPT;
  final String areaNameLangPtBR;
  final String areaNameLangItIT;
  final String areaNameLangUnk1;
  final String areaNameLangUnk2;
  final String areaNameLangUnk3;
  final int areaNameLangFlags;
  final int factionGroupMask;
  final int liquidTypeId0;
  final int liquidTypeId1;
  final int liquidTypeId2;
  final int liquidTypeId3;
  final double minElevation;
  final double ambientMultiplier;
  final int lightId;

  const AreaTableEntity({
    this.id = 0,
    this.continentId = 0,
    this.parentAreaId = 0,
    this.areaBit = 0,
    this.flags = 0,
    this.soundProviderPref = 0,
    this.soundProviderPrefUnderwater = 0,
    this.ambienceId = 0,
    this.zoneMusic = 0,
    this.introSound = 0,
    this.explorationLevel = 0,
    this.areaNameLangEnUS = '',
    this.areaNameLangKoKR = '',
    this.areaNameLangFrFR = '',
    this.areaNameLangDeDE = '',
    this.areaNameLangZhCN = '',
    this.areaNameLangZhTW = '',
    this.areaNameLangEsES = '',
    this.areaNameLangEsMX = '',
    this.areaNameLangRuRU = '',
    this.areaNameLangJaJP = '',
    this.areaNameLangPtPT = '',
    this.areaNameLangPtBR = '',
    this.areaNameLangItIT = '',
    this.areaNameLangUnk1 = '',
    this.areaNameLangUnk2 = '',
    this.areaNameLangUnk3 = '',
    this.areaNameLangFlags = 0,
    this.factionGroupMask = 0,
    this.liquidTypeId0 = 0,
    this.liquidTypeId1 = 0,
    this.liquidTypeId2 = 0,
    this.liquidTypeId3 = 0,
    this.minElevation = 0.0,
    this.ambientMultiplier = 0.0,
    this.lightId = 0,
  });

  factory AreaTableEntity.fromJson(Map<String, dynamic> json) {
    return AreaTableEntity(
      id: json['ID'] ?? 0,
      continentId: json['ContinentID'] ?? 0,
      parentAreaId: json['ParentAreaID'] ?? 0,
      areaBit: json['AreaBit'] ?? 0,
      flags: json['Flags'] ?? 0,
      soundProviderPref: json['SoundProviderPref'] ?? 0,
      soundProviderPrefUnderwater: json['SoundProviderPrefUnderwater'] ?? 0,
      ambienceId: json['AmbienceID'] ?? 0,
      zoneMusic: json['ZoneMusic'] ?? 0,
      introSound: json['IntroSound'] ?? 0,
      explorationLevel: json['ExplorationLevel'] ?? 0,
      areaNameLangEnUS: json['AreaName_lang_enUS'] ?? '',
      areaNameLangKoKR: json['AreaName_lang_koKR'] ?? '',
      areaNameLangFrFR: json['AreaName_lang_frFR'] ?? '',
      areaNameLangDeDE: json['AreaName_lang_deDE'] ?? '',
      areaNameLangZhCN: json['AreaName_lang_zhCN'] ?? '',
      areaNameLangZhTW: json['AreaName_lang_zhTW'] ?? '',
      areaNameLangEsES: json['AreaName_lang_esES'] ?? '',
      areaNameLangEsMX: json['AreaName_lang_esMX'] ?? '',
      areaNameLangRuRU: json['AreaName_lang_ruRU'] ?? '',
      areaNameLangJaJP: json['AreaName_lang_jaJP'] ?? '',
      areaNameLangPtPT: json['AreaName_lang_ptPT'] ?? '',
      areaNameLangPtBR: json['AreaName_lang_ptBR'] ?? '',
      areaNameLangItIT: json['AreaName_lang_itIT'] ?? '',
      areaNameLangUnk1: json['AreaName_lang_unk1'] ?? '',
      areaNameLangUnk2: json['AreaName_lang_unk2'] ?? '',
      areaNameLangUnk3: json['AreaName_lang_unk3'] ?? '',
      areaNameLangFlags: json['AreaName_lang_Flags'] ?? 0,
      factionGroupMask: json['FactionGroupMask'] ?? 0,
      liquidTypeId0: json['LiquidTypeID0'] ?? 0,
      liquidTypeId1: json['LiquidTypeID1'] ?? 0,
      liquidTypeId2: json['LiquidTypeID2'] ?? 0,
      liquidTypeId3: json['LiquidTypeID3'] ?? 0,
      minElevation: (json['MinElevation'] as num?)?.toDouble() ?? 0.0,
      ambientMultiplier:
          (json['Ambient_multiplier'] as num?)?.toDouble() ?? 0.0,
      lightId: json['LightID'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ContinentID': continentId,
      'ParentAreaID': parentAreaId,
      'AreaBit': areaBit,
      'Flags': flags,
      'SoundProviderPref': soundProviderPref,
      'SoundProviderPrefUnderwater': soundProviderPrefUnderwater,
      'AmbienceID': ambienceId,
      'ZoneMusic': zoneMusic,
      'IntroSound': introSound,
      'ExplorationLevel': explorationLevel,
      'AreaName_lang_enUS': areaNameLangEnUS,
      'AreaName_lang_koKR': areaNameLangKoKR,
      'AreaName_lang_frFR': areaNameLangFrFR,
      'AreaName_lang_deDE': areaNameLangDeDE,
      'AreaName_lang_zhCN': areaNameLangZhCN,
      'AreaName_lang_zhTW': areaNameLangZhTW,
      'AreaName_lang_esES': areaNameLangEsES,
      'AreaName_lang_esMX': areaNameLangEsMX,
      'AreaName_lang_ruRU': areaNameLangRuRU,
      'AreaName_lang_jaJP': areaNameLangJaJP,
      'AreaName_lang_ptPT': areaNameLangPtPT,
      'AreaName_lang_ptBR': areaNameLangPtBR,
      'AreaName_lang_itIT': areaNameLangItIT,
      'AreaName_lang_unk1': areaNameLangUnk1,
      'AreaName_lang_unk2': areaNameLangUnk2,
      'AreaName_lang_unk3': areaNameLangUnk3,
      'AreaName_lang_Flags': areaNameLangFlags,
      'FactionGroupMask': factionGroupMask,
      'LiquidTypeID0': liquidTypeId0,
      'LiquidTypeID1': liquidTypeId1,
      'LiquidTypeID2': liquidTypeId2,
      'LiquidTypeID3': liquidTypeId3,
      'MinElevation': minElevation,
      'Ambient_multiplier': ambientMultiplier,
      'LightID': lightId,
    };
  }

  AreaTableEntity copyWith({
    int? id,
    int? continentId,
    int? parentAreaId,
    int? areaBit,
    int? flags,
    int? soundProviderPref,
    int? soundProviderPrefUnderwater,
    int? ambienceId,
    int? zoneMusic,
    int? introSound,
    int? explorationLevel,
    String? areaNameLangEnUS,
    String? areaNameLangKoKR,
    String? areaNameLangFrFR,
    String? areaNameLangDeDE,
    String? areaNameLangZhCN,
    String? areaNameLangZhTW,
    String? areaNameLangEsES,
    String? areaNameLangEsMX,
    String? areaNameLangRuRU,
    String? areaNameLangJaJP,
    String? areaNameLangPtPT,
    String? areaNameLangPtBR,
    String? areaNameLangItIT,
    String? areaNameLangUnk1,
    String? areaNameLangUnk2,
    String? areaNameLangUnk3,
    int? areaNameLangFlags,
    int? factionGroupMask,
    int? liquidTypeId0,
    int? liquidTypeId1,
    int? liquidTypeId2,
    int? liquidTypeId3,
    double? minElevation,
    double? ambientMultiplier,
    int? lightId,
  }) {
    return AreaTableEntity(
      id: id ?? this.id,
      continentId: continentId ?? this.continentId,
      parentAreaId: parentAreaId ?? this.parentAreaId,
      areaBit: areaBit ?? this.areaBit,
      flags: flags ?? this.flags,
      soundProviderPref: soundProviderPref ?? this.soundProviderPref,
      soundProviderPrefUnderwater:
          soundProviderPrefUnderwater ?? this.soundProviderPrefUnderwater,
      ambienceId: ambienceId ?? this.ambienceId,
      zoneMusic: zoneMusic ?? this.zoneMusic,
      introSound: introSound ?? this.introSound,
      explorationLevel: explorationLevel ?? this.explorationLevel,
      areaNameLangEnUS: areaNameLangEnUS ?? this.areaNameLangEnUS,
      areaNameLangKoKR: areaNameLangKoKR ?? this.areaNameLangKoKR,
      areaNameLangFrFR: areaNameLangFrFR ?? this.areaNameLangFrFR,
      areaNameLangDeDE: areaNameLangDeDE ?? this.areaNameLangDeDE,
      areaNameLangZhCN: areaNameLangZhCN ?? this.areaNameLangZhCN,
      areaNameLangZhTW: areaNameLangZhTW ?? this.areaNameLangZhTW,
      areaNameLangEsES: areaNameLangEsES ?? this.areaNameLangEsES,
      areaNameLangEsMX: areaNameLangEsMX ?? this.areaNameLangEsMX,
      areaNameLangRuRU: areaNameLangRuRU ?? this.areaNameLangRuRU,
      areaNameLangJaJP: areaNameLangJaJP ?? this.areaNameLangJaJP,
      areaNameLangPtPT: areaNameLangPtPT ?? this.areaNameLangPtPT,
      areaNameLangPtBR: areaNameLangPtBR ?? this.areaNameLangPtBR,
      areaNameLangItIT: areaNameLangItIT ?? this.areaNameLangItIT,
      areaNameLangUnk1: areaNameLangUnk1 ?? this.areaNameLangUnk1,
      areaNameLangUnk2: areaNameLangUnk2 ?? this.areaNameLangUnk2,
      areaNameLangUnk3: areaNameLangUnk3 ?? this.areaNameLangUnk3,
      areaNameLangFlags: areaNameLangFlags ?? this.areaNameLangFlags,
      factionGroupMask: factionGroupMask ?? this.factionGroupMask,
      liquidTypeId0: liquidTypeId0 ?? this.liquidTypeId0,
      liquidTypeId1: liquidTypeId1 ?? this.liquidTypeId1,
      liquidTypeId2: liquidTypeId2 ?? this.liquidTypeId2,
      liquidTypeId3: liquidTypeId3 ?? this.liquidTypeId3,
      minElevation: minElevation ?? this.minElevation,
      ambientMultiplier: ambientMultiplier ?? this.ambientMultiplier,
      lightId: lightId ?? this.lightId,
    );
  }
}

class BriefAreaTableEntity {
  final int id;
  final String areaNameLangZhCN;
  final int continentId;
  final double minElevation;
  final int zoneMusic;
  final int explorationLevel;

  const BriefAreaTableEntity({
    this.id = 0,
    this.areaNameLangZhCN = '',
    this.continentId = 0,
    this.minElevation = 0.0,
    this.zoneMusic = 0,
    this.explorationLevel = 0,
  });

  factory BriefAreaTableEntity.fromJson(Map<String, dynamic> json) {
    return BriefAreaTableEntity(
      id: json['ID'] ?? 0,
      areaNameLangZhCN: json['AreaName_lang_zhCN'] ?? '',
      continentId: json['ContinentID'] ?? 0,
      minElevation: (json['MinElevation'] as num?)?.toDouble() ?? 0.0,
      zoneMusic: json['ZoneMusic'] ?? 0,
      explorationLevel: json['ExplorationLevel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'AreaName_lang_zhCN': areaNameLangZhCN,
      'ContinentID': continentId,
      'MinElevation': minElevation,
      'ZoneMusic': zoneMusic,
      'ExplorationLevel': explorationLevel,
    };
  }

  BriefAreaTableEntity copyWith({
    int? id,
    String? areaNameLangZhCN,
    int? continentId,
    double? minElevation,
    int? zoneMusic,
    int? explorationLevel,
  }) {
    return BriefAreaTableEntity(
      id: id ?? this.id,
      areaNameLangZhCN: areaNameLangZhCN ?? this.areaNameLangZhCN,
      continentId: continentId ?? this.continentId,
      minElevation: minElevation ?? this.minElevation,
      zoneMusic: zoneMusic ?? this.zoneMusic,
      explorationLevel: explorationLevel ?? this.explorationLevel,
    );
  }
}
