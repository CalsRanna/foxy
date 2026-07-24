// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'game_object_quest_starter_entity.dart';

final class GameObjectQuestStarterKey {
  final int id;
  final int quest;

  const GameObjectQuestStarterKey({required this.id, required this.quest});

  factory GameObjectQuestStarterKey.fromEntity(
    GameObjectQuestStarterEntity entity,
  ) {
    return GameObjectQuestStarterKey(id: entity.id, quest: entity.quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectQuestStarterKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode => Object.hashAll([id, quest]);

  @override
  String toString() {
    return 'GameObjectQuestStarterKey('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}
