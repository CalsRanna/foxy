// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'creature_quest_ender_entity.dart';

final class CreatureQuestEnderKey {
  final int id;
  final int quest;

  const CreatureQuestEnderKey({required this.id, required this.quest});

  factory CreatureQuestEnderKey.fromEntity(CreatureQuestEnderEntity entity) {
    return CreatureQuestEnderKey(id: entity.id, quest: entity.quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureQuestEnderKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode => Object.hashAll([id, quest]);

  @override
  String toString() {
    return 'CreatureQuestEnderKey('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}
