// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_ender_entity.dart';

mixin _GameObjectQuestEnderEntityMixin {
  static GameObjectQuestEnderEntity fromJson(Map<String, dynamic> json) {
    return GameObjectQuestEnderEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quest: (json['quest'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectQuestEnderEntity copyWith({int? id, int? quest}) {
    final self = this as GameObjectQuestEnderEntity;
    return GameObjectQuestEnderEntity(
      id: id ?? self.id,
      quest: quest ?? self.quest,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectQuestEnderEntity;
    return {'id': self.id, 'quest': self.quest};
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectQuestEnderEntity;
    return identical(self, other) ||
        other is GameObjectQuestEnderEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.quest == other.quest;
  }

  @override
  int get hashCode {
    final self = this as GameObjectQuestEnderEntity;
    return Object.hashAll([self.runtimeType, self.id, self.quest]);
  }

  @override
  String toString() {
    final self = this as GameObjectQuestEnderEntity;
    return 'GameObjectQuestEnderEntity('
        'id: ${self.id}, '
        'quest: ${self.quest}'
        ')';
  }
}
