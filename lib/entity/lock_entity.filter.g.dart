// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class LockFilterEntity {
  final String id;

  const LockFilterEntity({this.id = ''});

  factory LockFilterEntity.fromJson(Map<String, dynamic> json) {
    return LockFilterEntity(id: json['id']?.toString() ?? '');
  }

  LockFilterEntity copyWith({String? id}) {
    return LockFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
