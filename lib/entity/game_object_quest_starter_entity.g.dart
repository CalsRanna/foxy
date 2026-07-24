// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_starter_entity.dart';

mixin _GameObjectQuestStarterEntityMixin {
  static GameObjectQuestStarterEntity fromJson(Map<String, dynamic> json) {
    return GameObjectQuestStarterEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quest: (json['quest'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectQuestStarterEntity copyWith({int? id, int? quest}) {
    final self = this as GameObjectQuestStarterEntity;
    return GameObjectQuestStarterEntity(
      id: id ?? self.id,
      quest: quest ?? self.quest,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectQuestStarterEntity;
    return {'id': self.id, 'quest': self.quest};
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectQuestStarterEntity;
    return identical(self, other) ||
        other is GameObjectQuestStarterEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.quest == other.quest;
  }

  @override
  int get hashCode {
    final self = this as GameObjectQuestStarterEntity;
    return Object.hashAll([self.runtimeType, self.id, self.quest]);
  }

  @override
  String toString() {
    final self = this as GameObjectQuestStarterEntity;
    return 'GameObjectQuestStarterEntity('
        'id: ${self.id}, '
        'quest: ${self.quest}'
        ')';
  }
}

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
