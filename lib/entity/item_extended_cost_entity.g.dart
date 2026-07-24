// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_extended_cost_entity.dart';

mixin _ItemExtendedCostEntityMixin {
  static ItemExtendedCostEntity fromJson(Map<String, dynamic> json) {
    return ItemExtendedCostEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      honorPoints: (json['HonorPoints'] as num?)?.toInt() ?? 0,
      arenaPoints: (json['ArenaPoints'] as num?)?.toInt() ?? 0,
      arenaBracket: (json['ArenaBracket'] as num?)?.toInt() ?? 0,
      itemID0: (json['ItemID0'] as num?)?.toInt() ?? 0,
      itemID1: (json['ItemID1'] as num?)?.toInt() ?? 0,
      itemID2: (json['ItemID2'] as num?)?.toInt() ?? 0,
      itemID3: (json['ItemID3'] as num?)?.toInt() ?? 0,
      itemID4: (json['ItemID4'] as num?)?.toInt() ?? 0,
      itemCount0: (json['ItemCount0'] as num?)?.toInt() ?? 0,
      itemCount1: (json['ItemCount1'] as num?)?.toInt() ?? 0,
      itemCount2: (json['ItemCount2'] as num?)?.toInt() ?? 0,
      itemCount3: (json['ItemCount3'] as num?)?.toInt() ?? 0,
      itemCount4: (json['ItemCount4'] as num?)?.toInt() ?? 0,
      requiredArenaRating: (json['RequiredArenaRating'] as num?)?.toInt() ?? 0,
      itemPurchaseGroup: (json['ItemPurchaseGroup'] as num?)?.toInt() ?? 0,
    );
  }

  ItemExtendedCostEntity copyWith({
    int? id,
    int? honorPoints,
    int? arenaPoints,
    int? arenaBracket,
    int? itemID0,
    int? itemID1,
    int? itemID2,
    int? itemID3,
    int? itemID4,
    int? itemCount0,
    int? itemCount1,
    int? itemCount2,
    int? itemCount3,
    int? itemCount4,
    int? requiredArenaRating,
    int? itemPurchaseGroup,
  }) {
    final self = this as ItemExtendedCostEntity;
    return ItemExtendedCostEntity(
      id: id ?? self.id,
      honorPoints: honorPoints ?? self.honorPoints,
      arenaPoints: arenaPoints ?? self.arenaPoints,
      arenaBracket: arenaBracket ?? self.arenaBracket,
      itemID0: itemID0 ?? self.itemID0,
      itemID1: itemID1 ?? self.itemID1,
      itemID2: itemID2 ?? self.itemID2,
      itemID3: itemID3 ?? self.itemID3,
      itemID4: itemID4 ?? self.itemID4,
      itemCount0: itemCount0 ?? self.itemCount0,
      itemCount1: itemCount1 ?? self.itemCount1,
      itemCount2: itemCount2 ?? self.itemCount2,
      itemCount3: itemCount3 ?? self.itemCount3,
      itemCount4: itemCount4 ?? self.itemCount4,
      requiredArenaRating: requiredArenaRating ?? self.requiredArenaRating,
      itemPurchaseGroup: itemPurchaseGroup ?? self.itemPurchaseGroup,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemExtendedCostEntity;
    return {
      'ID': self.id,
      'HonorPoints': self.honorPoints,
      'ArenaPoints': self.arenaPoints,
      'ArenaBracket': self.arenaBracket,
      'ItemID0': self.itemID0,
      'ItemID1': self.itemID1,
      'ItemID2': self.itemID2,
      'ItemID3': self.itemID3,
      'ItemID4': self.itemID4,
      'ItemCount0': self.itemCount0,
      'ItemCount1': self.itemCount1,
      'ItemCount2': self.itemCount2,
      'ItemCount3': self.itemCount3,
      'ItemCount4': self.itemCount4,
      'RequiredArenaRating': self.requiredArenaRating,
      'ItemPurchaseGroup': self.itemPurchaseGroup,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemExtendedCostEntity;
    return identical(self, other) ||
        other is ItemExtendedCostEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.honorPoints == other.honorPoints &&
            self.arenaPoints == other.arenaPoints &&
            self.arenaBracket == other.arenaBracket &&
            self.itemID0 == other.itemID0 &&
            self.itemID1 == other.itemID1 &&
            self.itemID2 == other.itemID2 &&
            self.itemID3 == other.itemID3 &&
            self.itemID4 == other.itemID4 &&
            self.itemCount0 == other.itemCount0 &&
            self.itemCount1 == other.itemCount1 &&
            self.itemCount2 == other.itemCount2 &&
            self.itemCount3 == other.itemCount3 &&
            self.itemCount4 == other.itemCount4 &&
            self.requiredArenaRating == other.requiredArenaRating &&
            self.itemPurchaseGroup == other.itemPurchaseGroup;
  }

  @override
  int get hashCode {
    final self = this as ItemExtendedCostEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.honorPoints,
      self.arenaPoints,
      self.arenaBracket,
      self.itemID0,
      self.itemID1,
      self.itemID2,
      self.itemID3,
      self.itemID4,
      self.itemCount0,
      self.itemCount1,
      self.itemCount2,
      self.itemCount3,
      self.itemCount4,
      self.requiredArenaRating,
      self.itemPurchaseGroup,
    ]);
  }

  @override
  String toString() {
    final self = this as ItemExtendedCostEntity;
    return 'ItemExtendedCostEntity('
        'id: ${self.id}, '
        'honorPoints: ${self.honorPoints}, '
        'arenaPoints: ${self.arenaPoints}, '
        'arenaBracket: ${self.arenaBracket}, '
        'itemID0: ${self.itemID0}, '
        'itemID1: ${self.itemID1}, '
        'itemID2: ${self.itemID2}, '
        'itemID3: ${self.itemID3}, '
        'itemID4: ${self.itemID4}, '
        'itemCount0: ${self.itemCount0}, '
        'itemCount1: ${self.itemCount1}, '
        'itemCount2: ${self.itemCount2}, '
        'itemCount3: ${self.itemCount3}, '
        'itemCount4: ${self.itemCount4}, '
        'requiredArenaRating: ${self.requiredArenaRating}, '
        'itemPurchaseGroup: ${self.itemPurchaseGroup}'
        ')';
  }
}
