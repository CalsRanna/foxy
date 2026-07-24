// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'creature_quest_starter_entity.dart';

final class CreatureQuestStarterKey {
  final int id;
  final int quest;

  const CreatureQuestStarterKey({required this.id, required this.quest});

  factory CreatureQuestStarterKey.fromEntity(
    CreatureQuestStarterEntity entity,
  ) {
    return CreatureQuestStarterKey(id: entity.id, quest: entity.quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureQuestStarterKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode => Object.hashAll([id, quest]);

  @override
  String toString() {
    return 'CreatureQuestStarterKey('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}
