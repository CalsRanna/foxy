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

  Map<String, dynamic> toJson() => {
    'GameObjectEntry': gameObjectEntry,
    'Idx': idx,
    'ItemId': itemId,
    'VerifiedBuild': verifiedBuild,
  };
}
