// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_item_entity.dart';

mixin _GameObjectQuestItemEntityMixin {
  int get gameObjectEntry;
  int get idx;
  int get itemId;
  int get verifiedBuild;

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
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry ?? this.gameObjectEntry,
      idx: idx ?? this.idx,
      itemId: itemId ?? this.itemId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GameObjectEntry': gameObjectEntry,
      'Idx': idx,
      'ItemId': itemId,
      'VerifiedBuild': verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectQuestItemEntity &&
            runtimeType == other.runtimeType &&
            gameObjectEntry == other.gameObjectEntry &&
            idx == other.idx &&
            itemId == other.itemId &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      gameObjectEntry,
      idx,
      itemId,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'GameObjectQuestItemEntity('
        'gameObjectEntry: $gameObjectEntry, '
        'idx: $idx, '
        'itemId: $itemId, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
