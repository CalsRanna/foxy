class ScalingStatDistributionFilterEntity {
  final String id;

  const ScalingStatDistributionFilterEntity({this.id = ''});

  factory ScalingStatDistributionFilterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return ScalingStatDistributionFilterEntity(id: json['id'] ?? '');
  }

  ScalingStatDistributionFilterEntity copyWith({String? id}) {
    return ScalingStatDistributionFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
