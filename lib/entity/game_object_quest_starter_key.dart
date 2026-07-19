import 'package:flutter/foundation.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';

@immutable
final class GameObjectQuestStarterKey {
  final int id;
  final int quest;

  const GameObjectQuestStarterKey({required this.id, required this.quest});

  factory GameObjectQuestStarterKey.fromEntity(
    GameObjectQuestStarterEntity value,
  ) {
    return GameObjectQuestStarterKey(id: value.id, quest: value.quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectQuestStarterKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode => Object.hash(id, quest);
}
