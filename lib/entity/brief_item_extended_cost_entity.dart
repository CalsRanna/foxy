String _appendDisplayItem(String current, int itemId, int count) {
  if (itemId == 0) return current;
  final value = '${itemId}x$count';
  return current.isEmpty ? value : '$current, $value';
}

class BriefItemExtendedCostEntity {
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

  const BriefItemExtendedCostEntity({
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
  });

  factory BriefItemExtendedCostEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemExtendedCostEntity(
      id: json['ID'] ?? 0,
      honorPoints: json['HonorPoints'] ?? 0,
      arenaPoints: json['ArenaPoints'] ?? 0,
      arenaBracket: json['ArenaBracket'] ?? 0,
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
    );
  }

  int get key => id;

  String get displayItems {
    var result = '';
    result = _appendDisplayItem(result, itemID0, itemCount0);
    result = _appendDisplayItem(result, itemID1, itemCount1);
    result = _appendDisplayItem(result, itemID2, itemCount2);
    result = _appendDisplayItem(result, itemID3, itemCount3);
    result = _appendDisplayItem(result, itemID4, itemCount4);
    return result.isEmpty ? '-' : result;
  }
}
