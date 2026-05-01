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

  Map<String, dynamic> toJson() {
    return {'id': id, 'charlevel': charlevel};
  }
}
