class AreaTable {
  int id = 0;
  int continentId = 0;
  int parentAreaId = 0;
  int areaBit = 0;
  int flags = 0;
  int soundProviderPref = 0;
  int soundProviderPrefUnderwater = 0;
  int ambienceId = 0;
  int zoneMusic = 0;
  int introSound = 0;
  int explorationLevel = 0;
  String areaNameLangZhCn = '';
  int factionGroupMask = 0;
  int liquidTypeId0 = 0;
  int liquidTypeId1 = 0;
  int liquidTypeId2 = 0;
  int liquidTypeId3 = 0;
  double minElevation = 0.0;
  double ambientMultiplier = 0.0;
  int lightId = 0;

  AreaTable();

  AreaTable.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    continentId = json['ContinentID'] ?? 0;
    parentAreaId = json['ParentAreaID'] ?? 0;
    areaBit = json['AreaBit'] ?? 0;
    flags = json['Flags'] ?? 0;
    soundProviderPref = json['SoundProviderPref'] ?? 0;
    soundProviderPrefUnderwater = json['SoundProviderPrefUnderwater'] ?? 0;
    ambienceId = json['AmbienceID'] ?? 0;
    zoneMusic = json['ZoneMusic'] ?? 0;
    introSound = json['IntroSound'] ?? 0;
    explorationLevel = json['ExplorationLevel'] ?? 0;
    areaNameLangZhCn = json['AreaName_lang_zhCN'] ?? '';
    factionGroupMask = json['FactionGroupMask'] ?? 0;
    liquidTypeId0 = json['LiquidTypeID0'] ?? 0;
    liquidTypeId1 = json['LiquidTypeID1'] ?? 0;
    liquidTypeId2 = json['LiquidTypeID2'] ?? 0;
    liquidTypeId3 = json['LiquidTypeID3'] ?? 0;
    minElevation = (json['MinElevation'] as num?)?.toDouble() ?? 0.0;
    ambientMultiplier = (json['Ambient_multiplier'] as num?)?.toDouble() ?? 0.0;
    lightId = json['LightID'] ?? 0;
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
      'AreaName_lang_zhCN': areaNameLangZhCn,
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
}

class BriefAreaTable {
  int id = 0;
  String areaNameLangZhCn = '';
  int continentId = 0;
  double minElevation = 0.0;
  int zoneMusic = 0;
  int explorationLevel = 0;

  BriefAreaTable();

  BriefAreaTable.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    areaNameLangZhCn = json['AreaName_lang_zhCN'] ?? '';
    continentId = json['ContinentID'] ?? 0;
    minElevation = (json['MinElevation'] as num?)?.toDouble() ?? 0.0;
    zoneMusic = json['ZoneMusic'] ?? 0;
    explorationLevel = json['ExplorationLevel'] ?? 0;
  }
}
