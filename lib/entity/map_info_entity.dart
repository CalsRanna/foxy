import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'map_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_map')
class MapInfoEntity with _MapInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Directory')
  final String directory;

  @FoxyBriefField()
  @FoxyFullField('InstanceType')
  final int instanceType;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyBriefField()
  @FoxyFullField('PVP')
  final int pvp;

  @FoxyFullField('MapName_lang_enUS')
  final String mapNameLangEnUS;

  @FoxyFullField('MapName_lang_koKR')
  final String mapNameLangKoKR;

  @FoxyFullField('MapName_lang_frFR')
  final String mapNameLangFrFR;

  @FoxyFullField('MapName_lang_deDE')
  final String mapNameLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('MapName_lang_zhCN')
  final String mapNameLangZhCN;

  @FoxyFullField('MapName_lang_zhTW')
  final String mapNameLangZhTW;

  @FoxyFullField('MapName_lang_esES')
  final String mapNameLangEsES;

  @FoxyFullField('MapName_lang_esMX')
  final String mapNameLangEsMX;

  @FoxyFullField('MapName_lang_ruRU')
  final String mapNameLangRuRU;

  @FoxyFullField('MapName_lang_jaJP')
  final String mapNameLangJaJP;

  @FoxyFullField('MapName_lang_ptPT')
  final String mapNameLangPtPT;

  @FoxyFullField('MapName_lang_ptBR')
  final String mapNameLangPtBR;

  @FoxyFullField('MapName_lang_itIT')
  final String mapNameLangItIT;

  @FoxyFullField('MapName_lang_unk1')
  final String mapNameLangUnk1;

  @FoxyFullField('MapName_lang_unk2')
  final String mapNameLangUnk2;

  @FoxyFullField('MapName_lang_unk3')
  final String mapNameLangUnk3;

  @FoxyFullField('MapName_lang_Flags')
  final int mapNameLangFlags;

  @FoxyFullField('AreaTableID')
  final int areaTableId;

  @FoxyFullField('MapDescription0_lang_enUS')
  final String mapDescription0LangEnUS;

  @FoxyFullField('MapDescription0_lang_koKR')
  final String mapDescription0LangKoKR;

  @FoxyFullField('MapDescription0_lang_frFR')
  final String mapDescription0LangFrFR;

  @FoxyFullField('MapDescription0_lang_deDE')
  final String mapDescription0LangDeDE;

  @FoxyFullField('MapDescription0_lang_zhCN')
  final String mapDescription0LangZhCN;

  @FoxyFullField('MapDescription0_lang_zhTW')
  final String mapDescription0LangZhTW;

  @FoxyFullField('MapDescription0_lang_esES')
  final String mapDescription0LangEsES;

  @FoxyFullField('MapDescription0_lang_esMX')
  final String mapDescription0LangEsMX;

  @FoxyFullField('MapDescription0_lang_ruRU')
  final String mapDescription0LangRuRU;

  @FoxyFullField('MapDescription0_lang_jaJP')
  final String mapDescription0LangJaJP;

  @FoxyFullField('MapDescription0_lang_ptPT')
  final String mapDescription0LangPtPT;

  @FoxyFullField('MapDescription0_lang_ptBR')
  final String mapDescription0LangPtBR;

  @FoxyFullField('MapDescription0_lang_itIT')
  final String mapDescription0LangItIT;

  @FoxyFullField('MapDescription0_lang_unk1')
  final String mapDescription0LangUnk1;

  @FoxyFullField('MapDescription0_lang_unk2')
  final String mapDescription0LangUnk2;

  @FoxyFullField('MapDescription0_lang_unk3')
  final String mapDescription0LangUnk3;

  @FoxyFullField('MapDescription0_lang_Flags')
  final int mapDescription0LangFlags;

  @FoxyFullField('MapDescription1_lang_enUS')
  final String mapDescription1LangEnUS;

  @FoxyFullField('MapDescription1_lang_koKR')
  final String mapDescription1LangKoKR;

  @FoxyFullField('MapDescription1_lang_frFR')
  final String mapDescription1LangFrFR;

  @FoxyFullField('MapDescription1_lang_deDE')
  final String mapDescription1LangDeDE;

  @FoxyFullField('MapDescription1_lang_zhCN')
  final String mapDescription1LangZhCN;

  @FoxyFullField('MapDescription1_lang_zhTW')
  final String mapDescription1LangZhTW;

  @FoxyFullField('MapDescription1_lang_esES')
  final String mapDescription1LangEsES;

  @FoxyFullField('MapDescription1_lang_esMX')
  final String mapDescription1LangEsMX;

  @FoxyFullField('MapDescription1_lang_ruRU')
  final String mapDescription1LangRuRU;

  @FoxyFullField('MapDescription1_lang_jaJP')
  final String mapDescription1LangJaJP;

  @FoxyFullField('MapDescription1_lang_ptPT')
  final String mapDescription1LangPtPT;

  @FoxyFullField('MapDescription1_lang_ptBR')
  final String mapDescription1LangPtBR;

  @FoxyFullField('MapDescription1_lang_itIT')
  final String mapDescription1LangItIT;

  @FoxyFullField('MapDescription1_lang_unk1')
  final String mapDescription1LangUnk1;

  @FoxyFullField('MapDescription1_lang_unk2')
  final String mapDescription1LangUnk2;

  @FoxyFullField('MapDescription1_lang_unk3')
  final String mapDescription1LangUnk3;

  @FoxyFullField('MapDescription1_lang_Flags')
  final int mapDescription1LangFlags;

  @FoxyFullField('LoadingScreenID')
  final int loadingScreenId;

  @FoxyFullField('MinimapIconScale')
  final double minimapIconScale;

  @FoxyFullField('CorpseMapID')
  final int corpseMapId;

  @FoxyFullField('Corpse0')
  final double corpse0;

  @FoxyFullField('Corpse1')
  final double corpse1;

  @FoxyFullField('TimeOfDayOverride')
  final int timeOfDayOverride;

  @FoxyFullField('ExpansionID')
  final int expansionId;

  @FoxyFullField('RaidOffset')
  final int raidOffset;

  @FoxyFullField('MaxPlayers')
  final int maxPlayers;

  const MapInfoEntity({
    this.id = 0,
    this.directory = '',
    this.instanceType = 0,
    this.flags = 0,
    this.pvp = 0,
    this.mapNameLangEnUS = '',
    this.mapNameLangKoKR = '',
    this.mapNameLangFrFR = '',
    this.mapNameLangDeDE = '',
    this.mapNameLangZhCN = '',
    this.mapNameLangZhTW = '',
    this.mapNameLangEsES = '',
    this.mapNameLangEsMX = '',
    this.mapNameLangRuRU = '',
    this.mapNameLangJaJP = '',
    this.mapNameLangPtPT = '',
    this.mapNameLangPtBR = '',
    this.mapNameLangItIT = '',
    this.mapNameLangUnk1 = '',
    this.mapNameLangUnk2 = '',
    this.mapNameLangUnk3 = '',
    this.mapNameLangFlags = 0,
    this.areaTableId = 0,
    this.mapDescription0LangEnUS = '',
    this.mapDescription0LangKoKR = '',
    this.mapDescription0LangFrFR = '',
    this.mapDescription0LangDeDE = '',
    this.mapDescription0LangZhCN = '',
    this.mapDescription0LangZhTW = '',
    this.mapDescription0LangEsES = '',
    this.mapDescription0LangEsMX = '',
    this.mapDescription0LangRuRU = '',
    this.mapDescription0LangJaJP = '',
    this.mapDescription0LangPtPT = '',
    this.mapDescription0LangPtBR = '',
    this.mapDescription0LangItIT = '',
    this.mapDescription0LangUnk1 = '',
    this.mapDescription0LangUnk2 = '',
    this.mapDescription0LangUnk3 = '',
    this.mapDescription0LangFlags = 0,
    this.mapDescription1LangEnUS = '',
    this.mapDescription1LangKoKR = '',
    this.mapDescription1LangFrFR = '',
    this.mapDescription1LangDeDE = '',
    this.mapDescription1LangZhCN = '',
    this.mapDescription1LangZhTW = '',
    this.mapDescription1LangEsES = '',
    this.mapDescription1LangEsMX = '',
    this.mapDescription1LangRuRU = '',
    this.mapDescription1LangJaJP = '',
    this.mapDescription1LangPtPT = '',
    this.mapDescription1LangPtBR = '',
    this.mapDescription1LangItIT = '',
    this.mapDescription1LangUnk1 = '',
    this.mapDescription1LangUnk2 = '',
    this.mapDescription1LangUnk3 = '',
    this.mapDescription1LangFlags = 0,
    this.loadingScreenId = 0,
    this.minimapIconScale = 0.0,
    this.corpseMapId = 0,
    this.corpse0 = 0.0,
    this.corpse1 = 0.0,
    this.timeOfDayOverride = 0,
    this.expansionId = 0,
    this.raidOffset = 0,
    this.maxPlayers = 0,
  });

  factory MapInfoEntity.fromJson(Map<String, dynamic> json) =>
      _MapInfoEntityMixin.fromJson(json);
}
