import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_quest_item_entity.dart';

@immutable
final class CreatureQuestItemKey {
  final int creatureEntry;
  final int idx;

  const CreatureQuestItemKey({required this.creatureEntry, required this.idx});

  factory CreatureQuestItemKey.fromEntity(CreatureQuestItemEntity value) {
    return CreatureQuestItemKey(
      creatureEntry: value.creatureEntry,
      idx: value.idx,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureQuestItemKey &&
            creatureEntry == other.creatureEntry &&
            idx == other.idx;
  }

  @override
  int get hashCode => Object.hash(creatureEntry, idx);
}
