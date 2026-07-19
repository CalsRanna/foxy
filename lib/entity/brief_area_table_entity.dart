import 'package:foxy/entity/area_table_key.dart';

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

  AreaTableKey get key => AreaTableKey(id: id);
}
