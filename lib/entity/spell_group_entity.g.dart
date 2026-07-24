// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_group_entity.dart';

mixin _SpellGroupEntityMixin {
  static SpellGroupEntity fromJson(Map<String, dynamic> json) {
    return SpellGroupEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      spellId: (json['spell_id'] as num?)?.toInt() ?? 0,
    );
  }

  SpellGroupEntity copyWith({int? id, int? spellId}) {
    final self = this as SpellGroupEntity;
    return SpellGroupEntity(
      id: id ?? self.id,
      spellId: spellId ?? self.spellId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellGroupEntity;
    return {'id': self.id, 'spell_id': self.spellId};
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellGroupEntity;
    return identical(self, other) ||
        other is SpellGroupEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.spellId == other.spellId;
  }

  @override
  int get hashCode {
    final self = this as SpellGroupEntity;
    return Object.hashAll([self.runtimeType, self.id, self.spellId]);
  }

  @override
  String toString() {
    final self = this as SpellGroupEntity;
    return 'SpellGroupEntity('
        'id: ${self.id}, '
        'spellId: ${self.spellId}'
        ')';
  }
}

final class SpellGroupKey {
  final int id;
  final int spellId;

  const SpellGroupKey({required this.id, required this.spellId});

  factory SpellGroupKey.fromEntity(SpellGroupEntity entity) {
    return SpellGroupKey(id: entity.id, spellId: entity.spellId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellGroupKey && id == other.id && spellId == other.spellId;
  }

  @override
  int get hashCode => Object.hashAll([id, spellId]);

  @override
  String toString() {
    return 'SpellGroupKey('
        'id: $id, '
        'spellId: $spellId'
        ')';
  }
}

final class BriefSpellGroupEntity {
  final int id;
  final int spellId;

  const BriefSpellGroupEntity({this.id = 0, this.spellId = 0});

  factory BriefSpellGroupEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellGroupEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      spellId: (json['spell_id'] as num?)?.toInt() ?? 0,
    );
  }

  SpellGroupKey get key {
    return SpellGroupKey(id: id, spellId: spellId);
  }
}
