// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class EmoteTextFilterEntity {
  final String id;
  final String name;

  const EmoteTextFilterEntity({this.id = '', this.name = ''});

  factory EmoteTextFilterEntity.fromJson(Map<String, dynamic> json) {
    return EmoteTextFilterEntity(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  EmoteTextFilterEntity copyWith({String? id, String? name}) {
    return EmoteTextFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
