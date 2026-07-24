// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visual_effect_repository.dart';

final class ItemVisualEffectFilter {
  final String id;
  final String model;

  const ItemVisualEffectFilter({this.id = '', this.model = ''});

  factory ItemVisualEffectFilter.fromJson(Map<String, dynamic> json) {
    return ItemVisualEffectFilter(
      id: json['id']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
    );
  }

  ItemVisualEffectFilter copyWith({String? id, String? model}) {
    return ItemVisualEffectFilter(
      id: id ?? this.id,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'model': model};
  }
}
