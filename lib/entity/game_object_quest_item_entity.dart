class BriefGameObjectQuestItemEntity {
  final int gameObjectEntry;
  final int idx;
  final int itemId;
  final int verifiedBuild;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  const BriefGameObjectQuestItemEntity({
    this.gameObjectEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
  });

  factory BriefGameObjectQuestItemEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectQuestItemEntity(
      gameObjectEntry: json['GameObjectEntry'] ?? 0,
      idx: json['Idx'] ?? 0,
      itemId: json['ItemId'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
    );
  }

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;
}

class GameObjectQuestItemEntity {
  final int gameObjectEntry;
  final int idx;
  final int itemId;
  final int verifiedBuild;

  const GameObjectQuestItemEntity({
    this.gameObjectEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
  });

  factory GameObjectQuestItemEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectQuestItemEntity(
      gameObjectEntry: json['GameObjectEntry'] ?? 0,
      idx: json['Idx'] ?? 0,
      itemId: json['ItemId'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'GameObjectEntry': gameObjectEntry,
    'Idx': idx,
    'ItemId': itemId,
    'VerifiedBuild': verifiedBuild,
  };

  void validate() {
    if (gameObjectEntry <= 0) throw ArgumentError('游戏对象编号必须大于 0');
    if (idx < 0 || idx >= 6) throw ArgumentError('任务物品索引必须在 0..5');
    if (itemId <= 0) throw ArgumentError('物品 ID 必须大于 0');
  }

  GameObjectQuestItemEntity copyWith({
    int? gameObjectEntry,
    int? idx,
    int? itemId,
    int? verifiedBuild,
  }) {
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry ?? this.gameObjectEntry,
      idx: idx ?? this.idx,
      itemId: itemId ?? this.itemId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }
}
