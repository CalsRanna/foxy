class BriefCreatureModelDataEntity {
  final int id;
  final String modelName;
  final int sizeClass;
  final double modelScale;

  const BriefCreatureModelDataEntity({
    this.id = 0,
    this.modelName = '',
    this.sizeClass = 0,
    this.modelScale = 0,
  });

  factory BriefCreatureModelDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureModelDataEntity(
      id: json['ID'] ?? 0,
      modelName: json['ModelName'] ?? '',
      sizeClass: json['SizeClass'] ?? 0,
      modelScale: (json['ModelScale'] as num?)?.toDouble() ?? 0,
    );
  }

  int get key => id;
}
