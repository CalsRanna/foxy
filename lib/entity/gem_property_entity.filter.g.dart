// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class GemPropertyFilterEntity {
  final String id;

  const GemPropertyFilterEntity({this.id = ''});

  factory GemPropertyFilterEntity.fromJson(Map<String, dynamic> json) {
    return GemPropertyFilterEntity(id: json['id']?.toString() ?? '');
  }

  GemPropertyFilterEntity copyWith({String? id}) {
    return GemPropertyFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
