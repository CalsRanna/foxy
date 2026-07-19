class MapInfoEntity {
  final int id;
  final String directory;
  final int instanceType;
  final int flags;
  final int pvp;
  final String mapNameLangEnUS;
  final String mapNameLangKoKR;
  final String mapNameLangFrFR;
  final String mapNameLangDeDE;
  final String mapNameLangZhCN;
  final String mapNameLangZhTW;
  final String mapNameLangEsES;
  final String mapNameLangEsMX;
  final String mapNameLangRuRU;
  final String mapNameLangJaJP;
  final String mapNameLangPtPT;
  final String mapNameLangPtBR;
  final String mapNameLangItIT;
  final String mapNameLangUnk1;
  final String mapNameLangUnk2;
  final String mapNameLangUnk3;
  final int mapNameLangFlags;
  final int areaTableId;
  final String mapDescription0LangEnUS;
  final String mapDescription0LangKoKR;
  final String mapDescription0LangFrFR;
  final String mapDescription0LangDeDE;
  final String mapDescription0LangZhCN;
  final String mapDescription0LangZhTW;
  final String mapDescription0LangEsES;
  final String mapDescription0LangEsMX;
  final String mapDescription0LangRuRU;
  final String mapDescription0LangJaJP;
  final String mapDescription0LangPtPT;
  final String mapDescription0LangPtBR;
  final String mapDescription0LangItIT;
  final String mapDescription0LangUnk1;
  final String mapDescription0LangUnk2;
  final String mapDescription0LangUnk3;
  final int mapDescription0LangFlags;
  final String mapDescription1LangEnUS;
  final String mapDescription1LangKoKR;
  final String mapDescription1LangFrFR;
  final String mapDescription1LangDeDE;
  final String mapDescription1LangZhCN;
  final String mapDescription1LangZhTW;
  final String mapDescription1LangEsES;
  final String mapDescription1LangEsMX;
  final String mapDescription1LangRuRU;
  final String mapDescription1LangJaJP;
  final String mapDescription1LangPtPT;
  final String mapDescription1LangPtBR;
  final String mapDescription1LangItIT;
  final String mapDescription1LangUnk1;
  final String mapDescription1LangUnk2;
  final String mapDescription1LangUnk3;
  final int mapDescription1LangFlags;
  final int loadingScreenId;
  final double minimapIconScale;
  final int corpseMapId;
  final double corpse0;
  final double corpse1;
  final int timeOfDayOverride;
  final int expansionId;
  final int raidOffset;
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

  factory MapInfoEntity.fromJson(Map<String, dynamic> json) {
    return MapInfoEntity(
      id: json['ID'] ?? 0,
      directory: json['Directory'] ?? '',
      instanceType: json['InstanceType'] ?? 0,
      flags: json['Flags'] ?? 0,
      pvp: json['PVP'] ?? 0,
      mapNameLangEnUS: json['MapName_lang_enUS'] ?? '',
      mapNameLangKoKR: json['MapName_lang_koKR'] ?? '',
      mapNameLangFrFR: json['MapName_lang_frFR'] ?? '',
      mapNameLangDeDE: json['MapName_lang_deDE'] ?? '',
      mapNameLangZhCN: json['MapName_lang_zhCN'] ?? '',
      mapNameLangZhTW: json['MapName_lang_zhTW'] ?? '',
      mapNameLangEsES: json['MapName_lang_esES'] ?? '',
      mapNameLangEsMX: json['MapName_lang_esMX'] ?? '',
      mapNameLangRuRU: json['MapName_lang_ruRU'] ?? '',
      mapNameLangJaJP: json['MapName_lang_jaJP'] ?? '',
      mapNameLangPtPT: json['MapName_lang_ptPT'] ?? '',
      mapNameLangPtBR: json['MapName_lang_ptBR'] ?? '',
      mapNameLangItIT: json['MapName_lang_itIT'] ?? '',
      mapNameLangUnk1: json['MapName_lang_unk1'] ?? '',
      mapNameLangUnk2: json['MapName_lang_unk2'] ?? '',
      mapNameLangUnk3: json['MapName_lang_unk3'] ?? '',
      mapNameLangFlags: json['MapName_lang_Flags'] ?? 0,
      areaTableId: json['AreaTableID'] ?? 0,
      mapDescription0LangEnUS: json['MapDescription0_lang_enUS'] ?? '',
      mapDescription0LangKoKR: json['MapDescription0_lang_koKR'] ?? '',
      mapDescription0LangFrFR: json['MapDescription0_lang_frFR'] ?? '',
      mapDescription0LangDeDE: json['MapDescription0_lang_deDE'] ?? '',
      mapDescription0LangZhCN: json['MapDescription0_lang_zhCN'] ?? '',
      mapDescription0LangZhTW: json['MapDescription0_lang_zhTW'] ?? '',
      mapDescription0LangEsES: json['MapDescription0_lang_esES'] ?? '',
      mapDescription0LangEsMX: json['MapDescription0_lang_esMX'] ?? '',
      mapDescription0LangRuRU: json['MapDescription0_lang_ruRU'] ?? '',
      mapDescription0LangJaJP: json['MapDescription0_lang_jaJP'] ?? '',
      mapDescription0LangPtPT: json['MapDescription0_lang_ptPT'] ?? '',
      mapDescription0LangPtBR: json['MapDescription0_lang_ptBR'] ?? '',
      mapDescription0LangItIT: json['MapDescription0_lang_itIT'] ?? '',
      mapDescription0LangUnk1: json['MapDescription0_lang_unk1'] ?? '',
      mapDescription0LangUnk2: json['MapDescription0_lang_unk2'] ?? '',
      mapDescription0LangUnk3: json['MapDescription0_lang_unk3'] ?? '',
      mapDescription0LangFlags: json['MapDescription0_lang_Flags'] ?? 0,
      mapDescription1LangEnUS: json['MapDescription1_lang_enUS'] ?? '',
      mapDescription1LangKoKR: json['MapDescription1_lang_koKR'] ?? '',
      mapDescription1LangFrFR: json['MapDescription1_lang_frFR'] ?? '',
      mapDescription1LangDeDE: json['MapDescription1_lang_deDE'] ?? '',
      mapDescription1LangZhCN: json['MapDescription1_lang_zhCN'] ?? '',
      mapDescription1LangZhTW: json['MapDescription1_lang_zhTW'] ?? '',
      mapDescription1LangEsES: json['MapDescription1_lang_esES'] ?? '',
      mapDescription1LangEsMX: json['MapDescription1_lang_esMX'] ?? '',
      mapDescription1LangRuRU: json['MapDescription1_lang_ruRU'] ?? '',
      mapDescription1LangJaJP: json['MapDescription1_lang_jaJP'] ?? '',
      mapDescription1LangPtPT: json['MapDescription1_lang_ptPT'] ?? '',
      mapDescription1LangPtBR: json['MapDescription1_lang_ptBR'] ?? '',
      mapDescription1LangItIT: json['MapDescription1_lang_itIT'] ?? '',
      mapDescription1LangUnk1: json['MapDescription1_lang_unk1'] ?? '',
      mapDescription1LangUnk2: json['MapDescription1_lang_unk2'] ?? '',
      mapDescription1LangUnk3: json['MapDescription1_lang_unk3'] ?? '',
      mapDescription1LangFlags: json['MapDescription1_lang_Flags'] ?? 0,
      loadingScreenId: json['LoadingScreenID'] ?? 0,
      minimapIconScale: (json['MinimapIconScale'] as num?)?.toDouble() ?? 0.0,
      corpseMapId: json['CorpseMapID'] ?? 0,
      corpse0: (json['Corpse0'] as num?)?.toDouble() ?? 0.0,
      corpse1: (json['Corpse1'] as num?)?.toDouble() ?? 0.0,
      timeOfDayOverride: json['TimeOfDayOverride'] ?? 0,
      expansionId: json['ExpansionID'] ?? 0,
      raidOffset: json['RaidOffset'] ?? 0,
      maxPlayers: json['MaxPlayers'] ?? 0,
    );
  }

  MapInfoEntity copyWith({
    int? id,
    String? directory,
    int? instanceType,
    int? flags,
    int? pvp,
    String? mapNameLangEnUS,
    String? mapNameLangKoKR,
    String? mapNameLangFrFR,
    String? mapNameLangDeDE,
    String? mapNameLangZhCN,
    String? mapNameLangZhTW,
    String? mapNameLangEsES,
    String? mapNameLangEsMX,
    String? mapNameLangRuRU,
    String? mapNameLangJaJP,
    String? mapNameLangPtPT,
    String? mapNameLangPtBR,
    String? mapNameLangItIT,
    String? mapNameLangUnk1,
    String? mapNameLangUnk2,
    String? mapNameLangUnk3,
    int? mapNameLangFlags,
    int? areaTableId,
    String? mapDescription0LangEnUS,
    String? mapDescription0LangKoKR,
    String? mapDescription0LangFrFR,
    String? mapDescription0LangDeDE,
    String? mapDescription0LangZhCN,
    String? mapDescription0LangZhTW,
    String? mapDescription0LangEsES,
    String? mapDescription0LangEsMX,
    String? mapDescription0LangRuRU,
    String? mapDescription0LangJaJP,
    String? mapDescription0LangPtPT,
    String? mapDescription0LangPtBR,
    String? mapDescription0LangItIT,
    String? mapDescription0LangUnk1,
    String? mapDescription0LangUnk2,
    String? mapDescription0LangUnk3,
    int? mapDescription0LangFlags,
    String? mapDescription1LangEnUS,
    String? mapDescription1LangKoKR,
    String? mapDescription1LangFrFR,
    String? mapDescription1LangDeDE,
    String? mapDescription1LangZhCN,
    String? mapDescription1LangZhTW,
    String? mapDescription1LangEsES,
    String? mapDescription1LangEsMX,
    String? mapDescription1LangRuRU,
    String? mapDescription1LangJaJP,
    String? mapDescription1LangPtPT,
    String? mapDescription1LangPtBR,
    String? mapDescription1LangItIT,
    String? mapDescription1LangUnk1,
    String? mapDescription1LangUnk2,
    String? mapDescription1LangUnk3,
    int? mapDescription1LangFlags,
    int? loadingScreenId,
    double? minimapIconScale,
    int? corpseMapId,
    double? corpse0,
    double? corpse1,
    int? timeOfDayOverride,
    int? expansionId,
    int? raidOffset,
    int? maxPlayers,
  }) {
    return MapInfoEntity(
      id: id ?? this.id,
      directory: directory ?? this.directory,
      instanceType: instanceType ?? this.instanceType,
      flags: flags ?? this.flags,
      pvp: pvp ?? this.pvp,
      mapNameLangEnUS: mapNameLangEnUS ?? this.mapNameLangEnUS,
      mapNameLangKoKR: mapNameLangKoKR ?? this.mapNameLangKoKR,
      mapNameLangFrFR: mapNameLangFrFR ?? this.mapNameLangFrFR,
      mapNameLangDeDE: mapNameLangDeDE ?? this.mapNameLangDeDE,
      mapNameLangZhCN: mapNameLangZhCN ?? this.mapNameLangZhCN,
      mapNameLangZhTW: mapNameLangZhTW ?? this.mapNameLangZhTW,
      mapNameLangEsES: mapNameLangEsES ?? this.mapNameLangEsES,
      mapNameLangEsMX: mapNameLangEsMX ?? this.mapNameLangEsMX,
      mapNameLangRuRU: mapNameLangRuRU ?? this.mapNameLangRuRU,
      mapNameLangJaJP: mapNameLangJaJP ?? this.mapNameLangJaJP,
      mapNameLangPtPT: mapNameLangPtPT ?? this.mapNameLangPtPT,
      mapNameLangPtBR: mapNameLangPtBR ?? this.mapNameLangPtBR,
      mapNameLangItIT: mapNameLangItIT ?? this.mapNameLangItIT,
      mapNameLangUnk1: mapNameLangUnk1 ?? this.mapNameLangUnk1,
      mapNameLangUnk2: mapNameLangUnk2 ?? this.mapNameLangUnk2,
      mapNameLangUnk3: mapNameLangUnk3 ?? this.mapNameLangUnk3,
      mapNameLangFlags: mapNameLangFlags ?? this.mapNameLangFlags,
      areaTableId: areaTableId ?? this.areaTableId,
      mapDescription0LangEnUS:
          mapDescription0LangEnUS ?? this.mapDescription0LangEnUS,
      mapDescription0LangKoKR:
          mapDescription0LangKoKR ?? this.mapDescription0LangKoKR,
      mapDescription0LangFrFR:
          mapDescription0LangFrFR ?? this.mapDescription0LangFrFR,
      mapDescription0LangDeDE:
          mapDescription0LangDeDE ?? this.mapDescription0LangDeDE,
      mapDescription0LangZhCN:
          mapDescription0LangZhCN ?? this.mapDescription0LangZhCN,
      mapDescription0LangZhTW:
          mapDescription0LangZhTW ?? this.mapDescription0LangZhTW,
      mapDescription0LangEsES:
          mapDescription0LangEsES ?? this.mapDescription0LangEsES,
      mapDescription0LangEsMX:
          mapDescription0LangEsMX ?? this.mapDescription0LangEsMX,
      mapDescription0LangRuRU:
          mapDescription0LangRuRU ?? this.mapDescription0LangRuRU,
      mapDescription0LangJaJP:
          mapDescription0LangJaJP ?? this.mapDescription0LangJaJP,
      mapDescription0LangPtPT:
          mapDescription0LangPtPT ?? this.mapDescription0LangPtPT,
      mapDescription0LangPtBR:
          mapDescription0LangPtBR ?? this.mapDescription0LangPtBR,
      mapDescription0LangItIT:
          mapDescription0LangItIT ?? this.mapDescription0LangItIT,
      mapDescription0LangUnk1:
          mapDescription0LangUnk1 ?? this.mapDescription0LangUnk1,
      mapDescription0LangUnk2:
          mapDescription0LangUnk2 ?? this.mapDescription0LangUnk2,
      mapDescription0LangUnk3:
          mapDescription0LangUnk3 ?? this.mapDescription0LangUnk3,
      mapDescription0LangFlags:
          mapDescription0LangFlags ?? this.mapDescription0LangFlags,
      mapDescription1LangEnUS:
          mapDescription1LangEnUS ?? this.mapDescription1LangEnUS,
      mapDescription1LangKoKR:
          mapDescription1LangKoKR ?? this.mapDescription1LangKoKR,
      mapDescription1LangFrFR:
          mapDescription1LangFrFR ?? this.mapDescription1LangFrFR,
      mapDescription1LangDeDE:
          mapDescription1LangDeDE ?? this.mapDescription1LangDeDE,
      mapDescription1LangZhCN:
          mapDescription1LangZhCN ?? this.mapDescription1LangZhCN,
      mapDescription1LangZhTW:
          mapDescription1LangZhTW ?? this.mapDescription1LangZhTW,
      mapDescription1LangEsES:
          mapDescription1LangEsES ?? this.mapDescription1LangEsES,
      mapDescription1LangEsMX:
          mapDescription1LangEsMX ?? this.mapDescription1LangEsMX,
      mapDescription1LangRuRU:
          mapDescription1LangRuRU ?? this.mapDescription1LangRuRU,
      mapDescription1LangJaJP:
          mapDescription1LangJaJP ?? this.mapDescription1LangJaJP,
      mapDescription1LangPtPT:
          mapDescription1LangPtPT ?? this.mapDescription1LangPtPT,
      mapDescription1LangPtBR:
          mapDescription1LangPtBR ?? this.mapDescription1LangPtBR,
      mapDescription1LangItIT:
          mapDescription1LangItIT ?? this.mapDescription1LangItIT,
      mapDescription1LangUnk1:
          mapDescription1LangUnk1 ?? this.mapDescription1LangUnk1,
      mapDescription1LangUnk2:
          mapDescription1LangUnk2 ?? this.mapDescription1LangUnk2,
      mapDescription1LangUnk3:
          mapDescription1LangUnk3 ?? this.mapDescription1LangUnk3,
      mapDescription1LangFlags:
          mapDescription1LangFlags ?? this.mapDescription1LangFlags,
      loadingScreenId: loadingScreenId ?? this.loadingScreenId,
      minimapIconScale: minimapIconScale ?? this.minimapIconScale,
      corpseMapId: corpseMapId ?? this.corpseMapId,
      corpse0: corpse0 ?? this.corpse0,
      corpse1: corpse1 ?? this.corpse1,
      timeOfDayOverride: timeOfDayOverride ?? this.timeOfDayOverride,
      expansionId: expansionId ?? this.expansionId,
      raidOffset: raidOffset ?? this.raidOffset,
      maxPlayers: maxPlayers ?? this.maxPlayers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Directory': directory,
      'InstanceType': instanceType,
      'Flags': flags,
      'PVP': pvp,
      'MapName_lang_enUS': mapNameLangEnUS,
      'MapName_lang_koKR': mapNameLangKoKR,
      'MapName_lang_frFR': mapNameLangFrFR,
      'MapName_lang_deDE': mapNameLangDeDE,
      'MapName_lang_zhCN': mapNameLangZhCN,
      'MapName_lang_zhTW': mapNameLangZhTW,
      'MapName_lang_esES': mapNameLangEsES,
      'MapName_lang_esMX': mapNameLangEsMX,
      'MapName_lang_ruRU': mapNameLangRuRU,
      'MapName_lang_jaJP': mapNameLangJaJP,
      'MapName_lang_ptPT': mapNameLangPtPT,
      'MapName_lang_ptBR': mapNameLangPtBR,
      'MapName_lang_itIT': mapNameLangItIT,
      'MapName_lang_unk1': mapNameLangUnk1,
      'MapName_lang_unk2': mapNameLangUnk2,
      'MapName_lang_unk3': mapNameLangUnk3,
      'MapName_lang_Flags': mapNameLangFlags,
      'AreaTableID': areaTableId,
      'MapDescription0_lang_enUS': mapDescription0LangEnUS,
      'MapDescription0_lang_koKR': mapDescription0LangKoKR,
      'MapDescription0_lang_frFR': mapDescription0LangFrFR,
      'MapDescription0_lang_deDE': mapDescription0LangDeDE,
      'MapDescription0_lang_zhCN': mapDescription0LangZhCN,
      'MapDescription0_lang_zhTW': mapDescription0LangZhTW,
      'MapDescription0_lang_esES': mapDescription0LangEsES,
      'MapDescription0_lang_esMX': mapDescription0LangEsMX,
      'MapDescription0_lang_ruRU': mapDescription0LangRuRU,
      'MapDescription0_lang_jaJP': mapDescription0LangJaJP,
      'MapDescription0_lang_ptPT': mapDescription0LangPtPT,
      'MapDescription0_lang_ptBR': mapDescription0LangPtBR,
      'MapDescription0_lang_itIT': mapDescription0LangItIT,
      'MapDescription0_lang_unk1': mapDescription0LangUnk1,
      'MapDescription0_lang_unk2': mapDescription0LangUnk2,
      'MapDescription0_lang_unk3': mapDescription0LangUnk3,
      'MapDescription0_lang_Flags': mapDescription0LangFlags,
      'MapDescription1_lang_enUS': mapDescription1LangEnUS,
      'MapDescription1_lang_koKR': mapDescription1LangKoKR,
      'MapDescription1_lang_frFR': mapDescription1LangFrFR,
      'MapDescription1_lang_deDE': mapDescription1LangDeDE,
      'MapDescription1_lang_zhCN': mapDescription1LangZhCN,
      'MapDescription1_lang_zhTW': mapDescription1LangZhTW,
      'MapDescription1_lang_esES': mapDescription1LangEsES,
      'MapDescription1_lang_esMX': mapDescription1LangEsMX,
      'MapDescription1_lang_ruRU': mapDescription1LangRuRU,
      'MapDescription1_lang_jaJP': mapDescription1LangJaJP,
      'MapDescription1_lang_ptPT': mapDescription1LangPtPT,
      'MapDescription1_lang_ptBR': mapDescription1LangPtBR,
      'MapDescription1_lang_itIT': mapDescription1LangItIT,
      'MapDescription1_lang_unk1': mapDescription1LangUnk1,
      'MapDescription1_lang_unk2': mapDescription1LangUnk2,
      'MapDescription1_lang_unk3': mapDescription1LangUnk3,
      'MapDescription1_lang_Flags': mapDescription1LangFlags,
      'LoadingScreenID': loadingScreenId,
      'MinimapIconScale': minimapIconScale,
      'CorpseMapID': corpseMapId,
      'Corpse0': corpse0,
      'Corpse1': corpse1,
      'TimeOfDayOverride': timeOfDayOverride,
      'ExpansionID': expansionId,
      'RaidOffset': raidOffset,
      'MaxPlayers': maxPlayers,
    };
  }
}
