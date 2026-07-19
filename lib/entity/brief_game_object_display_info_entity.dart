class BriefGameObjectDisplayInfoEntity {
  final int id;
  final String modelName;

  const BriefGameObjectDisplayInfoEntity({this.id = 0, this.modelName = ''});

  factory BriefGameObjectDisplayInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectDisplayInfoEntity(
      id: json['ID'] ?? 0,
      modelName: json['ModelName'] ?? '',
    );
  }

  int get key => id;
}
