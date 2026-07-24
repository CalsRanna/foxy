// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefAreaTableEntity {
  final int id;
  final int continentId;
  final int zoneMusic;
  final int explorationLevel;
  final String areaNameLangZhCN;
  final double minElevation;

  const BriefAreaTableEntity({
    this.id = 0,
    this.continentId = 0,
    this.zoneMusic = 0,
    this.explorationLevel = 0,
    this.areaNameLangZhCN = '',
    this.minElevation = 0.0,
  });

  factory BriefAreaTableEntity.fromJson(Map<String, dynamic> json) {
    return BriefAreaTableEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      continentId: (json['ContinentID'] as num?)?.toInt() ?? 0,
      zoneMusic: (json['ZoneMusic'] as num?)?.toInt() ?? 0,
      explorationLevel: (json['ExplorationLevel'] as num?)?.toInt() ?? 0,
      areaNameLangZhCN: json['AreaName_lang_zhCN']?.toString() ?? '',
      minElevation: (json['MinElevation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  int get key => id;
}
