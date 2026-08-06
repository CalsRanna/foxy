// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_ender_entity.dart';

final class BriefCreatureQuestEnderEntity {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefCreatureQuestEnderEntity({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefCreatureQuestEnderEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureQuestEnderEntity(
      id: json['id'] == true
          ? 1
          : json['id'] == false
          ? 0
          : (json['id'] as num?)?.toInt() ?? 0,
      quest: json['quest'] == true
          ? 1
          : json['quest'] == false
          ? 0
          : (json['quest'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['localeName']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([id, quest, name, localeName]);

  CreatureQuestEnderKey get key {
    return CreatureQuestEnderKey(id: id, quest: quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefCreatureQuestEnderEntity &&
            id == other.id &&
            quest == other.quest &&
            name == other.name &&
            localeName == other.localeName;
  }

  @override
  String toString() {
    return 'BriefCreatureQuestEnderEntity('
        'id: $id, '
        'quest: $quest, '
        'name: $name, '
        'localeName: $localeName'
        ')';
  }
}

final class CreatureQuestEnderKey {
  final int id;
  final int quest;

  const CreatureQuestEnderKey({required this.id, required this.quest});

  factory CreatureQuestEnderKey.fromEntity(CreatureQuestEnderEntity entity) {
    return CreatureQuestEnderKey(id: entity.id, quest: entity.quest);
  }

  @override
  int get hashCode => Object.hashAll([id, quest]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureQuestEnderKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  String toString() {
    return 'CreatureQuestEnderKey('
        'id: $id, '
        'quest: $quest'
        ')';
  }
}

mixin _CreatureQuestEnderEntityMixin {
  @override
  int get hashCode {
    final self = this as CreatureQuestEnderEntity;
    return Object.hashAll([self.runtimeType, self.id, self.quest]);
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
  String toString() {
    final self = this as CreatureQuestEnderEntity;
    return 'CreatureQuestEnderEntity('
        'id: ${self.id}, '
        'quest: ${self.quest}'
        ')';
  }

  static CreatureQuestEnderEntity fromJson(Map<String, dynamic> json) {
    return CreatureQuestEnderEntity(
      id: json['id'] == true
          ? 1
          : json['id'] == false
          ? 0
          : (json['id'] as num?)?.toInt() ?? 0,
      quest: json['quest'] == true
          ? 1
          : json['quest'] == false
          ? 0
          : (json['quest'] as num?)?.toInt() ?? 0,
    );
  }
}
