class CreatureQuestItemEntity {
  final int creatureEntry;
  final int idx;
  final int itemId;
  final int verifiedBuild;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  const CreatureQuestItemEntity({
    this.creatureEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
  });

  factory CreatureQuestItemEntity.fromJson(Map<String, dynamic> json) {
    return CreatureQuestItemEntity(
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

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  CreatureQuestItemEntity copyWith({
    int? creatureEntry,
    int? idx,
    int? itemId,
    int? verifiedBuild,
    String? itemName,
    String? itemLocaleName,
    int? itemQuality,
    String? itemIcon,
  }) {
    return CreatureQuestItemEntity(
      creatureEntry: creatureEntry ?? this.creatureEntry,
      idx: idx ?? this.idx,
      itemId: itemId ?? this.itemId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
      itemName: itemName ?? this.itemName,
      itemLocaleName: itemLocaleName ?? this.itemLocaleName,
      itemQuality: itemQuality ?? this.itemQuality,
      itemIcon: itemIcon ?? this.itemIcon,
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
