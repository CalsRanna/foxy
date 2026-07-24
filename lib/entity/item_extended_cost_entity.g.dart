// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_extended_cost_entity.dart';

mixin _ItemExtendedCostEntityMixin {
  int get id;
  int get honorPoints;
  int get arenaPoints;
  int get arenaBracket;
  int get itemID0;
  int get itemID1;
  int get itemID2;
  int get itemID3;
  int get itemID4;
  int get itemCount0;
  int get itemCount1;
  int get itemCount2;
  int get itemCount3;
  int get itemCount4;
  int get requiredArenaRating;
  int get itemPurchaseGroup;

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
    return ItemExtendedCostEntity(
      id: id ?? this.id,
      honorPoints: honorPoints ?? this.honorPoints,
      arenaPoints: arenaPoints ?? this.arenaPoints,
      arenaBracket: arenaBracket ?? this.arenaBracket,
      itemID0: itemID0 ?? this.itemID0,
      itemID1: itemID1 ?? this.itemID1,
      itemID2: itemID2 ?? this.itemID2,
      itemID3: itemID3 ?? this.itemID3,
      itemID4: itemID4 ?? this.itemID4,
      itemCount0: itemCount0 ?? this.itemCount0,
      itemCount1: itemCount1 ?? this.itemCount1,
      itemCount2: itemCount2 ?? this.itemCount2,
      itemCount3: itemCount3 ?? this.itemCount3,
      itemCount4: itemCount4 ?? this.itemCount4,
      requiredArenaRating: requiredArenaRating ?? this.requiredArenaRating,
      itemPurchaseGroup: itemPurchaseGroup ?? this.itemPurchaseGroup,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'HonorPoints': honorPoints,
      'ArenaPoints': arenaPoints,
      'ArenaBracket': arenaBracket,
      'ItemID0': itemID0,
      'ItemID1': itemID1,
      'ItemID2': itemID2,
      'ItemID3': itemID3,
      'ItemID4': itemID4,
      'ItemCount0': itemCount0,
      'ItemCount1': itemCount1,
      'ItemCount2': itemCount2,
      'ItemCount3': itemCount3,
      'ItemCount4': itemCount4,
      'RequiredArenaRating': requiredArenaRating,
      'ItemPurchaseGroup': itemPurchaseGroup,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemExtendedCostEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            honorPoints == other.honorPoints &&
            arenaPoints == other.arenaPoints &&
            arenaBracket == other.arenaBracket &&
            itemID0 == other.itemID0 &&
            itemID1 == other.itemID1 &&
            itemID2 == other.itemID2 &&
            itemID3 == other.itemID3 &&
            itemID4 == other.itemID4 &&
            itemCount0 == other.itemCount0 &&
            itemCount1 == other.itemCount1 &&
            itemCount2 == other.itemCount2 &&
            itemCount3 == other.itemCount3 &&
            itemCount4 == other.itemCount4 &&
            requiredArenaRating == other.requiredArenaRating &&
            itemPurchaseGroup == other.itemPurchaseGroup;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      honorPoints,
      arenaPoints,
      arenaBracket,
      itemID0,
      itemID1,
      itemID2,
      itemID3,
      itemID4,
      itemCount0,
      itemCount1,
      itemCount2,
      itemCount3,
      itemCount4,
      requiredArenaRating,
      itemPurchaseGroup,
    ]);
  }

  @override
  String toString() {
    return 'ItemExtendedCostEntity('
        'id: $id, '
        'honorPoints: $honorPoints, '
        'arenaPoints: $arenaPoints, '
        'arenaBracket: $arenaBracket, '
        'itemID0: $itemID0, '
        'itemID1: $itemID1, '
        'itemID2: $itemID2, '
        'itemID3: $itemID3, '
        'itemID4: $itemID4, '
        'itemCount0: $itemCount0, '
        'itemCount1: $itemCount1, '
        'itemCount2: $itemCount2, '
        'itemCount3: $itemCount3, '
        'itemCount4: $itemCount4, '
        'requiredArenaRating: $requiredArenaRating, '
        'itemPurchaseGroup: $itemPurchaseGroup'
        ')';
  }
}
