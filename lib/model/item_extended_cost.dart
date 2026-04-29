/// 扩展价格
class ItemExtendedCost {
  int id = 0;
  int honorPoints = 0;
  int arenaPoints = 0;
  int arenaBracket = 0;
  int itemID0 = 0;
  int itemID1 = 0;
  int itemID2 = 0;
  int itemID3 = 0;
  int itemID4 = 0;
  int itemCount0 = 0;
  int itemCount1 = 0;
  int itemCount2 = 0;
  int itemCount3 = 0;
  int itemCount4 = 0;
  int requiredArenaRating = 0;
  int itemPurchaseGroup = 0;

  ItemExtendedCost();

  factory ItemExtendedCost.fromJson(Map<String, dynamic> json) {
    return ItemExtendedCost()
      ..id = json['ID'] ?? json['id'] ?? 0
      ..honorPoints = json['HonorPoints'] ?? json['honorPoints'] ?? 0
      ..arenaPoints = json['ArenaPoints'] ?? json['arenaPoints'] ?? 0
      ..arenaBracket = json['ArenaBracket'] ?? json['arenaBracket'] ?? 0
      ..itemID0 = json['ItemID0'] ?? 0
      ..itemID1 = json['ItemID1'] ?? 0
      ..itemID2 = json['ItemID2'] ?? 0
      ..itemID3 = json['ItemID3'] ?? 0
      ..itemID4 = json['ItemID4'] ?? 0
      ..itemCount0 = json['ItemCount0'] ?? 0
      ..itemCount1 = json['ItemCount1'] ?? 0
      ..itemCount2 = json['ItemCount2'] ?? 0
      ..itemCount3 = json['ItemCount3'] ?? 0
      ..itemCount4 = json['ItemCount4'] ?? 0
      ..requiredArenaRating = json['RequiredArenaRating'] ?? 0
      ..itemPurchaseGroup = json['ItemPurchaseGroup'] ?? 0;
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
