// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class ItemRandomPropertiesFilterEntity {
  final String id;
  final String name;

  const ItemRandomPropertiesFilterEntity({this.id = '', this.name = ''});

  factory ItemRandomPropertiesFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemRandomPropertiesFilterEntity(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemRandomPropertiesFilterEntity copyWith({String? id, String? name}) {
    return ItemRandomPropertiesFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
