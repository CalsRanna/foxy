import 'package:flutter/foundation.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';

@immutable
final class GameObjectQuestItemKey {
  final int gameObjectEntry;
  final int idx;

  const GameObjectQuestItemKey({
    required this.gameObjectEntry,
    required this.idx,
  });

  factory GameObjectQuestItemKey.fromEntity(GameObjectQuestItemEntity value) {
    return GameObjectQuestItemKey(
      gameObjectEntry: value.gameObjectEntry,
      idx: value.idx,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectQuestItemKey &&
            gameObjectEntry == other.gameObjectEntry &&
            idx == other.idx;
  }

  @override
  int get hashCode => Object.hash(gameObjectEntry, idx);
}
