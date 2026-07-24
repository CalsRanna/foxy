// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_ender_entity.dart';

mixin _GameObjectQuestEnderEntityMixin {
  int get id;
  int get quest;

  static GameObjectQuestEnderEntity fromJson(Map<String, dynamic> json) {
    return GameObjectQuestEnderEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quest: (json['quest'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectQuestEnderEntity copyWith({int? id, int? quest}) {
    return GameObjectQuestEnderEntity(
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
        other is GameObjectQuestEnderEntity &&
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
    return 'GameObjectQuestEnderEntity('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}
