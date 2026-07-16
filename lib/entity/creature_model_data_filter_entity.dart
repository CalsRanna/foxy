class CreatureModelDataFilterEntity {
  final String id;
  final String modelName;

  const CreatureModelDataFilterEntity({this.id = '', this.modelName = ''});

  factory CreatureModelDataFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureModelDataFilterEntity(
      id: json['id'] ?? '',
      modelName: json['modelName'] ?? '',
    );
  }

  CreatureModelDataFilterEntity copyWith({String? id, String? modelName}) {
    return CreatureModelDataFilterEntity(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}
