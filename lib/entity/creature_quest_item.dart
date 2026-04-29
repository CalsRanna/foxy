class CreatureQuestItem {
  final int creatureEntry;
  final int idx;
  final int itemId;
  final int verifiedBuild;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  const CreatureQuestItem({
    this.creatureEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
  });

  factory CreatureQuestItem.fromJson(Map<String, dynamic> json) {
    return CreatureQuestItem(
      creatureEntry: json['CreatureEntry'] ?? json['creatureEntry'] ?? 0,
      idx: json['Idx'] ?? json['idx'] ?? 0,
      itemId: json['ItemId'] ?? json['itemId'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CreatureEntry': creatureEntry,
      'Idx': idx,
      'ItemId': itemId,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
