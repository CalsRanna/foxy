// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_ender_entity.dart';

mixin _CreatureQuestEnderEntityMixin {
  int get id;
  int get quest;

  static CreatureQuestEnderEntity fromJson(Map<String, dynamic> json) {
    return CreatureQuestEnderEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quest: (json['quest'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureQuestEnderEntity copyWith({int? id, int? quest}) {
    return CreatureQuestEnderEntity(
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
        other is CreatureQuestEnderEntity &&
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
    return 'CreatureQuestEnderEntity('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}
