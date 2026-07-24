// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_linked_spell_entity.dart';

mixin _SpellLinkedSpellEntityMixin {
  static SpellLinkedSpellEntity fromJson(Map<String, dynamic> json) {
    return SpellLinkedSpellEntity(
      spellTrigger: (json['spell_trigger'] as num?)?.toInt() ?? 0,
      spellEffect: (json['spell_effect'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      comment: json['comment']?.toString() ?? '',
    );
  }

  SpellLinkedSpellEntity copyWith({
    int? spellTrigger,
    int? spellEffect,
    int? type,
    String? comment,
  }) {
    final self = this as SpellLinkedSpellEntity;
    return SpellLinkedSpellEntity(
      spellTrigger: spellTrigger ?? self.spellTrigger,
      spellEffect: spellEffect ?? self.spellEffect,
      type: type ?? self.type,
      comment: comment ?? self.comment,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellLinkedSpellEntity;
    return {
      'spell_trigger': self.spellTrigger,
      'spell_effect': self.spellEffect,
      'type': self.type,
      'comment': self.comment,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellLinkedSpellEntity;
    return identical(self, other) ||
        other is SpellLinkedSpellEntity &&
            self.runtimeType == other.runtimeType &&
            self.spellTrigger == other.spellTrigger &&
            self.spellEffect == other.spellEffect &&
            self.type == other.type &&
            self.comment == other.comment;
  }

  @override
  int get hashCode {
    final self = this as SpellLinkedSpellEntity;
    return Object.hashAll([
      self.runtimeType,
      self.spellTrigger,
      self.spellEffect,
      self.type,
      self.comment,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellLinkedSpellEntity;
    return 'SpellLinkedSpellEntity('
        'spellTrigger: ${self.spellTrigger}, '
        'spellEffect: ${self.spellEffect}, '
        'type: ${self.type}, '
        'comment: ${self.comment}'
        ')';
  }
}

final class SpellLinkedSpellKey {
  final int spellTrigger;
  final int spellEffect;
  final int type;

  const SpellLinkedSpellKey({
    required this.spellTrigger,
    required this.spellEffect,
    required this.type,
  });

  factory SpellLinkedSpellKey.fromEntity(SpellLinkedSpellEntity entity) {
    return SpellLinkedSpellKey(
      spellTrigger: entity.spellTrigger,
      spellEffect: entity.spellEffect,
      type: entity.type,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellLinkedSpellKey &&
            spellTrigger == other.spellTrigger &&
            spellEffect == other.spellEffect &&
            type == other.type;
  }

  @override
  int get hashCode => Object.hashAll([spellTrigger, spellEffect, type]);

  @override
  String toString() {
    return 'SpellLinkedSpellKey('
        'spellTrigger: $spellTrigger, '
        'spellEffect: $spellEffect, '
        'type: $type'
        ')';
  }
}

final class BriefSpellLinkedSpellEntity {
  final int spellTrigger;
  final int spellEffect;
  final int type;
  final String comment;

  const BriefSpellLinkedSpellEntity({
    this.spellTrigger = 0,
    this.spellEffect = 0,
    this.type = 0,
    this.comment = '',
  });

  factory BriefSpellLinkedSpellEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellLinkedSpellEntity(
      spellTrigger: (json['spell_trigger'] as num?)?.toInt() ?? 0,
      spellEffect: (json['spell_effect'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      comment: json['comment']?.toString() ?? '',
    );
  }

  SpellLinkedSpellKey get key {
    return SpellLinkedSpellKey(
      spellTrigger: spellTrigger,
      spellEffect: spellEffect,
      type: type,
    );
  }
}
