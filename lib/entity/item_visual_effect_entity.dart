class BriefItemVisualEffectEntity {
  final int id;
  final String model;

  const BriefItemVisualEffectEntity({this.id = 0, this.model = ''});

  factory BriefItemVisualEffectEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemVisualEffectEntity(
      id: json['ID'] ?? 0,
      model: json['Model'] ?? '',
    );
  }
}

class ItemVisualEffectEntity {
  final int id;
  final String model;

  const ItemVisualEffectEntity({this.id = 0, this.model = ''});

  factory ItemVisualEffectEntity.fromJson(Map<String, dynamic> json) {
    return ItemVisualEffectEntity(
      id: json['ID'] ?? 0,
      model: json['Model'] ?? '',
    );
  }

  ItemVisualEffectEntity copyWith({int? id, String? model}) {
    return ItemVisualEffectEntity(
      id: id ?? this.id,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toJson() => {'ID': id, 'Model': model};
}
