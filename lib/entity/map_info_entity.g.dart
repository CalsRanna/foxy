// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_info_entity.dart';

mixin _MapInfoEntityMixin {
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
    final self = this as MapInfoEntity;
    return MapInfoEntity(
      id: id ?? self.id,
      directory: directory ?? self.directory,
      instanceType: instanceType ?? self.instanceType,
      flags: flags ?? self.flags,
      pvp: pvp ?? self.pvp,
      mapNameLangEnUS: mapNameLangEnUS ?? self.mapNameLangEnUS,
      mapNameLangKoKR: mapNameLangKoKR ?? self.mapNameLangKoKR,
      mapNameLangFrFR: mapNameLangFrFR ?? self.mapNameLangFrFR,
      mapNameLangDeDE: mapNameLangDeDE ?? self.mapNameLangDeDE,
      mapNameLangZhCN: mapNameLangZhCN ?? self.mapNameLangZhCN,
      mapNameLangZhTW: mapNameLangZhTW ?? self.mapNameLangZhTW,
      mapNameLangEsES: mapNameLangEsES ?? self.mapNameLangEsES,
      mapNameLangEsMX: mapNameLangEsMX ?? self.mapNameLangEsMX,
      mapNameLangRuRU: mapNameLangRuRU ?? self.mapNameLangRuRU,
      mapNameLangJaJP: mapNameLangJaJP ?? self.mapNameLangJaJP,
      mapNameLangPtPT: mapNameLangPtPT ?? self.mapNameLangPtPT,
      mapNameLangPtBR: mapNameLangPtBR ?? self.mapNameLangPtBR,
      mapNameLangItIT: mapNameLangItIT ?? self.mapNameLangItIT,
      mapNameLangUnk1: mapNameLangUnk1 ?? self.mapNameLangUnk1,
      mapNameLangUnk2: mapNameLangUnk2 ?? self.mapNameLangUnk2,
      mapNameLangUnk3: mapNameLangUnk3 ?? self.mapNameLangUnk3,
      mapNameLangFlags: mapNameLangFlags ?? self.mapNameLangFlags,
      areaTableId: areaTableId ?? self.areaTableId,
      mapDescription0LangEnUS:
          mapDescription0LangEnUS ?? self.mapDescription0LangEnUS,
      mapDescription0LangKoKR:
          mapDescription0LangKoKR ?? self.mapDescription0LangKoKR,
      mapDescription0LangFrFR:
          mapDescription0LangFrFR ?? self.mapDescription0LangFrFR,
      mapDescription0LangDeDE:
          mapDescription0LangDeDE ?? self.mapDescription0LangDeDE,
      mapDescription0LangZhCN:
          mapDescription0LangZhCN ?? self.mapDescription0LangZhCN,
      mapDescription0LangZhTW:
          mapDescription0LangZhTW ?? self.mapDescription0LangZhTW,
      mapDescription0LangEsES:
          mapDescription0LangEsES ?? self.mapDescription0LangEsES,
      mapDescription0LangEsMX:
          mapDescription0LangEsMX ?? self.mapDescription0LangEsMX,
      mapDescription0LangRuRU:
          mapDescription0LangRuRU ?? self.mapDescription0LangRuRU,
      mapDescription0LangJaJP:
          mapDescription0LangJaJP ?? self.mapDescription0LangJaJP,
      mapDescription0LangPtPT:
          mapDescription0LangPtPT ?? self.mapDescription0LangPtPT,
      mapDescription0LangPtBR:
          mapDescription0LangPtBR ?? self.mapDescription0LangPtBR,
      mapDescription0LangItIT:
          mapDescription0LangItIT ?? self.mapDescription0LangItIT,
      mapDescription0LangUnk1:
          mapDescription0LangUnk1 ?? self.mapDescription0LangUnk1,
      mapDescription0LangUnk2:
          mapDescription0LangUnk2 ?? self.mapDescription0LangUnk2,
      mapDescription0LangUnk3:
          mapDescription0LangUnk3 ?? self.mapDescription0LangUnk3,
      mapDescription0LangFlags:
          mapDescription0LangFlags ?? self.mapDescription0LangFlags,
      mapDescription1LangEnUS:
          mapDescription1LangEnUS ?? self.mapDescription1LangEnUS,
      mapDescription1LangKoKR:
          mapDescription1LangKoKR ?? self.mapDescription1LangKoKR,
      mapDescription1LangFrFR:
          mapDescription1LangFrFR ?? self.mapDescription1LangFrFR,
      mapDescription1LangDeDE:
          mapDescription1LangDeDE ?? self.mapDescription1LangDeDE,
      mapDescription1LangZhCN:
          mapDescription1LangZhCN ?? self.mapDescription1LangZhCN,
      mapDescription1LangZhTW:
          mapDescription1LangZhTW ?? self.mapDescription1LangZhTW,
      mapDescription1LangEsES:
          mapDescription1LangEsES ?? self.mapDescription1LangEsES,
      mapDescription1LangEsMX:
          mapDescription1LangEsMX ?? self.mapDescription1LangEsMX,
      mapDescription1LangRuRU:
          mapDescription1LangRuRU ?? self.mapDescription1LangRuRU,
      mapDescription1LangJaJP:
          mapDescription1LangJaJP ?? self.mapDescription1LangJaJP,
      mapDescription1LangPtPT:
          mapDescription1LangPtPT ?? self.mapDescription1LangPtPT,
      mapDescription1LangPtBR:
          mapDescription1LangPtBR ?? self.mapDescription1LangPtBR,
      mapDescription1LangItIT:
          mapDescription1LangItIT ?? self.mapDescription1LangItIT,
      mapDescription1LangUnk1:
          mapDescription1LangUnk1 ?? self.mapDescription1LangUnk1,
      mapDescription1LangUnk2:
          mapDescription1LangUnk2 ?? self.mapDescription1LangUnk2,
      mapDescription1LangUnk3:
          mapDescription1LangUnk3 ?? self.mapDescription1LangUnk3,
      mapDescription1LangFlags:
          mapDescription1LangFlags ?? self.mapDescription1LangFlags,
      loadingScreenId: loadingScreenId ?? self.loadingScreenId,
      minimapIconScale: minimapIconScale ?? self.minimapIconScale,
      corpseMapId: corpseMapId ?? self.corpseMapId,
      corpse0: corpse0 ?? self.corpse0,
      corpse1: corpse1 ?? self.corpse1,
      timeOfDayOverride: timeOfDayOverride ?? self.timeOfDayOverride,
      expansionId: expansionId ?? self.expansionId,
      raidOffset: raidOffset ?? self.raidOffset,
      maxPlayers: maxPlayers ?? self.maxPlayers,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as MapInfoEntity;
    return {
      'ID': self.id,
      'Directory': self.directory,
      'InstanceType': self.instanceType,
      'Flags': self.flags,
      'PVP': self.pvp,
      'MapName_lang_enUS': self.mapNameLangEnUS,
      'MapName_lang_koKR': self.mapNameLangKoKR,
      'MapName_lang_frFR': self.mapNameLangFrFR,
      'MapName_lang_deDE': self.mapNameLangDeDE,
      'MapName_lang_zhCN': self.mapNameLangZhCN,
      'MapName_lang_zhTW': self.mapNameLangZhTW,
      'MapName_lang_esES': self.mapNameLangEsES,
      'MapName_lang_esMX': self.mapNameLangEsMX,
      'MapName_lang_ruRU': self.mapNameLangRuRU,
      'MapName_lang_jaJP': self.mapNameLangJaJP,
      'MapName_lang_ptPT': self.mapNameLangPtPT,
      'MapName_lang_ptBR': self.mapNameLangPtBR,
      'MapName_lang_itIT': self.mapNameLangItIT,
      'MapName_lang_unk1': self.mapNameLangUnk1,
      'MapName_lang_unk2': self.mapNameLangUnk2,
      'MapName_lang_unk3': self.mapNameLangUnk3,
      'MapName_lang_Flags': self.mapNameLangFlags,
      'AreaTableID': self.areaTableId,
      'MapDescription0_lang_enUS': self.mapDescription0LangEnUS,
      'MapDescription0_lang_koKR': self.mapDescription0LangKoKR,
      'MapDescription0_lang_frFR': self.mapDescription0LangFrFR,
      'MapDescription0_lang_deDE': self.mapDescription0LangDeDE,
      'MapDescription0_lang_zhCN': self.mapDescription0LangZhCN,
      'MapDescription0_lang_zhTW': self.mapDescription0LangZhTW,
      'MapDescription0_lang_esES': self.mapDescription0LangEsES,
      'MapDescription0_lang_esMX': self.mapDescription0LangEsMX,
      'MapDescription0_lang_ruRU': self.mapDescription0LangRuRU,
      'MapDescription0_lang_jaJP': self.mapDescription0LangJaJP,
      'MapDescription0_lang_ptPT': self.mapDescription0LangPtPT,
      'MapDescription0_lang_ptBR': self.mapDescription0LangPtBR,
      'MapDescription0_lang_itIT': self.mapDescription0LangItIT,
      'MapDescription0_lang_unk1': self.mapDescription0LangUnk1,
      'MapDescription0_lang_unk2': self.mapDescription0LangUnk2,
      'MapDescription0_lang_unk3': self.mapDescription0LangUnk3,
      'MapDescription0_lang_Flags': self.mapDescription0LangFlags,
      'MapDescription1_lang_enUS': self.mapDescription1LangEnUS,
      'MapDescription1_lang_koKR': self.mapDescription1LangKoKR,
      'MapDescription1_lang_frFR': self.mapDescription1LangFrFR,
      'MapDescription1_lang_deDE': self.mapDescription1LangDeDE,
      'MapDescription1_lang_zhCN': self.mapDescription1LangZhCN,
      'MapDescription1_lang_zhTW': self.mapDescription1LangZhTW,
      'MapDescription1_lang_esES': self.mapDescription1LangEsES,
      'MapDescription1_lang_esMX': self.mapDescription1LangEsMX,
      'MapDescription1_lang_ruRU': self.mapDescription1LangRuRU,
      'MapDescription1_lang_jaJP': self.mapDescription1LangJaJP,
      'MapDescription1_lang_ptPT': self.mapDescription1LangPtPT,
      'MapDescription1_lang_ptBR': self.mapDescription1LangPtBR,
      'MapDescription1_lang_itIT': self.mapDescription1LangItIT,
      'MapDescription1_lang_unk1': self.mapDescription1LangUnk1,
      'MapDescription1_lang_unk2': self.mapDescription1LangUnk2,
      'MapDescription1_lang_unk3': self.mapDescription1LangUnk3,
      'MapDescription1_lang_Flags': self.mapDescription1LangFlags,
      'LoadingScreenID': self.loadingScreenId,
      'MinimapIconScale': self.minimapIconScale,
      'CorpseMapID': self.corpseMapId,
      'Corpse0': self.corpse0,
      'Corpse1': self.corpse1,
      'TimeOfDayOverride': self.timeOfDayOverride,
      'ExpansionID': self.expansionId,
      'RaidOffset': self.raidOffset,
      'MaxPlayers': self.maxPlayers,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as MapInfoEntity;
    return identical(self, other) ||
        other is MapInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.directory == other.directory &&
            self.instanceType == other.instanceType &&
            self.flags == other.flags &&
            self.pvp == other.pvp &&
            self.mapNameLangEnUS == other.mapNameLangEnUS &&
            self.mapNameLangKoKR == other.mapNameLangKoKR &&
            self.mapNameLangFrFR == other.mapNameLangFrFR &&
            self.mapNameLangDeDE == other.mapNameLangDeDE &&
            self.mapNameLangZhCN == other.mapNameLangZhCN &&
            self.mapNameLangZhTW == other.mapNameLangZhTW &&
            self.mapNameLangEsES == other.mapNameLangEsES &&
            self.mapNameLangEsMX == other.mapNameLangEsMX &&
            self.mapNameLangRuRU == other.mapNameLangRuRU &&
            self.mapNameLangJaJP == other.mapNameLangJaJP &&
            self.mapNameLangPtPT == other.mapNameLangPtPT &&
            self.mapNameLangPtBR == other.mapNameLangPtBR &&
            self.mapNameLangItIT == other.mapNameLangItIT &&
            self.mapNameLangUnk1 == other.mapNameLangUnk1 &&
            self.mapNameLangUnk2 == other.mapNameLangUnk2 &&
            self.mapNameLangUnk3 == other.mapNameLangUnk3 &&
            self.mapNameLangFlags == other.mapNameLangFlags &&
            self.areaTableId == other.areaTableId &&
            self.mapDescription0LangEnUS == other.mapDescription0LangEnUS &&
            self.mapDescription0LangKoKR == other.mapDescription0LangKoKR &&
            self.mapDescription0LangFrFR == other.mapDescription0LangFrFR &&
            self.mapDescription0LangDeDE == other.mapDescription0LangDeDE &&
            self.mapDescription0LangZhCN == other.mapDescription0LangZhCN &&
            self.mapDescription0LangZhTW == other.mapDescription0LangZhTW &&
            self.mapDescription0LangEsES == other.mapDescription0LangEsES &&
            self.mapDescription0LangEsMX == other.mapDescription0LangEsMX &&
            self.mapDescription0LangRuRU == other.mapDescription0LangRuRU &&
            self.mapDescription0LangJaJP == other.mapDescription0LangJaJP &&
            self.mapDescription0LangPtPT == other.mapDescription0LangPtPT &&
            self.mapDescription0LangPtBR == other.mapDescription0LangPtBR &&
            self.mapDescription0LangItIT == other.mapDescription0LangItIT &&
            self.mapDescription0LangUnk1 == other.mapDescription0LangUnk1 &&
            self.mapDescription0LangUnk2 == other.mapDescription0LangUnk2 &&
            self.mapDescription0LangUnk3 == other.mapDescription0LangUnk3 &&
            self.mapDescription0LangFlags == other.mapDescription0LangFlags &&
            self.mapDescription1LangEnUS == other.mapDescription1LangEnUS &&
            self.mapDescription1LangKoKR == other.mapDescription1LangKoKR &&
            self.mapDescription1LangFrFR == other.mapDescription1LangFrFR &&
            self.mapDescription1LangDeDE == other.mapDescription1LangDeDE &&
            self.mapDescription1LangZhCN == other.mapDescription1LangZhCN &&
            self.mapDescription1LangZhTW == other.mapDescription1LangZhTW &&
            self.mapDescription1LangEsES == other.mapDescription1LangEsES &&
            self.mapDescription1LangEsMX == other.mapDescription1LangEsMX &&
            self.mapDescription1LangRuRU == other.mapDescription1LangRuRU &&
            self.mapDescription1LangJaJP == other.mapDescription1LangJaJP &&
            self.mapDescription1LangPtPT == other.mapDescription1LangPtPT &&
            self.mapDescription1LangPtBR == other.mapDescription1LangPtBR &&
            self.mapDescription1LangItIT == other.mapDescription1LangItIT &&
            self.mapDescription1LangUnk1 == other.mapDescription1LangUnk1 &&
            self.mapDescription1LangUnk2 == other.mapDescription1LangUnk2 &&
            self.mapDescription1LangUnk3 == other.mapDescription1LangUnk3 &&
            self.mapDescription1LangFlags == other.mapDescription1LangFlags &&
            self.loadingScreenId == other.loadingScreenId &&
            self.minimapIconScale == other.minimapIconScale &&
            self.corpseMapId == other.corpseMapId &&
            self.corpse0 == other.corpse0 &&
            self.corpse1 == other.corpse1 &&
            self.timeOfDayOverride == other.timeOfDayOverride &&
            self.expansionId == other.expansionId &&
            self.raidOffset == other.raidOffset &&
            self.maxPlayers == other.maxPlayers;
  }

  @override
  int get hashCode {
    final self = this as MapInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.directory,
      self.instanceType,
      self.flags,
      self.pvp,
      self.mapNameLangEnUS,
      self.mapNameLangKoKR,
      self.mapNameLangFrFR,
      self.mapNameLangDeDE,
      self.mapNameLangZhCN,
      self.mapNameLangZhTW,
      self.mapNameLangEsES,
      self.mapNameLangEsMX,
      self.mapNameLangRuRU,
      self.mapNameLangJaJP,
      self.mapNameLangPtPT,
      self.mapNameLangPtBR,
      self.mapNameLangItIT,
      self.mapNameLangUnk1,
      self.mapNameLangUnk2,
      self.mapNameLangUnk3,
      self.mapNameLangFlags,
      self.areaTableId,
      self.mapDescription0LangEnUS,
      self.mapDescription0LangKoKR,
      self.mapDescription0LangFrFR,
      self.mapDescription0LangDeDE,
      self.mapDescription0LangZhCN,
      self.mapDescription0LangZhTW,
      self.mapDescription0LangEsES,
      self.mapDescription0LangEsMX,
      self.mapDescription0LangRuRU,
      self.mapDescription0LangJaJP,
      self.mapDescription0LangPtPT,
      self.mapDescription0LangPtBR,
      self.mapDescription0LangItIT,
      self.mapDescription0LangUnk1,
      self.mapDescription0LangUnk2,
      self.mapDescription0LangUnk3,
      self.mapDescription0LangFlags,
      self.mapDescription1LangEnUS,
      self.mapDescription1LangKoKR,
      self.mapDescription1LangFrFR,
      self.mapDescription1LangDeDE,
      self.mapDescription1LangZhCN,
      self.mapDescription1LangZhTW,
      self.mapDescription1LangEsES,
      self.mapDescription1LangEsMX,
      self.mapDescription1LangRuRU,
      self.mapDescription1LangJaJP,
      self.mapDescription1LangPtPT,
      self.mapDescription1LangPtBR,
      self.mapDescription1LangItIT,
      self.mapDescription1LangUnk1,
      self.mapDescription1LangUnk2,
      self.mapDescription1LangUnk3,
      self.mapDescription1LangFlags,
      self.loadingScreenId,
      self.minimapIconScale,
      self.corpseMapId,
      self.corpse0,
      self.corpse1,
      self.timeOfDayOverride,
      self.expansionId,
      self.raidOffset,
      self.maxPlayers,
    ]);
  }

  @override
  String toString() {
    final self = this as MapInfoEntity;
    return 'MapInfoEntity('
        'id: ${self.id}, '
        'directory: ${self.directory}, '
        'instanceType: ${self.instanceType}, '
        'flags: ${self.flags}, '
        'pvp: ${self.pvp}, '
        'mapNameLangEnUS: ${self.mapNameLangEnUS}, '
        'mapNameLangKoKR: ${self.mapNameLangKoKR}, '
        'mapNameLangFrFR: ${self.mapNameLangFrFR}, '
        'mapNameLangDeDE: ${self.mapNameLangDeDE}, '
        'mapNameLangZhCN: ${self.mapNameLangZhCN}, '
        'mapNameLangZhTW: ${self.mapNameLangZhTW}, '
        'mapNameLangEsES: ${self.mapNameLangEsES}, '
        'mapNameLangEsMX: ${self.mapNameLangEsMX}, '
        'mapNameLangRuRU: ${self.mapNameLangRuRU}, '
        'mapNameLangJaJP: ${self.mapNameLangJaJP}, '
        'mapNameLangPtPT: ${self.mapNameLangPtPT}, '
        'mapNameLangPtBR: ${self.mapNameLangPtBR}, '
        'mapNameLangItIT: ${self.mapNameLangItIT}, '
        'mapNameLangUnk1: ${self.mapNameLangUnk1}, '
        'mapNameLangUnk2: ${self.mapNameLangUnk2}, '
        'mapNameLangUnk3: ${self.mapNameLangUnk3}, '
        'mapNameLangFlags: ${self.mapNameLangFlags}, '
        'areaTableId: ${self.areaTableId}, '
        'mapDescription0LangEnUS: ${self.mapDescription0LangEnUS}, '
        'mapDescription0LangKoKR: ${self.mapDescription0LangKoKR}, '
        'mapDescription0LangFrFR: ${self.mapDescription0LangFrFR}, '
        'mapDescription0LangDeDE: ${self.mapDescription0LangDeDE}, '
        'mapDescription0LangZhCN: ${self.mapDescription0LangZhCN}, '
        'mapDescription0LangZhTW: ${self.mapDescription0LangZhTW}, '
        'mapDescription0LangEsES: ${self.mapDescription0LangEsES}, '
        'mapDescription0LangEsMX: ${self.mapDescription0LangEsMX}, '
        'mapDescription0LangRuRU: ${self.mapDescription0LangRuRU}, '
        'mapDescription0LangJaJP: ${self.mapDescription0LangJaJP}, '
        'mapDescription0LangPtPT: ${self.mapDescription0LangPtPT}, '
        'mapDescription0LangPtBR: ${self.mapDescription0LangPtBR}, '
        'mapDescription0LangItIT: ${self.mapDescription0LangItIT}, '
        'mapDescription0LangUnk1: ${self.mapDescription0LangUnk1}, '
        'mapDescription0LangUnk2: ${self.mapDescription0LangUnk2}, '
        'mapDescription0LangUnk3: ${self.mapDescription0LangUnk3}, '
        'mapDescription0LangFlags: ${self.mapDescription0LangFlags}, '
        'mapDescription1LangEnUS: ${self.mapDescription1LangEnUS}, '
        'mapDescription1LangKoKR: ${self.mapDescription1LangKoKR}, '
        'mapDescription1LangFrFR: ${self.mapDescription1LangFrFR}, '
        'mapDescription1LangDeDE: ${self.mapDescription1LangDeDE}, '
        'mapDescription1LangZhCN: ${self.mapDescription1LangZhCN}, '
        'mapDescription1LangZhTW: ${self.mapDescription1LangZhTW}, '
        'mapDescription1LangEsES: ${self.mapDescription1LangEsES}, '
        'mapDescription1LangEsMX: ${self.mapDescription1LangEsMX}, '
        'mapDescription1LangRuRU: ${self.mapDescription1LangRuRU}, '
        'mapDescription1LangJaJP: ${self.mapDescription1LangJaJP}, '
        'mapDescription1LangPtPT: ${self.mapDescription1LangPtPT}, '
        'mapDescription1LangPtBR: ${self.mapDescription1LangPtBR}, '
        'mapDescription1LangItIT: ${self.mapDescription1LangItIT}, '
        'mapDescription1LangUnk1: ${self.mapDescription1LangUnk1}, '
        'mapDescription1LangUnk2: ${self.mapDescription1LangUnk2}, '
        'mapDescription1LangUnk3: ${self.mapDescription1LangUnk3}, '
        'mapDescription1LangFlags: ${self.mapDescription1LangFlags}, '
        'loadingScreenId: ${self.loadingScreenId}, '
        'minimapIconScale: ${self.minimapIconScale}, '
        'corpseMapId: ${self.corpseMapId}, '
        'corpse0: ${self.corpse0}, '
        'corpse1: ${self.corpse1}, '
        'timeOfDayOverride: ${self.timeOfDayOverride}, '
        'expansionId: ${self.expansionId}, '
        'raidOffset: ${self.raidOffset}, '
        'maxPlayers: ${self.maxPlayers}'
        ')';
  }
}

final class BriefMapInfoEntity {
  final int id;
  final int instanceType;
  final int pvp;
  final String mapNameLangZhCN;

  const BriefMapInfoEntity({
    this.id = 0,
    this.instanceType = 0,
    this.pvp = 0,
    this.mapNameLangZhCN = '',
  });

  factory BriefMapInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefMapInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      instanceType: (json['InstanceType'] as num?)?.toInt() ?? 0,
      pvp: (json['PVP'] as num?)?.toInt() ?? 0,
      mapNameLangZhCN: json['MapName_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
