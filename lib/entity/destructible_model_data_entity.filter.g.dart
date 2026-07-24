// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class DestructibleModelDataFilterEntity {
  final String id;

  const DestructibleModelDataFilterEntity({this.id = ''});

  factory DestructibleModelDataFilterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return DestructibleModelDataFilterEntity(id: json['id']?.toString() ?? '');
  }

  DestructibleModelDataFilterEntity copyWith({String? id}) {
    return DestructibleModelDataFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
