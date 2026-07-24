// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_table_entity.dart';

mixin _AreaTableEntityMixin {
  static AreaTableEntity fromJson(Map<String, dynamic> json) {
    return AreaTableEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      continentId: (json['ContinentID'] as num?)?.toInt() ?? 0,
      parentAreaId: (json['ParentAreaID'] as num?)?.toInt() ?? 0,
      areaBit: (json['AreaBit'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      soundProviderPref: (json['SoundProviderPref'] as num?)?.toInt() ?? 0,
      soundProviderPrefUnderwater:
          (json['SoundProviderPrefUnderwater'] as num?)?.toInt() ?? 0,
      ambienceId: (json['AmbienceID'] as num?)?.toInt() ?? 0,
      zoneMusic: (json['ZoneMusic'] as num?)?.toInt() ?? 0,
      introSound: (json['IntroSound'] as num?)?.toInt() ?? 0,
      explorationLevel: (json['ExplorationLevel'] as num?)?.toInt() ?? 0,
      areaNameLangEnUS: json['AreaName_lang_enUS']?.toString() ?? '',
      areaNameLangKoKR: json['AreaName_lang_koKR']?.toString() ?? '',
      areaNameLangFrFR: json['AreaName_lang_frFR']?.toString() ?? '',
      areaNameLangDeDE: json['AreaName_lang_deDE']?.toString() ?? '',
      areaNameLangZhCN: json['AreaName_lang_zhCN']?.toString() ?? '',
      areaNameLangZhTW: json['AreaName_lang_zhTW']?.toString() ?? '',
      areaNameLangEsES: json['AreaName_lang_esES']?.toString() ?? '',
      areaNameLangEsMX: json['AreaName_lang_esMX']?.toString() ?? '',
      areaNameLangRuRU: json['AreaName_lang_ruRU']?.toString() ?? '',
      areaNameLangJaJP: json['AreaName_lang_jaJP']?.toString() ?? '',
      areaNameLangPtPT: json['AreaName_lang_ptPT']?.toString() ?? '',
      areaNameLangPtBR: json['AreaName_lang_ptBR']?.toString() ?? '',
      areaNameLangItIT: json['AreaName_lang_itIT']?.toString() ?? '',
      areaNameLangUnk1: json['AreaName_lang_unk1']?.toString() ?? '',
      areaNameLangUnk2: json['AreaName_lang_unk2']?.toString() ?? '',
      areaNameLangUnk3: json['AreaName_lang_unk3']?.toString() ?? '',
      areaNameLangFlags: (json['AreaName_lang_Flags'] as num?)?.toInt() ?? 0,
      factionGroupMask: (json['FactionGroupMask'] as num?)?.toInt() ?? 0,
      liquidTypeId0: (json['LiquidTypeID0'] as num?)?.toInt() ?? 0,
      liquidTypeId1: (json['LiquidTypeID1'] as num?)?.toInt() ?? 0,
      liquidTypeId2: (json['LiquidTypeID2'] as num?)?.toInt() ?? 0,
      liquidTypeId3: (json['LiquidTypeID3'] as num?)?.toInt() ?? 0,
      minElevation: (json['MinElevation'] as num?)?.toDouble() ?? 0.0,
      ambientMultiplier:
          (json['Ambient_multiplier'] as num?)?.toDouble() ?? 0.0,
      lightId: (json['LightID'] as num?)?.toInt() ?? 0,
    );
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
    final self = this as AreaTableEntity;
    return AreaTableEntity(
      id: id ?? self.id,
      continentId: continentId ?? self.continentId,
      parentAreaId: parentAreaId ?? self.parentAreaId,
      areaBit: areaBit ?? self.areaBit,
      flags: flags ?? self.flags,
      soundProviderPref: soundProviderPref ?? self.soundProviderPref,
      soundProviderPrefUnderwater:
          soundProviderPrefUnderwater ?? self.soundProviderPrefUnderwater,
      ambienceId: ambienceId ?? self.ambienceId,
      zoneMusic: zoneMusic ?? self.zoneMusic,
      introSound: introSound ?? self.introSound,
      explorationLevel: explorationLevel ?? self.explorationLevel,
      areaNameLangEnUS: areaNameLangEnUS ?? self.areaNameLangEnUS,
      areaNameLangKoKR: areaNameLangKoKR ?? self.areaNameLangKoKR,
      areaNameLangFrFR: areaNameLangFrFR ?? self.areaNameLangFrFR,
      areaNameLangDeDE: areaNameLangDeDE ?? self.areaNameLangDeDE,
      areaNameLangZhCN: areaNameLangZhCN ?? self.areaNameLangZhCN,
      areaNameLangZhTW: areaNameLangZhTW ?? self.areaNameLangZhTW,
      areaNameLangEsES: areaNameLangEsES ?? self.areaNameLangEsES,
      areaNameLangEsMX: areaNameLangEsMX ?? self.areaNameLangEsMX,
      areaNameLangRuRU: areaNameLangRuRU ?? self.areaNameLangRuRU,
      areaNameLangJaJP: areaNameLangJaJP ?? self.areaNameLangJaJP,
      areaNameLangPtPT: areaNameLangPtPT ?? self.areaNameLangPtPT,
      areaNameLangPtBR: areaNameLangPtBR ?? self.areaNameLangPtBR,
      areaNameLangItIT: areaNameLangItIT ?? self.areaNameLangItIT,
      areaNameLangUnk1: areaNameLangUnk1 ?? self.areaNameLangUnk1,
      areaNameLangUnk2: areaNameLangUnk2 ?? self.areaNameLangUnk2,
      areaNameLangUnk3: areaNameLangUnk3 ?? self.areaNameLangUnk3,
      areaNameLangFlags: areaNameLangFlags ?? self.areaNameLangFlags,
      factionGroupMask: factionGroupMask ?? self.factionGroupMask,
      liquidTypeId0: liquidTypeId0 ?? self.liquidTypeId0,
      liquidTypeId1: liquidTypeId1 ?? self.liquidTypeId1,
      liquidTypeId2: liquidTypeId2 ?? self.liquidTypeId2,
      liquidTypeId3: liquidTypeId3 ?? self.liquidTypeId3,
      minElevation: minElevation ?? self.minElevation,
      ambientMultiplier: ambientMultiplier ?? self.ambientMultiplier,
      lightId: lightId ?? self.lightId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as AreaTableEntity;
    return {
      'ID': self.id,
      'ContinentID': self.continentId,
      'ParentAreaID': self.parentAreaId,
      'AreaBit': self.areaBit,
      'Flags': self.flags,
      'SoundProviderPref': self.soundProviderPref,
      'SoundProviderPrefUnderwater': self.soundProviderPrefUnderwater,
      'AmbienceID': self.ambienceId,
      'ZoneMusic': self.zoneMusic,
      'IntroSound': self.introSound,
      'ExplorationLevel': self.explorationLevel,
      'AreaName_lang_enUS': self.areaNameLangEnUS,
      'AreaName_lang_koKR': self.areaNameLangKoKR,
      'AreaName_lang_frFR': self.areaNameLangFrFR,
      'AreaName_lang_deDE': self.areaNameLangDeDE,
      'AreaName_lang_zhCN': self.areaNameLangZhCN,
      'AreaName_lang_zhTW': self.areaNameLangZhTW,
      'AreaName_lang_esES': self.areaNameLangEsES,
      'AreaName_lang_esMX': self.areaNameLangEsMX,
      'AreaName_lang_ruRU': self.areaNameLangRuRU,
      'AreaName_lang_jaJP': self.areaNameLangJaJP,
      'AreaName_lang_ptPT': self.areaNameLangPtPT,
      'AreaName_lang_ptBR': self.areaNameLangPtBR,
      'AreaName_lang_itIT': self.areaNameLangItIT,
      'AreaName_lang_unk1': self.areaNameLangUnk1,
      'AreaName_lang_unk2': self.areaNameLangUnk2,
      'AreaName_lang_unk3': self.areaNameLangUnk3,
      'AreaName_lang_Flags': self.areaNameLangFlags,
      'FactionGroupMask': self.factionGroupMask,
      'LiquidTypeID0': self.liquidTypeId0,
      'LiquidTypeID1': self.liquidTypeId1,
      'LiquidTypeID2': self.liquidTypeId2,
      'LiquidTypeID3': self.liquidTypeId3,
      'MinElevation': self.minElevation,
      'Ambient_multiplier': self.ambientMultiplier,
      'LightID': self.lightId,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as AreaTableEntity;
    return identical(self, other) ||
        other is AreaTableEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.continentId == other.continentId &&
            self.parentAreaId == other.parentAreaId &&
            self.areaBit == other.areaBit &&
            self.flags == other.flags &&
            self.soundProviderPref == other.soundProviderPref &&
            self.soundProviderPrefUnderwater ==
                other.soundProviderPrefUnderwater &&
            self.ambienceId == other.ambienceId &&
            self.zoneMusic == other.zoneMusic &&
            self.introSound == other.introSound &&
            self.explorationLevel == other.explorationLevel &&
            self.areaNameLangEnUS == other.areaNameLangEnUS &&
            self.areaNameLangKoKR == other.areaNameLangKoKR &&
            self.areaNameLangFrFR == other.areaNameLangFrFR &&
            self.areaNameLangDeDE == other.areaNameLangDeDE &&
            self.areaNameLangZhCN == other.areaNameLangZhCN &&
            self.areaNameLangZhTW == other.areaNameLangZhTW &&
            self.areaNameLangEsES == other.areaNameLangEsES &&
            self.areaNameLangEsMX == other.areaNameLangEsMX &&
            self.areaNameLangRuRU == other.areaNameLangRuRU &&
            self.areaNameLangJaJP == other.areaNameLangJaJP &&
            self.areaNameLangPtPT == other.areaNameLangPtPT &&
            self.areaNameLangPtBR == other.areaNameLangPtBR &&
            self.areaNameLangItIT == other.areaNameLangItIT &&
            self.areaNameLangUnk1 == other.areaNameLangUnk1 &&
            self.areaNameLangUnk2 == other.areaNameLangUnk2 &&
            self.areaNameLangUnk3 == other.areaNameLangUnk3 &&
            self.areaNameLangFlags == other.areaNameLangFlags &&
            self.factionGroupMask == other.factionGroupMask &&
            self.liquidTypeId0 == other.liquidTypeId0 &&
            self.liquidTypeId1 == other.liquidTypeId1 &&
            self.liquidTypeId2 == other.liquidTypeId2 &&
            self.liquidTypeId3 == other.liquidTypeId3 &&
            self.minElevation == other.minElevation &&
            self.ambientMultiplier == other.ambientMultiplier &&
            self.lightId == other.lightId;
  }

  @override
  int get hashCode {
    final self = this as AreaTableEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.continentId,
      self.parentAreaId,
      self.areaBit,
      self.flags,
      self.soundProviderPref,
      self.soundProviderPrefUnderwater,
      self.ambienceId,
      self.zoneMusic,
      self.introSound,
      self.explorationLevel,
      self.areaNameLangEnUS,
      self.areaNameLangKoKR,
      self.areaNameLangFrFR,
      self.areaNameLangDeDE,
      self.areaNameLangZhCN,
      self.areaNameLangZhTW,
      self.areaNameLangEsES,
      self.areaNameLangEsMX,
      self.areaNameLangRuRU,
      self.areaNameLangJaJP,
      self.areaNameLangPtPT,
      self.areaNameLangPtBR,
      self.areaNameLangItIT,
      self.areaNameLangUnk1,
      self.areaNameLangUnk2,
      self.areaNameLangUnk3,
      self.areaNameLangFlags,
      self.factionGroupMask,
      self.liquidTypeId0,
      self.liquidTypeId1,
      self.liquidTypeId2,
      self.liquidTypeId3,
      self.minElevation,
      self.ambientMultiplier,
      self.lightId,
    ]);
  }

  @override
  String toString() {
    final self = this as AreaTableEntity;
    return 'AreaTableEntity('
        'id: ${self.id}, '
        'continentId: ${self.continentId}, '
        'parentAreaId: ${self.parentAreaId}, '
        'areaBit: ${self.areaBit}, '
        'flags: ${self.flags}, '
        'soundProviderPref: ${self.soundProviderPref}, '
        'soundProviderPrefUnderwater: ${self.soundProviderPrefUnderwater}, '
        'ambienceId: ${self.ambienceId}, '
        'zoneMusic: ${self.zoneMusic}, '
        'introSound: ${self.introSound}, '
        'explorationLevel: ${self.explorationLevel}, '
        'areaNameLangEnUS: ${self.areaNameLangEnUS}, '
        'areaNameLangKoKR: ${self.areaNameLangKoKR}, '
        'areaNameLangFrFR: ${self.areaNameLangFrFR}, '
        'areaNameLangDeDE: ${self.areaNameLangDeDE}, '
        'areaNameLangZhCN: ${self.areaNameLangZhCN}, '
        'areaNameLangZhTW: ${self.areaNameLangZhTW}, '
        'areaNameLangEsES: ${self.areaNameLangEsES}, '
        'areaNameLangEsMX: ${self.areaNameLangEsMX}, '
        'areaNameLangRuRU: ${self.areaNameLangRuRU}, '
        'areaNameLangJaJP: ${self.areaNameLangJaJP}, '
        'areaNameLangPtPT: ${self.areaNameLangPtPT}, '
        'areaNameLangPtBR: ${self.areaNameLangPtBR}, '
        'areaNameLangItIT: ${self.areaNameLangItIT}, '
        'areaNameLangUnk1: ${self.areaNameLangUnk1}, '
        'areaNameLangUnk2: ${self.areaNameLangUnk2}, '
        'areaNameLangUnk3: ${self.areaNameLangUnk3}, '
        'areaNameLangFlags: ${self.areaNameLangFlags}, '
        'factionGroupMask: ${self.factionGroupMask}, '
        'liquidTypeId0: ${self.liquidTypeId0}, '
        'liquidTypeId1: ${self.liquidTypeId1}, '
        'liquidTypeId2: ${self.liquidTypeId2}, '
        'liquidTypeId3: ${self.liquidTypeId3}, '
        'minElevation: ${self.minElevation}, '
        'ambientMultiplier: ${self.ambientMultiplier}, '
        'lightId: ${self.lightId}'
        ')';
  }
}
