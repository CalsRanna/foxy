// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'game_object_quest_ender_entity.dart';

final class GameObjectQuestEnderKey {
  final int id;
  final int quest;

  const GameObjectQuestEnderKey({required this.id, required this.quest});

  factory GameObjectQuestEnderKey.fromEntity(
    GameObjectQuestEnderEntity entity,
  ) {
    return GameObjectQuestEnderKey(id: entity.id, quest: entity.quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectQuestEnderKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode => Object.hashAll([id, quest]);

  @override
  String toString() {
    return 'GameObjectQuestEnderKey('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}
