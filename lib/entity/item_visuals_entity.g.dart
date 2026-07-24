// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visuals_entity.dart';

mixin _ItemVisualsEntityMixin {
  static ItemVisualsEntity fromJson(Map<String, dynamic> json) {
    return ItemVisualsEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      slot0: (json['Slot0'] as num?)?.toInt() ?? 0,
      slot1: (json['Slot1'] as num?)?.toInt() ?? 0,
      slot2: (json['Slot2'] as num?)?.toInt() ?? 0,
      slot3: (json['Slot3'] as num?)?.toInt() ?? 0,
      slot4: (json['Slot4'] as num?)?.toInt() ?? 0,
    );
  }

  ItemVisualsEntity copyWith({
    int? id,
    int? slot0,
    int? slot1,
    int? slot2,
    int? slot3,
    int? slot4,
  }) {
    final self = this as ItemVisualsEntity;
    return ItemVisualsEntity(
      id: id ?? self.id,
      slot0: slot0 ?? self.slot0,
      slot1: slot1 ?? self.slot1,
      slot2: slot2 ?? self.slot2,
      slot3: slot3 ?? self.slot3,
      slot4: slot4 ?? self.slot4,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemVisualsEntity;
    return {
      'ID': self.id,
      'Slot0': self.slot0,
      'Slot1': self.slot1,
      'Slot2': self.slot2,
      'Slot3': self.slot3,
      'Slot4': self.slot4,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemVisualsEntity;
    return identical(self, other) ||
        other is ItemVisualsEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.slot0 == other.slot0 &&
            self.slot1 == other.slot1 &&
            self.slot2 == other.slot2 &&
            self.slot3 == other.slot3 &&
            self.slot4 == other.slot4;
  }

  @override
  int get hashCode {
    final self = this as ItemVisualsEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.slot0,
      self.slot1,
      self.slot2,
      self.slot3,
      self.slot4,
    ]);
  }

  @override
  String toString() {
    final self = this as ItemVisualsEntity;
    return 'ItemVisualsEntity('
        'id: ${self.id}, '
        'slot0: ${self.slot0}, '
        'slot1: ${self.slot1}, '
        'slot2: ${self.slot2}, '
        'slot3: ${self.slot3}, '
        'slot4: ${self.slot4}'
        ')';
  }
}
