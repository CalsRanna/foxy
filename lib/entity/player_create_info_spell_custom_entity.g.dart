// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_spell_custom_entity.dart';

mixin _PlayerCreateInfoSpellCustomEntityMixin {
  int get raceMask;
  int get classMask;
  int get spell;
  String get note;

  static PlayerCreateInfoSpellCustomEntity fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoSpellCustomEntity(
      raceMask: (json['racemask'] as num?)?.toInt() ?? 0,
      classMask: (json['classmask'] as num?)?.toInt() ?? 0,
      spell: (json['Spell'] as num?)?.toInt() ?? 0,
      note: json['Note']?.toString() ?? '',
    );
  }

  PlayerCreateInfoSpellCustomEntity copyWith({
    int? raceMask,
    int? classMask,
    int? spell,
    String? note,
  }) {
    return PlayerCreateInfoSpellCustomEntity(
      raceMask: raceMask ?? this.raceMask,
      classMask: classMask ?? this.classMask,
      spell: spell ?? this.spell,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'racemask': raceMask,
      'classmask': classMask,
      'Spell': spell,
      'Note': note,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoSpellCustomEntity &&
            runtimeType == other.runtimeType &&
            raceMask == other.raceMask &&
            classMask == other.classMask &&
            spell == other.spell &&
            note == other.note;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, raceMask, classMask, spell, note]);
  }

  @override
  String toString() {
    return 'PlayerCreateInfoSpellCustomEntity('
        'raceMask: $raceMask, '
        'classMask: $classMask, '
        'spell: $spell, '
        'note: $note'
        ')';
  }
}
