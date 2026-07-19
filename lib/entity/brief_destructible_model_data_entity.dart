import 'package:foxy/entity/destructible_model_data_key.dart';

class BriefDestructibleModelDataEntity {
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

  factory BriefDestructibleModelDataEntity.fromJson(
    Map<String, dynamic> json,
  ) => BriefDestructibleModelDataEntity(
    id: json['ID'] ?? 0,
    state1Wmo: json['State1WMO'] ?? 0,
    state2Wmo: json['State2WMO'] ?? 0,
    state3Wmo: json['State3WMO'] ?? 0,
  );

  DestructibleModelDataKey get key => DestructibleModelDataKey(id: id);
}
