class ScalingStatValueFilterEntity {
  final String id;
  final String charlevel;

  const ScalingStatValueFilterEntity({this.id = '', this.charlevel = ''});

  factory ScalingStatValueFilterEntity.fromJson(Map<String, dynamic> json) {
    return ScalingStatValueFilterEntity(
      id: json['id'] ?? '',
      charlevel: json['charlevel'] ?? '',
    );
  }

  ScalingStatValueFilterEntity copyWith({String? id, String? charlevel}) {
    return ScalingStatValueFilterEntity(
      id: id ?? this.id,
      charlevel: charlevel ?? this.charlevel,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'charlevel': charlevel};
  }
}
