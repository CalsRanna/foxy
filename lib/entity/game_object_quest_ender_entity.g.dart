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
