class CreatureQuestItemEntity {
  final int creatureEntry;
  final int idx;
  final int itemId;
  final int verifiedBuild;
  const CreatureQuestItemEntity({
    this.creatureEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureQuestItemEntity.fromJson(Map<String, dynamic> json) {
    return CreatureQuestItemEntity(
      creatureEntry: json['CreatureEntry'] ?? json['creatureEntry'] ?? 0,
      idx: json['Idx'] ?? json['idx'] ?? 0,
      itemId: json['ItemId'] ?? json['itemId'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
    );
  }

  CreatureQuestItemEntity copyWith({
    int? creatureEntry,
    int? idx,
    int? itemId,
    int? verifiedBuild,
  }) {
    return CreatureQuestItemEntity(
      creatureEntry: creatureEntry ?? this.creatureEntry,
      idx: idx ?? this.idx,
      itemId: itemId ?? this.itemId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
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
