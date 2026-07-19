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

  int get key => id;
}
