class CreatureDisplayInfoFilterEntity {
  final String id;
  final String modelName;

  const CreatureDisplayInfoFilterEntity({this.id = '', this.modelName = ''});

  factory CreatureDisplayInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfoFilterEntity(
      id: json['id'] ?? '',
      modelName: json['modelName'] ?? '',
    );
  }

  CreatureDisplayInfoFilterEntity copyWith({String? id, String? modelName}) {
    return CreatureDisplayInfoFilterEntity(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}
