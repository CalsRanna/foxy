// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class SpellDurationFilterEntity {
  final String id;

  const SpellDurationFilterEntity({this.id = ''});

  factory SpellDurationFilterEntity.fromJson(Map<String, dynamic> json) {
    return SpellDurationFilterEntity(id: json['id']?.toString() ?? '');
  }

  SpellDurationFilterEntity copyWith({String? id}) {
    return SpellDurationFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
