// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class ScalingStatValueFilterEntity {
  final String id;
  final String charlevel;

  const ScalingStatValueFilterEntity({this.id = '', this.charlevel = ''});

  factory ScalingStatValueFilterEntity.fromJson(Map<String, dynamic> json) {
    return ScalingStatValueFilterEntity(
      id: json['id']?.toString() ?? '',
      charlevel: json['charlevel']?.toString() ?? '',
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
