// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'game_object_quest_item_entity.dart';

final class GameObjectQuestItemKey {
  final int gameObjectEntry;
  final int idx;

  const GameObjectQuestItemKey({
    required this.gameObjectEntry,
    required this.idx,
  });

  factory GameObjectQuestItemKey.fromEntity(GameObjectQuestItemEntity entity) {
    return GameObjectQuestItemKey(
      gameObjectEntry: entity.gameObjectEntry,
      idx: entity.idx,
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
  int get hashCode => Object.hashAll([gameObjectEntry, idx]);

  @override
  String toString() {
    return 'GameObjectQuestItemKey('
        'gameObjectEntry: $gameObjectEntry, '
        'idx: $idx'
        ')';
  }
}
