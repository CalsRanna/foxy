// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_cast_spell_entity.dart';

mixin _PlayerCreateInfoCastSpellEntityMixin {
  int get raceMask;
  int get classMask;
  int get spell;
  String? get note;

  static PlayerCreateInfoCastSpellEntity fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoCastSpellEntity(
      raceMask: (json['raceMask'] as num?)?.toInt() ?? 0,
      classMask: (json['classMask'] as num?)?.toInt() ?? 0,
      spell: (json['spell'] as num?)?.toInt() ?? 0,
      note: json['note']?.toString(),
    );
  }

  PlayerCreateInfoCastSpellEntity copyWith({
    int? raceMask,
    int? classMask,
    int? spell,
    String? note,
  }) {
    return PlayerCreateInfoCastSpellEntity(
      raceMask: raceMask ?? this.raceMask,
      classMask: classMask ?? this.classMask,
      spell: spell ?? this.spell,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'raceMask': raceMask,
      'classMask': classMask,
      'spell': spell,
      'note': note,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoCastSpellEntity &&
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
    return 'PlayerCreateInfoCastSpellEntity('
        'raceMask: $raceMask, '
        'classMask: $classMask, '
        'spell: $spell, '
        'note: $note'
        ')';
  }
}
