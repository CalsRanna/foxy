// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefDestructibleModelDataEntity {
  final int id;
  final int state1Wmo;
  final int state2Wmo;
  final int state3Wmo;

  const BriefDestructibleModelDataEntity({
    this.id = 0,
    this.state1Wmo = 0,
    this.state2Wmo = 0,
    this.state3Wmo = 0,
  });

  factory BriefDestructibleModelDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefDestructibleModelDataEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      state1Wmo: (json['State1WMO'] as num?)?.toInt() ?? 0,
      state2Wmo: (json['State2WMO'] as num?)?.toInt() ?? 0,
      state3Wmo: (json['State3WMO'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
