// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_spell_entity.dart';

mixin _CreatureTemplateSpellEntityMixin {
  static CreatureTemplateSpellEntity fromJson(Map<String, dynamic> json) {
    return CreatureTemplateSpellEntity(
      creatureID: (json['CreatureID'] as num?)?.toInt() ?? 0,
      index: (json['Index'] as num?)?.toInt() ?? 0,
      spell: (json['Spell'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureTemplateSpellEntity copyWith({
    int? creatureID,
    int? index,
    int? spell,
    int? verifiedBuild,
  }) {
    final self = this as CreatureTemplateSpellEntity;
    return CreatureTemplateSpellEntity(
      creatureID: creatureID ?? self.creatureID,
      index: index ?? self.index,
      spell: spell ?? self.spell,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureTemplateSpellEntity;
    return {
      'CreatureID': self.creatureID,
      'Index': self.index,
      'Spell': self.spell,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureTemplateSpellEntity;
    return identical(self, other) ||
        other is CreatureTemplateSpellEntity &&
            self.runtimeType == other.runtimeType &&
            self.creatureID == other.creatureID &&
            self.index == other.index &&
            self.spell == other.spell &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as CreatureTemplateSpellEntity;
    return Object.hashAll([
      self.runtimeType,
      self.creatureID,
      self.index,
      self.spell,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureTemplateSpellEntity;
    return 'CreatureTemplateSpellEntity('
        'creatureID: ${self.creatureID}, '
        'index: ${self.index}, '
        'spell: ${self.spell}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class CreatureTemplateSpellKey {
  final int creatureID;
  final int index;

  const CreatureTemplateSpellKey({
    required this.creatureID,
    required this.index,
  });

  factory CreatureTemplateSpellKey.fromEntity(
    CreatureTemplateSpellEntity entity,
  ) {
    return CreatureTemplateSpellKey(
      creatureID: entity.creatureID,
      index: entity.index,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateSpellKey &&
            creatureID == other.creatureID &&
            index == other.index;
  }

  @override
  int get hashCode => Object.hashAll([creatureID, index]);

  @override
  String toString() {
    return 'CreatureTemplateSpellKey('
        'creatureID: $creatureID, '
        'index: $index'
        ')';
  }
}

final class BriefCreatureTemplateSpellEntity {
  final int creatureID;
  final int index;
  final int spell;
  final int verifiedBuild;
  final String spellName;
  final String spellSubtext;

  const BriefCreatureTemplateSpellEntity({
    this.creatureID = 0,
    this.index = 0,
    this.spell = 0,
    this.verifiedBuild = 0,
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory BriefCreatureTemplateSpellEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureTemplateSpellEntity(
      creatureID: (json['CreatureID'] as num?)?.toInt() ?? 0,
      index: (json['Index'] as num?)?.toInt() ?? 0,
      spell: (json['Spell'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
      spellName: json['spellName']?.toString() ?? '',
      spellSubtext: json['spellSubtext']?.toString() ?? '',
    );
  }

  CreatureTemplateSpellKey get key {
    return CreatureTemplateSpellKey(creatureID: creatureID, index: index);
  }
}
