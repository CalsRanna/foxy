import 'package:foxy/entity/creature_display_info_key.dart';

/// 生物显示信息列表展示模型（含 LEFT JOIN 模型名）。
class BriefCreatureDisplayInfoEntity {
  final int id;
  final int modelId;
  final double creatureModelScale;
  final int sizeClass;
  final int bloodID;
  final String modelName;

  const BriefCreatureDisplayInfoEntity({
    this.id = 0,
    this.modelId = 0,
    this.creatureModelScale = 1.0,
    this.sizeClass = 0,
    this.bloodID = 0,
    this.modelName = '',
  });

  factory BriefCreatureDisplayInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureDisplayInfoEntity(
      id: json['ID'] ?? 0,
      modelId: json['ModelID'] ?? 0,
      creatureModelScale:
          (json['CreatureModelScale'] as num?)?.toDouble() ?? 1.0,
      sizeClass: json['SizeClass'] ?? 0,
      bloodID: json['BloodID'] ?? 0,
      modelName: json['ModelName'] ?? '',
    );
  }

  CreatureDisplayInfoKey get key => CreatureDisplayInfoKey(id: id);
}
