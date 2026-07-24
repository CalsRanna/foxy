// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_starter_entity.dart';

mixin _CreatureQuestStarterEntityMixin {
  int get id;
  int get quest;

  static CreatureQuestStarterEntity fromJson(Map<String, dynamic> json) {
    return CreatureQuestStarterEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quest: (json['quest'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureQuestStarterEntity copyWith({int? id, int? quest}) {
    return CreatureQuestStarterEntity(
      id: id ?? this.id,
      quest: quest ?? this.quest,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureQuestStarterEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, quest]);
  }

  @override
  String toString() {
    return 'CreatureQuestStarterEntity('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}
