// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class LiquidTypeFilterEntity {
  final String id;
  final String name;

  const LiquidTypeFilterEntity({this.id = '', this.name = ''});

  factory LiquidTypeFilterEntity.fromJson(Map<String, dynamic> json) {
    return LiquidTypeFilterEntity(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  LiquidTypeFilterEntity copyWith({String? id, String? name}) {
    return LiquidTypeFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
