// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'area_table_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_area_table')
class AreaTableEntity with _AreaTableEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('ContinentID')
  final int continentId;

  @FoxyFullField('ParentAreaID')
  final int parentAreaId;

  @FoxyFullField('AreaBit')
  final int areaBit;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('SoundProviderPref')
  final int soundProviderPref;

  @FoxyFullField('SoundProviderPrefUnderwater')
  final int soundProviderPrefUnderwater;

  @FoxyFullField('AmbienceID')
  final int ambienceId;

  @FoxyBriefField()
  @FoxyFullField('ZoneMusic')
  final int zoneMusic;

  @FoxyFullField('IntroSound')
  final int introSound;

  @FoxyBriefField()
  @FoxyFullField('ExplorationLevel')
  final int explorationLevel;

  @FoxyFullField('AreaName_lang_enUS')
  final String areaNameLangEnUS;

  @FoxyFullField('AreaName_lang_koKR')
  final String areaNameLangKoKR;

  @FoxyFullField('AreaName_lang_frFR')
  final String areaNameLangFrFR;

  @FoxyFullField('AreaName_lang_deDE')
  final String areaNameLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('AreaName_lang_zhCN')
  final String areaNameLangZhCN;

  @FoxyFullField('AreaName_lang_zhTW')
  final String areaNameLangZhTW;

  @FoxyFullField('AreaName_lang_esES')
  final String areaNameLangEsES;

  @FoxyFullField('AreaName_lang_esMX')
  final String areaNameLangEsMX;

  @FoxyFullField('AreaName_lang_ruRU')
  final String areaNameLangRuRU;

  @FoxyFullField('AreaName_lang_jaJP')
  final String areaNameLangJaJP;

  @FoxyFullField('AreaName_lang_ptPT')
  final String areaNameLangPtPT;

  @FoxyFullField('AreaName_lang_ptBR')
  final String areaNameLangPtBR;

  @FoxyFullField('AreaName_lang_itIT')
  final String areaNameLangItIT;

  @FoxyFullField('AreaName_lang_unk1')
  final String areaNameLangUnk1;

  @FoxyFullField('AreaName_lang_unk2')
  final String areaNameLangUnk2;

  @FoxyFullField('AreaName_lang_unk3')
  final String areaNameLangUnk3;

  @FoxyFullField('AreaName_lang_Flags')
  final int areaNameLangFlags;

  @FoxyFullField('FactionGroupMask')
  final int factionGroupMask;

  @FoxyFullField('LiquidTypeID0')
  final int liquidTypeId0;

  @FoxyFullField('LiquidTypeID1')
  final int liquidTypeId1;

  @FoxyFullField('LiquidTypeID2')
  final int liquidTypeId2;

  @FoxyFullField('LiquidTypeID3')
  final int liquidTypeId3;

  @FoxyBriefField()
  @FoxyFullField('MinElevation')
  final double minElevation;

  @FoxyFullField('Ambient_multiplier')
  final double ambientMultiplier;

  @FoxyFullField('LightID')
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

  factory AreaTableEntity.fromJson(Map<String, dynamic> json) =>
      _AreaTableEntityMixin.fromJson(json);
}
