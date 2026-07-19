import 'package:flutter/foundation.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';

@immutable
final class GameObjectQuestEnderKey {
  final int id;
  final int quest;

  const GameObjectQuestEnderKey({required this.id, required this.quest});

  factory GameObjectQuestEnderKey.fromEntity(GameObjectQuestEnderEntity value) {
    return GameObjectQuestEnderKey(id: value.id, quest: value.quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectQuestEnderKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode => Object.hash(id, quest);
}
