// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class ItemVisualsFilterEntity {
  final String id;

  const ItemVisualsFilterEntity({this.id = ''});

  factory ItemVisualsFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemVisualsFilterEntity(id: json['id']?.toString() ?? '');
  }

  ItemVisualsFilterEntity copyWith({String? id}) {
    return ItemVisualsFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
