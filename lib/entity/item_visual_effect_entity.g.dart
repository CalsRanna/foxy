// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visual_effect_entity.dart';

mixin _ItemVisualEffectEntityMixin {
  int get id;
  String get model;

  static ItemVisualEffectEntity fromJson(Map<String, dynamic> json) {
    return ItemVisualEffectEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      model: json['Model']?.toString() ?? '',
    );
  }

  ItemVisualEffectEntity copyWith({int? id, String? model}) {
    return ItemVisualEffectEntity(
      id: id ?? this.id,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Model': model};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemVisualEffectEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            model == other.model;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, model]);
  }

  @override
  String toString() {
    return 'ItemVisualEffectEntity('
        'id: $id, '
        'model: $model'
        ')';
  }
}
