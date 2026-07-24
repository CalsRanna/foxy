// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_cast_spell_entity.dart';

mixin _PlayerCreateInfoCastSpellEntityMixin {
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
    final self = this as PlayerCreateInfoCastSpellEntity;
    return PlayerCreateInfoCastSpellEntity(
      raceMask: raceMask ?? self.raceMask,
      classMask: classMask ?? self.classMask,
      spell: spell ?? self.spell,
      note: note ?? self.note,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PlayerCreateInfoCastSpellEntity;
    return {
      'raceMask': self.raceMask,
      'classMask': self.classMask,
      'spell': self.spell,
      'note': self.note,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PlayerCreateInfoCastSpellEntity;
    return identical(self, other) ||
        other is PlayerCreateInfoCastSpellEntity &&
            self.runtimeType == other.runtimeType &&
            self.raceMask == other.raceMask &&
            self.classMask == other.classMask &&
            self.spell == other.spell &&
            self.note == other.note;
  }

  @override
  int get hashCode {
    final self = this as PlayerCreateInfoCastSpellEntity;
    return Object.hashAll([
      self.runtimeType,
      self.raceMask,
      self.classMask,
      self.spell,
      self.note,
    ]);
  }

  @override
  String toString() {
    final self = this as PlayerCreateInfoCastSpellEntity;
    return 'PlayerCreateInfoCastSpellEntity('
        'raceMask: ${self.raceMask}, '
        'classMask: ${self.classMask}, '
        'spell: ${self.spell}, '
        'note: ${self.note}'
        ')';
  }
}

final class PlayerCreateInfoCastSpellKey {
  final int raceMask;
  final int classMask;
  final int spell;
  final String? note;

  const PlayerCreateInfoCastSpellKey({
    required this.raceMask,
    required this.classMask,
    required this.spell,
    required this.note,
  });

  factory PlayerCreateInfoCastSpellKey.fromEntity(
    PlayerCreateInfoCastSpellEntity entity,
  ) {
    return PlayerCreateInfoCastSpellKey(
      raceMask: entity.raceMask,
      classMask: entity.classMask,
      spell: entity.spell,
      note: entity.note,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoCastSpellKey &&
            raceMask == other.raceMask &&
            classMask == other.classMask &&
            spell == other.spell &&
            note == other.note;
  }

  @override
  int get hashCode => Object.hashAll([raceMask, classMask, spell, note]);

  @override
  String toString() {
    return 'PlayerCreateInfoCastSpellKey('
        'raceMask: $raceMask, '
        'classMask: $classMask, '
        'spell: $spell, '
        'note: $note'
        ')';
  }
}

final class BriefPlayerCreateInfoCastSpellEntity {
  final int raceMask;
  final int classMask;
  final int spell;
  final String? note;

  const BriefPlayerCreateInfoCastSpellEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note,
  });

  factory BriefPlayerCreateInfoCastSpellEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefPlayerCreateInfoCastSpellEntity(
      raceMask: (json['raceMask'] as num?)?.toInt() ?? 0,
      classMask: (json['classMask'] as num?)?.toInt() ?? 0,
      spell: (json['spell'] as num?)?.toInt() ?? 0,
      note: json['note']?.toString(),
    );
  }

  PlayerCreateInfoCastSpellKey get key {
    return PlayerCreateInfoCastSpellKey(
      raceMask: raceMask,
      classMask: classMask,
      spell: spell,
      note: note,
    );
  }
}
