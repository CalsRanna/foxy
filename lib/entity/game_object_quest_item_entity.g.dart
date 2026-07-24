// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_item_entity.dart';

mixin _GameObjectQuestItemEntityMixin {
  static GameObjectQuestItemEntity fromJson(Map<String, dynamic> json) {
    return GameObjectQuestItemEntity(
      gameObjectEntry: (json['GameObjectEntry'] as num?)?.toInt() ?? 0,
      idx: (json['Idx'] as num?)?.toInt() ?? 0,
      itemId: (json['ItemId'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectQuestItemEntity copyWith({
    int? gameObjectEntry,
    int? idx,
    int? itemId,
    int? verifiedBuild,
  }) {
    final self = this as GameObjectQuestItemEntity;
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry ?? self.gameObjectEntry,
      idx: idx ?? self.idx,
      itemId: itemId ?? self.itemId,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectQuestItemEntity;
    return {
      'GameObjectEntry': self.gameObjectEntry,
      'Idx': self.idx,
      'ItemId': self.itemId,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectQuestItemEntity;
    return identical(self, other) ||
        other is GameObjectQuestItemEntity &&
            self.runtimeType == other.runtimeType &&
            self.gameObjectEntry == other.gameObjectEntry &&
            self.idx == other.idx &&
            self.itemId == other.itemId &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as GameObjectQuestItemEntity;
    return Object.hashAll([
      self.runtimeType,
      self.gameObjectEntry,
      self.idx,
      self.itemId,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as GameObjectQuestItemEntity;
    return 'GameObjectQuestItemEntity('
        'gameObjectEntry: ${self.gameObjectEntry}, '
        'idx: ${self.idx}, '
        'itemId: ${self.itemId}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}
