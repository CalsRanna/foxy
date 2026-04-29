/// 扩展价格
class ItemExtendedCost {
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

  const ItemExtendedCost({
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

  factory ItemExtendedCost.fromJson(Map<String, dynamic> json) {
    return ItemExtendedCost(
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
}
