// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_starter_entity.dart';

mixin _GameObjectQuestStarterEntityMixin {
  int get id;
  int get quest;

  static GameObjectQuestStarterEntity fromJson(Map<String, dynamic> json) {
    return GameObjectQuestStarterEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quest: (json['quest'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectQuestStarterEntity copyWith({int? id, int? quest}) {
    return GameObjectQuestStarterEntity(
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
        other is GameObjectQuestStarterEntity &&
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
    return 'GameObjectQuestStarterEntity('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}
