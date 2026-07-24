// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_ender_entity.dart';

mixin _CreatureQuestEnderEntityMixin {
  static CreatureQuestEnderEntity fromJson(Map<String, dynamic> json) {
    return CreatureQuestEnderEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quest: (json['quest'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureQuestEnderEntity copyWith({int? id, int? quest}) {
    final self = this as CreatureQuestEnderEntity;
    return CreatureQuestEnderEntity(
      id: id ?? self.id,
      quest: quest ?? self.quest,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureQuestEnderEntity;
    return {'id': self.id, 'quest': self.quest};
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureQuestEnderEntity;
    return identical(self, other) ||
        other is CreatureQuestEnderEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.quest == other.quest;
  }

  @override
  int get hashCode {
    final self = this as CreatureQuestEnderEntity;
    return Object.hashAll([self.runtimeType, self.id, self.quest]);
  }

  @override
  String toString() {
    final self = this as CreatureQuestEnderEntity;
    return 'CreatureQuestEnderEntity('
        'id: ${self.id}, '
        'quest: ${self.quest}'
        ')';
  }
}
