// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
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
