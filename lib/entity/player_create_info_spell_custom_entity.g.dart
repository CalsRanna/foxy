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
