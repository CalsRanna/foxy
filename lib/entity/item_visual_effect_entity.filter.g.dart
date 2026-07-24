// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class ItemVisualEffectFilterEntity {
  final String id;
  final String model;

  const ItemVisualEffectFilterEntity({this.id = '', this.model = ''});

  factory ItemVisualEffectFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemVisualEffectFilterEntity(
      id: json['id']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
    );
  }

  ItemVisualEffectFilterEntity copyWith({String? id, String? model}) {
    return ItemVisualEffectFilterEntity(
      id: id ?? this.id,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'model': model};
  }
}
