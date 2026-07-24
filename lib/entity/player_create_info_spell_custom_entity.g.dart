// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_spell_custom_entity.dart';

mixin _PlayerCreateInfoSpellCustomEntityMixin {
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
    final self = this as PlayerCreateInfoSpellCustomEntity;
    return PlayerCreateInfoSpellCustomEntity(
      raceMask: raceMask ?? self.raceMask,
      classMask: classMask ?? self.classMask,
      spell: spell ?? self.spell,
      note: note ?? self.note,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PlayerCreateInfoSpellCustomEntity;
    return {
      'racemask': self.raceMask,
      'classmask': self.classMask,
      'Spell': self.spell,
      'Note': self.note,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PlayerCreateInfoSpellCustomEntity;
    return identical(self, other) ||
        other is PlayerCreateInfoSpellCustomEntity &&
            self.runtimeType == other.runtimeType &&
            self.raceMask == other.raceMask &&
            self.classMask == other.classMask &&
            self.spell == other.spell &&
            self.note == other.note;
  }

  @override
  int get hashCode {
    final self = this as PlayerCreateInfoSpellCustomEntity;
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
    final self = this as PlayerCreateInfoSpellCustomEntity;
    return 'PlayerCreateInfoSpellCustomEntity('
        'raceMask: ${self.raceMask}, '
        'classMask: ${self.classMask}, '
        'spell: ${self.spell}, '
        'note: ${self.note}'
        ')';
  }
}

final class PlayerCreateInfoSpellCustomKey {
  final int raceMask;
  final int classMask;
  final int spell;

  const PlayerCreateInfoSpellCustomKey({
    required this.raceMask,
    required this.classMask,
    required this.spell,
  });

  factory PlayerCreateInfoSpellCustomKey.fromEntity(
    PlayerCreateInfoSpellCustomEntity entity,
  ) {
    return PlayerCreateInfoSpellCustomKey(
      raceMask: entity.raceMask,
      classMask: entity.classMask,
      spell: entity.spell,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoSpellCustomKey &&
            raceMask == other.raceMask &&
            classMask == other.classMask &&
            spell == other.spell;
  }

  @override
  int get hashCode => Object.hashAll([raceMask, classMask, spell]);

  @override
  String toString() {
    return 'PlayerCreateInfoSpellCustomKey('
        'raceMask: $raceMask, '
        'classMask: $classMask, '
        'spell: $spell'
        ')';
  }
}

final class BriefPlayerCreateInfoSpellCustomEntity {
  final int raceMask;
  final int classMask;
  final int spell;
  final String note;

  const BriefPlayerCreateInfoSpellCustomEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note = '',
  });

  factory BriefPlayerCreateInfoSpellCustomEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefPlayerCreateInfoSpellCustomEntity(
      raceMask: (json['racemask'] as num?)?.toInt() ?? 0,
      classMask: (json['classmask'] as num?)?.toInt() ?? 0,
      spell: (json['Spell'] as num?)?.toInt() ?? 0,
      note: json['Note']?.toString() ?? '',
    );
  }

  PlayerCreateInfoSpellCustomKey get key {
    return PlayerCreateInfoSpellCustomKey(
      raceMask: raceMask,
      classMask: classMask,
      spell: spell,
    );
  }
}
