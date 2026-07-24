// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_linked_spell_entity.dart';

mixin _SpellLinkedSpellEntityMixin {
  int get spellTrigger;
  int get spellEffect;
  int get type;
  String get comment;

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
    return SpellLinkedSpellEntity(
      spellTrigger: spellTrigger ?? this.spellTrigger,
      spellEffect: spellEffect ?? this.spellEffect,
      type: type ?? this.type,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spell_trigger': spellTrigger,
      'spell_effect': spellEffect,
      'type': type,
      'comment': comment,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellLinkedSpellEntity &&
            runtimeType == other.runtimeType &&
            spellTrigger == other.spellTrigger &&
            spellEffect == other.spellEffect &&
            type == other.type &&
            comment == other.comment;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      spellTrigger,
      spellEffect,
      type,
      comment,
    ]);
  }

  @override
  String toString() {
    return 'SpellLinkedSpellEntity('
        'spellTrigger: $spellTrigger, '
        'spellEffect: $spellEffect, '
        'type: $type, '
        'comment: $comment'
        ')';
  }
}
