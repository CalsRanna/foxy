// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visual_effect_entity.dart';

final class BriefItemVisualEffectEntity {
  final int id;
  final String model;

  const BriefItemVisualEffectEntity({this.id = 0, this.model = ''});

  factory BriefItemVisualEffectEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemVisualEffectEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      model: json['Model']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([id, model]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefItemVisualEffectEntity &&
            id == other.id &&
            model == other.model;
  }

  @override
  String toString() {
    return 'BriefItemVisualEffectEntity('
        'id: $id, '
        'model: $model'
        ')';
  }
}

mixin _ItemVisualEffectEntityMixin {
  @override
  int get hashCode {
    final self = this as ItemVisualEffectEntity;
    return Object.hashAll([self.runtimeType, self.id, self.model]);
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
  String toString() {
    final self = this as ItemVisualEffectEntity;
    return 'ItemVisualEffectEntity('
        'id: ${self.id}, '
        'model: ${self.model}'
        ')';
  }

  static ItemVisualEffectEntity fromJson(Map<String, dynamic> json) {
    return ItemVisualEffectEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      model: json['Model']?.toString() ?? '',
    );
  }
}
