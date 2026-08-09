// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_ability_entity.dart';

final class BriefSkillLineAbilityEntity {
  final int id;
  final int skillLine;
  final int spell;

  const BriefSkillLineAbilityEntity({
    this.id = 0,
    this.skillLine = 0,
    this.spell = 0,
  });

  factory BriefSkillLineAbilityEntity.fromJson(Map<String, dynamic> json) {
    return BriefSkillLineAbilityEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      skillLine: json['SkillLine'] == true
          ? 1
          : json['SkillLine'] == false
          ? 0
          : (json['SkillLine'] as num?)?.toInt() ?? 0,
      spell: json['Spell'] == true
          ? 1
          : json['Spell'] == false
          ? 0
          : (json['Spell'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  int get hashCode => Object.hashAll([id, skillLine, spell]);

  SkillLineAbilityKey get key {
    return SkillLineAbilityKey(id: id, skillLine: skillLine);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefSkillLineAbilityEntity &&
            id == other.id &&
            skillLine == other.skillLine &&
            spell == other.spell;
  }

  @override
  String toString() {
    return 'BriefSkillLineAbilityEntity('
        'id: $id, '
        'skillLine: $skillLine, '
        'spell: $spell'
        ')';
  }
}

final class SkillLineAbilityKey {
  final int id;
  final int skillLine;

  const SkillLineAbilityKey({required this.id, required this.skillLine});

  factory SkillLineAbilityKey.fromEntity(SkillLineAbilityEntity entity) {
    return SkillLineAbilityKey(id: entity.id, skillLine: entity.skillLine);
  }

  @override
  int get hashCode => Object.hashAll([id, skillLine]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SkillLineAbilityKey &&
            id == other.id &&
            skillLine == other.skillLine;
  }

  @override
  String toString() {
    return 'SkillLineAbilityKey('
        'id: $id, '
        'skillLine: $skillLine'
        ')';
  }
}

mixin _SkillLineAbilityEntityMixin {
  @override
  int get hashCode {
    final self = this as SkillLineAbilityEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.skillLine,
      self.spell,
      self.raceMask,
      self.classMask,
      self.excludeRace,
      self.excludeClass,
      self.minSkillLineRank,
      self.supercededBySpell,
      self.acquireMethod,
      self.trivialSkillLineRankHigh,
      self.trivialSkillLineRankLow,
      self.characterPoints0,
      self.characterPoints1,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as SkillLineAbilityEntity;
    return identical(self, other) ||
        other is SkillLineAbilityEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.skillLine == other.skillLine &&
            self.spell == other.spell &&
            self.raceMask == other.raceMask &&
            self.classMask == other.classMask &&
            self.excludeRace == other.excludeRace &&
            self.excludeClass == other.excludeClass &&
            self.minSkillLineRank == other.minSkillLineRank &&
            self.supercededBySpell == other.supercededBySpell &&
            self.acquireMethod == other.acquireMethod &&
            self.trivialSkillLineRankHigh == other.trivialSkillLineRankHigh &&
            self.trivialSkillLineRankLow == other.trivialSkillLineRankLow &&
            self.characterPoints0 == other.characterPoints0 &&
            self.characterPoints1 == other.characterPoints1;
  }

  SkillLineAbilityEntity copyWith({
    int? id,
    int? skillLine,
    int? spell,
    int? raceMask,
    int? classMask,
    int? excludeRace,
    int? excludeClass,
    int? minSkillLineRank,
    int? supercededBySpell,
    int? acquireMethod,
    int? trivialSkillLineRankHigh,
    int? trivialSkillLineRankLow,
    int? characterPoints0,
    int? characterPoints1,
  }) {
    final self = this as SkillLineAbilityEntity;
    return SkillLineAbilityEntity(
      id: id ?? self.id,
      skillLine: skillLine ?? self.skillLine,
      spell: spell ?? self.spell,
      raceMask: raceMask ?? self.raceMask,
      classMask: classMask ?? self.classMask,
      excludeRace: excludeRace ?? self.excludeRace,
      excludeClass: excludeClass ?? self.excludeClass,
      minSkillLineRank: minSkillLineRank ?? self.minSkillLineRank,
      supercededBySpell: supercededBySpell ?? self.supercededBySpell,
      acquireMethod: acquireMethod ?? self.acquireMethod,
      trivialSkillLineRankHigh:
          trivialSkillLineRankHigh ?? self.trivialSkillLineRankHigh,
      trivialSkillLineRankLow:
          trivialSkillLineRankLow ?? self.trivialSkillLineRankLow,
      characterPoints0: characterPoints0 ?? self.characterPoints0,
      characterPoints1: characterPoints1 ?? self.characterPoints1,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SkillLineAbilityEntity;
    return {
      'ID': self.id,
      'SkillLine': self.skillLine,
      'Spell': self.spell,
      'RaceMask': self.raceMask,
      'ClassMask': self.classMask,
      'ExcludeRace': self.excludeRace,
      'ExcludeClass': self.excludeClass,
      'MinSkillLineRank': self.minSkillLineRank,
      'SupercededBySpell': self.supercededBySpell,
      'AcquireMethod': self.acquireMethod,
      'TrivialSkillLineRankHigh': self.trivialSkillLineRankHigh,
      'TrivialSkillLineRankLow': self.trivialSkillLineRankLow,
      'CharacterPoints0': self.characterPoints0,
      'CharacterPoints1': self.characterPoints1,
    };
  }

  @override
  String toString() {
    final self = this as SkillLineAbilityEntity;
    return 'SkillLineAbilityEntity('
        'id: ${self.id}, '
        'skillLine: ${self.skillLine}, '
        'spell: ${self.spell}, '
        'raceMask: ${self.raceMask}, '
        'classMask: ${self.classMask}, '
        'excludeRace: ${self.excludeRace}, '
        'excludeClass: ${self.excludeClass}, '
        'minSkillLineRank: ${self.minSkillLineRank}, '
        'supercededBySpell: ${self.supercededBySpell}, '
        'acquireMethod: ${self.acquireMethod}, '
        'trivialSkillLineRankHigh: ${self.trivialSkillLineRankHigh}, '
        'trivialSkillLineRankLow: ${self.trivialSkillLineRankLow}, '
        'characterPoints0: ${self.characterPoints0}, '
        'characterPoints1: ${self.characterPoints1}'
        ')';
  }

  static SkillLineAbilityEntity fromJson(Map<String, dynamic> json) {
    return SkillLineAbilityEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      skillLine: json['SkillLine'] == true
          ? 1
          : json['SkillLine'] == false
          ? 0
          : (json['SkillLine'] as num?)?.toInt() ?? 0,
      spell: json['Spell'] == true
          ? 1
          : json['Spell'] == false
          ? 0
          : (json['Spell'] as num?)?.toInt() ?? 0,
      raceMask: json['RaceMask'] == true
          ? 1
          : json['RaceMask'] == false
          ? 0
          : (json['RaceMask'] as num?)?.toInt() ?? 0,
      classMask: json['ClassMask'] == true
          ? 1
          : json['ClassMask'] == false
          ? 0
          : (json['ClassMask'] as num?)?.toInt() ?? 0,
      excludeRace: json['ExcludeRace'] == true
          ? 1
          : json['ExcludeRace'] == false
          ? 0
          : (json['ExcludeRace'] as num?)?.toInt() ?? 0,
      excludeClass: json['ExcludeClass'] == true
          ? 1
          : json['ExcludeClass'] == false
          ? 0
          : (json['ExcludeClass'] as num?)?.toInt() ?? 0,
      minSkillLineRank: json['MinSkillLineRank'] == true
          ? 1
          : json['MinSkillLineRank'] == false
          ? 0
          : (json['MinSkillLineRank'] as num?)?.toInt() ?? 0,
      supercededBySpell: json['SupercededBySpell'] == true
          ? 1
          : json['SupercededBySpell'] == false
          ? 0
          : (json['SupercededBySpell'] as num?)?.toInt() ?? 0,
      acquireMethod: json['AcquireMethod'] == true
          ? 1
          : json['AcquireMethod'] == false
          ? 0
          : (json['AcquireMethod'] as num?)?.toInt() ?? 0,
      trivialSkillLineRankHigh: json['TrivialSkillLineRankHigh'] == true
          ? 1
          : json['TrivialSkillLineRankHigh'] == false
          ? 0
          : (json['TrivialSkillLineRankHigh'] as num?)?.toInt() ?? 0,
      trivialSkillLineRankLow: json['TrivialSkillLineRankLow'] == true
          ? 1
          : json['TrivialSkillLineRankLow'] == false
          ? 0
          : (json['TrivialSkillLineRankLow'] as num?)?.toInt() ?? 0,
      characterPoints0: json['CharacterPoints0'] == true
          ? 1
          : json['CharacterPoints0'] == false
          ? 0
          : (json['CharacterPoints0'] as num?)?.toInt() ?? 0,
      characterPoints1: json['CharacterPoints1'] == true
          ? 1
          : json['CharacterPoints1'] == false
          ? 0
          : (json['CharacterPoints1'] as num?)?.toInt() ?? 0,
    );
  }
}
