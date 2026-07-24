// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visual_effect_entity.dart';

mixin _ItemVisualEffectEntityMixin {
  static ItemVisualEffectEntity fromJson(Map<String, dynamic> json) {
    return ItemVisualEffectEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      model: json['Model']?.toString() ?? '',
    );
  }

  ItemVisualEffectEntity copyWith({int? id, String? model}) {
    final self = this as ItemVisualEffectEntity;
    return ItemVisualEffectEntity(
      id: id ?? self.id,
      model: model ?? self.model,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemVisualEffectEntity;
    return {'ID': self.id, 'Model': self.model};
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemVisualEffectEntity;
    return identical(self, other) ||
        other is ItemVisualEffectEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.model == other.model;
  }

  @override
  int get hashCode {
    final self = this as ItemVisualEffectEntity;
    return Object.hashAll([self.runtimeType, self.id, self.model]);
  }

  @override
  String toString() {
    final self = this as ItemVisualEffectEntity;
    return 'ItemVisualEffectEntity('
        'id: ${self.id}, '
        'model: ${self.model}'
        ')';
  }
}
