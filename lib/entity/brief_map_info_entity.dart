import 'package:foxy/entity/map_info_key.dart';

class BriefMapInfoEntity {
  final int id;
  final String mapNameLangZhCN;
  final int instanceType;
  final int pvp;

  const BriefMapInfoEntity({
    this.id = 0,
    this.mapNameLangZhCN = '',
    this.instanceType = 0,
    this.pvp = 0,
  });

  factory BriefMapInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefMapInfoEntity(
      id: json['ID'] ?? 0,
      mapNameLangZhCN: json['MapName_lang_zhCN'] ?? '',
      instanceType: json['InstanceType'] ?? 0,
      pvp: json['PVP'] ?? 0,
    );
  }

  MapInfoKey get key => MapInfoKey(id: id);
}
