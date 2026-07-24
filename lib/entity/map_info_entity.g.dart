// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_info_entity.dart';

mixin _MapInfoEntityMixin {
  int get id;
  String get directory;
  int get instanceType;
  int get flags;
  int get pvp;
  String get mapNameLangEnUS;
  String get mapNameLangKoKR;
  String get mapNameLangFrFR;
  String get mapNameLangDeDE;
  String get mapNameLangZhCN;
  String get mapNameLangZhTW;
  String get mapNameLangEsES;
  String get mapNameLangEsMX;
  String get mapNameLangRuRU;
  String get mapNameLangJaJP;
  String get mapNameLangPtPT;
  String get mapNameLangPtBR;
  String get mapNameLangItIT;
  String get mapNameLangUnk1;
  String get mapNameLangUnk2;
  String get mapNameLangUnk3;
  int get mapNameLangFlags;
  int get areaTableId;
  String get mapDescription0LangEnUS;
  String get mapDescription0LangKoKR;
  String get mapDescription0LangFrFR;
  String get mapDescription0LangDeDE;
  String get mapDescription0LangZhCN;
  String get mapDescription0LangZhTW;
  String get mapDescription0LangEsES;
  String get mapDescription0LangEsMX;
  String get mapDescription0LangRuRU;
  String get mapDescription0LangJaJP;
  String get mapDescription0LangPtPT;
  String get mapDescription0LangPtBR;
  String get mapDescription0LangItIT;
  String get mapDescription0LangUnk1;
  String get mapDescription0LangUnk2;
  String get mapDescription0LangUnk3;
  int get mapDescription0LangFlags;
  String get mapDescription1LangEnUS;
  String get mapDescription1LangKoKR;
  String get mapDescription1LangFrFR;
  String get mapDescription1LangDeDE;
  String get mapDescription1LangZhCN;
  String get mapDescription1LangZhTW;
  String get mapDescription1LangEsES;
  String get mapDescription1LangEsMX;
  String get mapDescription1LangRuRU;
  String get mapDescription1LangJaJP;
  String get mapDescription1LangPtPT;
  String get mapDescription1LangPtBR;
  String get mapDescription1LangItIT;
  String get mapDescription1LangUnk1;
  String get mapDescription1LangUnk2;
  String get mapDescription1LangUnk3;
  int get mapDescription1LangFlags;
  int get loadingScreenId;
  double get minimapIconScale;
  int get corpseMapId;
  double get corpse0;
  double get corpse1;
  int get timeOfDayOverride;
  int get expansionId;
  int get raidOffset;
  int get maxPlayers;

  static MapInfoEntity fromJson(Map<String, dynamic> json) {
    return MapInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      directory: json['Directory']?.toString() ?? '',
      instanceType: (json['InstanceType'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      pvp: (json['PVP'] as num?)?.toInt() ?? 0,
      mapNameLangEnUS: json['MapName_lang_enUS']?.toString() ?? '',
      mapNameLangKoKR: json['MapName_lang_koKR']?.toString() ?? '',
      mapNameLangFrFR: json['MapName_lang_frFR']?.toString() ?? '',
      mapNameLangDeDE: json['MapName_lang_deDE']?.toString() ?? '',
      mapNameLangZhCN: json['MapName_lang_zhCN']?.toString() ?? '',
      mapNameLangZhTW: json['MapName_lang_zhTW']?.toString() ?? '',
      mapNameLangEsES: json['MapName_lang_esES']?.toString() ?? '',
      mapNameLangEsMX: json['MapName_lang_esMX']?.toString() ?? '',
      mapNameLangRuRU: json['MapName_lang_ruRU']?.toString() ?? '',
      mapNameLangJaJP: json['MapName_lang_jaJP']?.toString() ?? '',
      mapNameLangPtPT: json['MapName_lang_ptPT']?.toString() ?? '',
      mapNameLangPtBR: json['MapName_lang_ptBR']?.toString() ?? '',
      mapNameLangItIT: json['MapName_lang_itIT']?.toString() ?? '',
      mapNameLangUnk1: json['MapName_lang_unk1']?.toString() ?? '',
      mapNameLangUnk2: json['MapName_lang_unk2']?.toString() ?? '',
      mapNameLangUnk3: json['MapName_lang_unk3']?.toString() ?? '',
      mapNameLangFlags: (json['MapName_lang_Flags'] as num?)?.toInt() ?? 0,
      areaTableId: (json['AreaTableID'] as num?)?.toInt() ?? 0,
      mapDescription0LangEnUS:
          json['MapDescription0_lang_enUS']?.toString() ?? '',
      mapDescription0LangKoKR:
          json['MapDescription0_lang_koKR']?.toString() ?? '',
      mapDescription0LangFrFR:
          json['MapDescription0_lang_frFR']?.toString() ?? '',
      mapDescription0LangDeDE:
          json['MapDescription0_lang_deDE']?.toString() ?? '',
      mapDescription0LangZhCN:
          json['MapDescription0_lang_zhCN']?.toString() ?? '',
      mapDescription0LangZhTW:
          json['MapDescription0_lang_zhTW']?.toString() ?? '',
      mapDescription0LangEsES:
          json['MapDescription0_lang_esES']?.toString() ?? '',
      mapDescription0LangEsMX:
          json['MapDescription0_lang_esMX']?.toString() ?? '',
      mapDescription0LangRuRU:
          json['MapDescription0_lang_ruRU']?.toString() ?? '',
      mapDescription0LangJaJP:
          json['MapDescription0_lang_jaJP']?.toString() ?? '',
      mapDescription0LangPtPT:
          json['MapDescription0_lang_ptPT']?.toString() ?? '',
      mapDescription0LangPtBR:
          json['MapDescription0_lang_ptBR']?.toString() ?? '',
      mapDescription0LangItIT:
          json['MapDescription0_lang_itIT']?.toString() ?? '',
      mapDescription0LangUnk1:
          json['MapDescription0_lang_unk1']?.toString() ?? '',
      mapDescription0LangUnk2:
          json['MapDescription0_lang_unk2']?.toString() ?? '',
      mapDescription0LangUnk3:
          json['MapDescription0_lang_unk3']?.toString() ?? '',
      mapDescription0LangFlags:
          (json['MapDescription0_lang_Flags'] as num?)?.toInt() ?? 0,
      mapDescription1LangEnUS:
          json['MapDescription1_lang_enUS']?.toString() ?? '',
      mapDescription1LangKoKR:
          json['MapDescription1_lang_koKR']?.toString() ?? '',
      mapDescription1LangFrFR:
          json['MapDescription1_lang_frFR']?.toString() ?? '',
      mapDescription1LangDeDE:
          json['MapDescription1_lang_deDE']?.toString() ?? '',
      mapDescription1LangZhCN:
          json['MapDescription1_lang_zhCN']?.toString() ?? '',
      mapDescription1LangZhTW:
          json['MapDescription1_lang_zhTW']?.toString() ?? '',
      mapDescription1LangEsES:
          json['MapDescription1_lang_esES']?.toString() ?? '',
      mapDescription1LangEsMX:
          json['MapDescription1_lang_esMX']?.toString() ?? '',
      mapDescription1LangRuRU:
          json['MapDescription1_lang_ruRU']?.toString() ?? '',
      mapDescription1LangJaJP:
          json['MapDescription1_lang_jaJP']?.toString() ?? '',
      mapDescription1LangPtPT:
          json['MapDescription1_lang_ptPT']?.toString() ?? '',
      mapDescription1LangPtBR:
          json['MapDescription1_lang_ptBR']?.toString() ?? '',
      mapDescription1LangItIT:
          json['MapDescription1_lang_itIT']?.toString() ?? '',
      mapDescription1LangUnk1:
          json['MapDescription1_lang_unk1']?.toString() ?? '',
      mapDescription1LangUnk2:
          json['MapDescription1_lang_unk2']?.toString() ?? '',
      mapDescription1LangUnk3:
          json['MapDescription1_lang_unk3']?.toString() ?? '',
      mapDescription1LangFlags:
          (json['MapDescription1_lang_Flags'] as num?)?.toInt() ?? 0,
      loadingScreenId: (json['LoadingScreenID'] as num?)?.toInt() ?? 0,
      minimapIconScale: (json['MinimapIconScale'] as num?)?.toDouble() ?? 0.0,
      corpseMapId: (json['CorpseMapID'] as num?)?.toInt() ?? 0,
      corpse0: (json['Corpse0'] as num?)?.toDouble() ?? 0.0,
      corpse1: (json['Corpse1'] as num?)?.toDouble() ?? 0.0,
      timeOfDayOverride: (json['TimeOfDayOverride'] as num?)?.toInt() ?? 0,
      expansionId: (json['ExpansionID'] as num?)?.toInt() ?? 0,
      raidOffset: (json['RaidOffset'] as num?)?.toInt() ?? 0,
      maxPlayers: (json['MaxPlayers'] as num?)?.toInt() ?? 0,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MapInfoEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            directory == other.directory &&
            instanceType == other.instanceType &&
            flags == other.flags &&
            pvp == other.pvp &&
            mapNameLangEnUS == other.mapNameLangEnUS &&
            mapNameLangKoKR == other.mapNameLangKoKR &&
            mapNameLangFrFR == other.mapNameLangFrFR &&
            mapNameLangDeDE == other.mapNameLangDeDE &&
            mapNameLangZhCN == other.mapNameLangZhCN &&
            mapNameLangZhTW == other.mapNameLangZhTW &&
            mapNameLangEsES == other.mapNameLangEsES &&
            mapNameLangEsMX == other.mapNameLangEsMX &&
            mapNameLangRuRU == other.mapNameLangRuRU &&
            mapNameLangJaJP == other.mapNameLangJaJP &&
            mapNameLangPtPT == other.mapNameLangPtPT &&
            mapNameLangPtBR == other.mapNameLangPtBR &&
            mapNameLangItIT == other.mapNameLangItIT &&
            mapNameLangUnk1 == other.mapNameLangUnk1 &&
            mapNameLangUnk2 == other.mapNameLangUnk2 &&
            mapNameLangUnk3 == other.mapNameLangUnk3 &&
            mapNameLangFlags == other.mapNameLangFlags &&
            areaTableId == other.areaTableId &&
            mapDescription0LangEnUS == other.mapDescription0LangEnUS &&
            mapDescription0LangKoKR == other.mapDescription0LangKoKR &&
            mapDescription0LangFrFR == other.mapDescription0LangFrFR &&
            mapDescription0LangDeDE == other.mapDescription0LangDeDE &&
            mapDescription0LangZhCN == other.mapDescription0LangZhCN &&
            mapDescription0LangZhTW == other.mapDescription0LangZhTW &&
            mapDescription0LangEsES == other.mapDescription0LangEsES &&
            mapDescription0LangEsMX == other.mapDescription0LangEsMX &&
            mapDescription0LangRuRU == other.mapDescription0LangRuRU &&
            mapDescription0LangJaJP == other.mapDescription0LangJaJP &&
            mapDescription0LangPtPT == other.mapDescription0LangPtPT &&
            mapDescription0LangPtBR == other.mapDescription0LangPtBR &&
            mapDescription0LangItIT == other.mapDescription0LangItIT &&
            mapDescription0LangUnk1 == other.mapDescription0LangUnk1 &&
            mapDescription0LangUnk2 == other.mapDescription0LangUnk2 &&
            mapDescription0LangUnk3 == other.mapDescription0LangUnk3 &&
            mapDescription0LangFlags == other.mapDescription0LangFlags &&
            mapDescription1LangEnUS == other.mapDescription1LangEnUS &&
            mapDescription1LangKoKR == other.mapDescription1LangKoKR &&
            mapDescription1LangFrFR == other.mapDescription1LangFrFR &&
            mapDescription1LangDeDE == other.mapDescription1LangDeDE &&
            mapDescription1LangZhCN == other.mapDescription1LangZhCN &&
            mapDescription1LangZhTW == other.mapDescription1LangZhTW &&
            mapDescription1LangEsES == other.mapDescription1LangEsES &&
            mapDescription1LangEsMX == other.mapDescription1LangEsMX &&
            mapDescription1LangRuRU == other.mapDescription1LangRuRU &&
            mapDescription1LangJaJP == other.mapDescription1LangJaJP &&
            mapDescription1LangPtPT == other.mapDescription1LangPtPT &&
            mapDescription1LangPtBR == other.mapDescription1LangPtBR &&
            mapDescription1LangItIT == other.mapDescription1LangItIT &&
            mapDescription1LangUnk1 == other.mapDescription1LangUnk1 &&
            mapDescription1LangUnk2 == other.mapDescription1LangUnk2 &&
            mapDescription1LangUnk3 == other.mapDescription1LangUnk3 &&
            mapDescription1LangFlags == other.mapDescription1LangFlags &&
            loadingScreenId == other.loadingScreenId &&
            minimapIconScale == other.minimapIconScale &&
            corpseMapId == other.corpseMapId &&
            corpse0 == other.corpse0 &&
            corpse1 == other.corpse1 &&
            timeOfDayOverride == other.timeOfDayOverride &&
            expansionId == other.expansionId &&
            raidOffset == other.raidOffset &&
            maxPlayers == other.maxPlayers;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      directory,
      instanceType,
      flags,
      pvp,
      mapNameLangEnUS,
      mapNameLangKoKR,
      mapNameLangFrFR,
      mapNameLangDeDE,
      mapNameLangZhCN,
      mapNameLangZhTW,
      mapNameLangEsES,
      mapNameLangEsMX,
      mapNameLangRuRU,
      mapNameLangJaJP,
      mapNameLangPtPT,
      mapNameLangPtBR,
      mapNameLangItIT,
      mapNameLangUnk1,
      mapNameLangUnk2,
      mapNameLangUnk3,
      mapNameLangFlags,
      areaTableId,
      mapDescription0LangEnUS,
      mapDescription0LangKoKR,
      mapDescription0LangFrFR,
      mapDescription0LangDeDE,
      mapDescription0LangZhCN,
      mapDescription0LangZhTW,
      mapDescription0LangEsES,
      mapDescription0LangEsMX,
      mapDescription0LangRuRU,
      mapDescription0LangJaJP,
      mapDescription0LangPtPT,
      mapDescription0LangPtBR,
      mapDescription0LangItIT,
      mapDescription0LangUnk1,
      mapDescription0LangUnk2,
      mapDescription0LangUnk3,
      mapDescription0LangFlags,
      mapDescription1LangEnUS,
      mapDescription1LangKoKR,
      mapDescription1LangFrFR,
      mapDescription1LangDeDE,
      mapDescription1LangZhCN,
      mapDescription1LangZhTW,
      mapDescription1LangEsES,
      mapDescription1LangEsMX,
      mapDescription1LangRuRU,
      mapDescription1LangJaJP,
      mapDescription1LangPtPT,
      mapDescription1LangPtBR,
      mapDescription1LangItIT,
      mapDescription1LangUnk1,
      mapDescription1LangUnk2,
      mapDescription1LangUnk3,
      mapDescription1LangFlags,
      loadingScreenId,
      minimapIconScale,
      corpseMapId,
      corpse0,
      corpse1,
      timeOfDayOverride,
      expansionId,
      raidOffset,
      maxPlayers,
    ]);
  }

  @override
  String toString() {
    return 'MapInfoEntity('
        'id: $id, '
        'directory: $directory, '
        'instanceType: $instanceType, '
        'flags: $flags, '
        'pvp: $pvp, '
        'mapNameLangEnUS: $mapNameLangEnUS, '
        'mapNameLangKoKR: $mapNameLangKoKR, '
        'mapNameLangFrFR: $mapNameLangFrFR, '
        'mapNameLangDeDE: $mapNameLangDeDE, '
        'mapNameLangZhCN: $mapNameLangZhCN, '
        'mapNameLangZhTW: $mapNameLangZhTW, '
        'mapNameLangEsES: $mapNameLangEsES, '
        'mapNameLangEsMX: $mapNameLangEsMX, '
        'mapNameLangRuRU: $mapNameLangRuRU, '
        'mapNameLangJaJP: $mapNameLangJaJP, '
        'mapNameLangPtPT: $mapNameLangPtPT, '
        'mapNameLangPtBR: $mapNameLangPtBR, '
        'mapNameLangItIT: $mapNameLangItIT, '
        'mapNameLangUnk1: $mapNameLangUnk1, '
        'mapNameLangUnk2: $mapNameLangUnk2, '
        'mapNameLangUnk3: $mapNameLangUnk3, '
        'mapNameLangFlags: $mapNameLangFlags, '
        'areaTableId: $areaTableId, '
        'mapDescription0LangEnUS: $mapDescription0LangEnUS, '
        'mapDescription0LangKoKR: $mapDescription0LangKoKR, '
        'mapDescription0LangFrFR: $mapDescription0LangFrFR, '
        'mapDescription0LangDeDE: $mapDescription0LangDeDE, '
        'mapDescription0LangZhCN: $mapDescription0LangZhCN, '
        'mapDescription0LangZhTW: $mapDescription0LangZhTW, '
        'mapDescription0LangEsES: $mapDescription0LangEsES, '
        'mapDescription0LangEsMX: $mapDescription0LangEsMX, '
        'mapDescription0LangRuRU: $mapDescription0LangRuRU, '
        'mapDescription0LangJaJP: $mapDescription0LangJaJP, '
        'mapDescription0LangPtPT: $mapDescription0LangPtPT, '
        'mapDescription0LangPtBR: $mapDescription0LangPtBR, '
        'mapDescription0LangItIT: $mapDescription0LangItIT, '
        'mapDescription0LangUnk1: $mapDescription0LangUnk1, '
        'mapDescription0LangUnk2: $mapDescription0LangUnk2, '
        'mapDescription0LangUnk3: $mapDescription0LangUnk3, '
        'mapDescription0LangFlags: $mapDescription0LangFlags, '
        'mapDescription1LangEnUS: $mapDescription1LangEnUS, '
        'mapDescription1LangKoKR: $mapDescription1LangKoKR, '
        'mapDescription1LangFrFR: $mapDescription1LangFrFR, '
        'mapDescription1LangDeDE: $mapDescription1LangDeDE, '
        'mapDescription1LangZhCN: $mapDescription1LangZhCN, '
        'mapDescription1LangZhTW: $mapDescription1LangZhTW, '
        'mapDescription1LangEsES: $mapDescription1LangEsES, '
        'mapDescription1LangEsMX: $mapDescription1LangEsMX, '
        'mapDescription1LangRuRU: $mapDescription1LangRuRU, '
        'mapDescription1LangJaJP: $mapDescription1LangJaJP, '
        'mapDescription1LangPtPT: $mapDescription1LangPtPT, '
        'mapDescription1LangPtBR: $mapDescription1LangPtBR, '
        'mapDescription1LangItIT: $mapDescription1LangItIT, '
        'mapDescription1LangUnk1: $mapDescription1LangUnk1, '
        'mapDescription1LangUnk2: $mapDescription1LangUnk2, '
        'mapDescription1LangUnk3: $mapDescription1LangUnk3, '
        'mapDescription1LangFlags: $mapDescription1LangFlags, '
        'loadingScreenId: $loadingScreenId, '
        'minimapIconScale: $minimapIconScale, '
        'corpseMapId: $corpseMapId, '
        'corpse0: $corpse0, '
        'corpse1: $corpse1, '
        'timeOfDayOverride: $timeOfDayOverride, '
        'expansionId: $expansionId, '
        'raidOffset: $raidOffset, '
        'maxPlayers: $maxPlayers'
        ')';
  }
}
