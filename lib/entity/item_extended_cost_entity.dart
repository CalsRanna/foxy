/// 扩展价格
class ItemExtendedCostEntity {
  final int id;
  final int honorPoints;
  final int arenaPoints;
  final int arenaBracket;
  final int itemID0;
  final int itemID1;
  final int itemID2;
  final int itemID3;
  final int itemID4;
  final int itemCount0;
  final int itemCount1;
  final int itemCount2;
  final int itemCount3;
  final int itemCount4;
  final int requiredArenaRating;
  final int itemPurchaseGroup;

  const ItemExtendedCostEntity({
    this.id = 0,
    this.honorPoints = 0,
    this.arenaPoints = 0,
    this.arenaBracket = 0,
    this.itemID0 = 0,
    this.itemID1 = 0,
    this.itemID2 = 0,
    this.itemID3 = 0,
    this.itemID4 = 0,
    this.itemCount0 = 0,
    this.itemCount1 = 0,
    this.itemCount2 = 0,
    this.itemCount3 = 0,
    this.itemCount4 = 0,
    this.requiredArenaRating = 0,
    this.itemPurchaseGroup = 0,
  });

  factory ItemExtendedCostEntity.fromJson(Map<String, dynamic> json) {
    return ItemExtendedCostEntity(
      id: json['ID'] ?? json['id'] ?? 0,
      honorPoints: json['HonorPoints'] ?? json['honorPoints'] ?? 0,
      arenaPoints: json['ArenaPoints'] ?? json['arenaPoints'] ?? 0,
      arenaBracket: json['ArenaBracket'] ?? json['arenaBracket'] ?? 0,
      itemID0: json['ItemID0'] ?? 0,
      itemID1: json['ItemID1'] ?? 0,
      itemID2: json['ItemID2'] ?? 0,
      itemID3: json['ItemID3'] ?? 0,
      itemID4: json['ItemID4'] ?? 0,
      itemCount0: json['ItemCount0'] ?? 0,
      itemCount1: json['ItemCount1'] ?? 0,
      itemCount2: json['ItemCount2'] ?? 0,
      itemCount3: json['ItemCount3'] ?? 0,
      itemCount4: json['ItemCount4'] ?? 0,
      requiredArenaRating: json['RequiredArenaRating'] ?? 0,
      itemPurchaseGroup: json['ItemPurchaseGroup'] ?? 0,
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

  String get displayItems {
    final ids = [itemID0, itemID1, itemID2, itemID3, itemID4];
    final counts = [itemCount0, itemCount1, itemCount2, itemCount3, itemCount4];
    final parts = <String>[];
    for (var i = 0; i < 5; i++) {
      if (ids[i] != 0) {
        parts.add('${ids[i]}x${counts[i]}');
      }
    }
    return parts.isEmpty ? '-' : parts.join(', ');
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
}
