// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_table_entity.dart';

mixin _AreaTableEntityMixin {
  int get id;
  int get continentId;
  int get parentAreaId;
  int get areaBit;
  int get flags;
  int get soundProviderPref;
  int get soundProviderPrefUnderwater;
  int get ambienceId;
  int get zoneMusic;
  int get introSound;
  int get explorationLevel;
  String get areaNameLangEnUS;
  String get areaNameLangKoKR;
  String get areaNameLangFrFR;
  String get areaNameLangDeDE;
  String get areaNameLangZhCN;
  String get areaNameLangZhTW;
  String get areaNameLangEsES;
  String get areaNameLangEsMX;
  String get areaNameLangRuRU;
  String get areaNameLangJaJP;
  String get areaNameLangPtPT;
  String get areaNameLangPtBR;
  String get areaNameLangItIT;
  String get areaNameLangUnk1;
  String get areaNameLangUnk2;
  String get areaNameLangUnk3;
  int get areaNameLangFlags;
  int get factionGroupMask;
  int get liquidTypeId0;
  int get liquidTypeId1;
  int get liquidTypeId2;
  int get liquidTypeId3;
  double get minElevation;
  double get ambientMultiplier;
  int get lightId;

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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AreaTableEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            continentId == other.continentId &&
            parentAreaId == other.parentAreaId &&
            areaBit == other.areaBit &&
            flags == other.flags &&
            soundProviderPref == other.soundProviderPref &&
            soundProviderPrefUnderwater == other.soundProviderPrefUnderwater &&
            ambienceId == other.ambienceId &&
            zoneMusic == other.zoneMusic &&
            introSound == other.introSound &&
            explorationLevel == other.explorationLevel &&
            areaNameLangEnUS == other.areaNameLangEnUS &&
            areaNameLangKoKR == other.areaNameLangKoKR &&
            areaNameLangFrFR == other.areaNameLangFrFR &&
            areaNameLangDeDE == other.areaNameLangDeDE &&
            areaNameLangZhCN == other.areaNameLangZhCN &&
            areaNameLangZhTW == other.areaNameLangZhTW &&
            areaNameLangEsES == other.areaNameLangEsES &&
            areaNameLangEsMX == other.areaNameLangEsMX &&
            areaNameLangRuRU == other.areaNameLangRuRU &&
            areaNameLangJaJP == other.areaNameLangJaJP &&
            areaNameLangPtPT == other.areaNameLangPtPT &&
            areaNameLangPtBR == other.areaNameLangPtBR &&
            areaNameLangItIT == other.areaNameLangItIT &&
            areaNameLangUnk1 == other.areaNameLangUnk1 &&
            areaNameLangUnk2 == other.areaNameLangUnk2 &&
            areaNameLangUnk3 == other.areaNameLangUnk3 &&
            areaNameLangFlags == other.areaNameLangFlags &&
            factionGroupMask == other.factionGroupMask &&
            liquidTypeId0 == other.liquidTypeId0 &&
            liquidTypeId1 == other.liquidTypeId1 &&
            liquidTypeId2 == other.liquidTypeId2 &&
            liquidTypeId3 == other.liquidTypeId3 &&
            minElevation == other.minElevation &&
            ambientMultiplier == other.ambientMultiplier &&
            lightId == other.lightId;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      continentId,
      parentAreaId,
      areaBit,
      flags,
      soundProviderPref,
      soundProviderPrefUnderwater,
      ambienceId,
      zoneMusic,
      introSound,
      explorationLevel,
      areaNameLangEnUS,
      areaNameLangKoKR,
      areaNameLangFrFR,
      areaNameLangDeDE,
      areaNameLangZhCN,
      areaNameLangZhTW,
      areaNameLangEsES,
      areaNameLangEsMX,
      areaNameLangRuRU,
      areaNameLangJaJP,
      areaNameLangPtPT,
      areaNameLangPtBR,
      areaNameLangItIT,
      areaNameLangUnk1,
      areaNameLangUnk2,
      areaNameLangUnk3,
      areaNameLangFlags,
      factionGroupMask,
      liquidTypeId0,
      liquidTypeId1,
      liquidTypeId2,
      liquidTypeId3,
      minElevation,
      ambientMultiplier,
      lightId,
    ]);
  }

  @override
  String toString() {
    return 'AreaTableEntity('
        'id: $id, '
        'continentId: $continentId, '
        'parentAreaId: $parentAreaId, '
        'areaBit: $areaBit, '
        'flags: $flags, '
        'soundProviderPref: $soundProviderPref, '
        'soundProviderPrefUnderwater: $soundProviderPrefUnderwater, '
        'ambienceId: $ambienceId, '
        'zoneMusic: $zoneMusic, '
        'introSound: $introSound, '
        'explorationLevel: $explorationLevel, '
        'areaNameLangEnUS: $areaNameLangEnUS, '
        'areaNameLangKoKR: $areaNameLangKoKR, '
        'areaNameLangFrFR: $areaNameLangFrFR, '
        'areaNameLangDeDE: $areaNameLangDeDE, '
        'areaNameLangZhCN: $areaNameLangZhCN, '
        'areaNameLangZhTW: $areaNameLangZhTW, '
        'areaNameLangEsES: $areaNameLangEsES, '
        'areaNameLangEsMX: $areaNameLangEsMX, '
        'areaNameLangRuRU: $areaNameLangRuRU, '
        'areaNameLangJaJP: $areaNameLangJaJP, '
        'areaNameLangPtPT: $areaNameLangPtPT, '
        'areaNameLangPtBR: $areaNameLangPtBR, '
        'areaNameLangItIT: $areaNameLangItIT, '
        'areaNameLangUnk1: $areaNameLangUnk1, '
        'areaNameLangUnk2: $areaNameLangUnk2, '
        'areaNameLangUnk3: $areaNameLangUnk3, '
        'areaNameLangFlags: $areaNameLangFlags, '
        'factionGroupMask: $factionGroupMask, '
        'liquidTypeId0: $liquidTypeId0, '
        'liquidTypeId1: $liquidTypeId1, '
        'liquidTypeId2: $liquidTypeId2, '
        'liquidTypeId3: $liquidTypeId3, '
        'minElevation: $minElevation, '
        'ambientMultiplier: $ambientMultiplier, '
        'lightId: $lightId'
        ')';
  }
}
