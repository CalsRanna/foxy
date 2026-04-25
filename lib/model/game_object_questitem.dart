class GameObjectQuestItem {
  int gameObjectEntry = 0;
  int idx = 0;
  int itemId = 0;
  int verifiedBuild = 0;

  String itemName = '';
  String itemLocaleName = '';
  int itemQuality = 0;
  String itemIcon = '';

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  GameObjectQuestItem();

  GameObjectQuestItem.fromJson(Map<String, dynamic> json) {
    gameObjectEntry = json['GameObjectEntry'] ?? json['gameObjectEntry'] ?? 0;
    idx = json['Idx'] ?? json['idx'] ?? 0;
    itemId = json['ItemId'] ?? json['itemId'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0;
    itemName = json['name'] ?? '';
    itemLocaleName = json['localeName'] ?? '';
    itemQuality = json['Quality'] ?? 0;
    itemIcon = json['InventoryIcon_1'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'GameObjectEntry': gameObjectEntry,
      'Idx': idx,
      'ItemId': itemId,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
