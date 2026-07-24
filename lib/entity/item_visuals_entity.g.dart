// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visuals_entity.dart';

mixin _ItemVisualsEntityMixin {
  int get id;
  int get slot0;
  int get slot1;
  int get slot2;
  int get slot3;
  int get slot4;

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
    return ItemVisualsEntity(
      id: id ?? this.id,
      slot0: slot0 ?? this.slot0,
      slot1: slot1 ?? this.slot1,
      slot2: slot2 ?? this.slot2,
      slot3: slot3 ?? this.slot3,
      slot4: slot4 ?? this.slot4,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Slot0': slot0,
      'Slot1': slot1,
      'Slot2': slot2,
      'Slot3': slot3,
      'Slot4': slot4,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemVisualsEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            slot0 == other.slot0 &&
            slot1 == other.slot1 &&
            slot2 == other.slot2 &&
            slot3 == other.slot3 &&
            slot4 == other.slot4;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, slot0, slot1, slot2, slot3, slot4]);
  }

  @override
  String toString() {
    return 'ItemVisualsEntity('
        'id: $id, '
        'slot0: $slot0, '
        'slot1: $slot1, '
        'slot2: $slot2, '
        'slot3: $slot3, '
        'slot4: $slot4'
        ')';
  }
}
