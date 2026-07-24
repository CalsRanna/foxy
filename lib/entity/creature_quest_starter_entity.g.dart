// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_starter_entity.dart';

mixin _CreatureQuestStarterEntityMixin {
  static CreatureQuestStarterEntity fromJson(Map<String, dynamic> json) {
    return CreatureQuestStarterEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quest: (json['quest'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureQuestStarterEntity copyWith({int? id, int? quest}) {
    final self = this as CreatureQuestStarterEntity;
    return CreatureQuestStarterEntity(
      id: id ?? self.id,
      quest: quest ?? self.quest,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureQuestStarterEntity;
    return {'id': self.id, 'quest': self.quest};
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureQuestStarterEntity;
    return identical(self, other) ||
        other is CreatureQuestStarterEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.quest == other.quest;
  }

  @override
  int get hashCode {
    final self = this as CreatureQuestStarterEntity;
    return Object.hashAll([self.runtimeType, self.id, self.quest]);
  }

  @override
  String toString() {
    final self = this as CreatureQuestStarterEntity;
    return 'CreatureQuestStarterEntity('
        'id: ${self.id}, '
        'quest: ${self.quest}'
        ')';
  }
}

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
