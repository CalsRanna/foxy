// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_area_entity.dart';

mixin _SpellAreaEntityMixin {
  static SpellAreaEntity fromJson(Map<String, dynamic> json) {
    return SpellAreaEntity(
      spell: (json['spell'] as num?)?.toInt() ?? 0,
      area: (json['area'] as num?)?.toInt() ?? 0,
      questStart: (json['quest_start'] as num?)?.toInt() ?? 0,
      questEnd: (json['quest_end'] as num?)?.toInt() ?? 0,
      auraSpell: (json['aura_spell'] as num?)?.toInt() ?? 0,
      racemask: (json['racemask'] as num?)?.toInt() ?? 0,
      gender: (json['gender'] as num?)?.toInt() ?? 2,
      autocast: (json['autocast'] as num?)?.toInt() ?? 0,
      questStartStatus: (json['quest_start_status'] as num?)?.toInt() ?? 64,
      questEndStatus: (json['quest_end_status'] as num?)?.toInt() ?? 11,
    );
  }

  SpellAreaEntity copyWith({
    int? spell,
    int? area,
    int? questStart,
    int? questEnd,
    int? auraSpell,
    int? racemask,
    int? gender,
    int? autocast,
    int? questStartStatus,
    int? questEndStatus,
  }) {
    final self = this as SpellAreaEntity;
    return SpellAreaEntity(
      spell: spell ?? self.spell,
      area: area ?? self.area,
      questStart: questStart ?? self.questStart,
      questEnd: questEnd ?? self.questEnd,
      auraSpell: auraSpell ?? self.auraSpell,
      racemask: racemask ?? self.racemask,
      gender: gender ?? self.gender,
      autocast: autocast ?? self.autocast,
      questStartStatus: questStartStatus ?? self.questStartStatus,
      questEndStatus: questEndStatus ?? self.questEndStatus,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellAreaEntity;
    return {
      'spell': self.spell,
      'area': self.area,
      'quest_start': self.questStart,
      'quest_end': self.questEnd,
      'aura_spell': self.auraSpell,
      'racemask': self.racemask,
      'gender': self.gender,
      'autocast': self.autocast,
      'quest_start_status': self.questStartStatus,
      'quest_end_status': self.questEndStatus,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellAreaEntity;
    return identical(self, other) ||
        other is SpellAreaEntity &&
            self.runtimeType == other.runtimeType &&
            self.spell == other.spell &&
            self.area == other.area &&
            self.questStart == other.questStart &&
            self.questEnd == other.questEnd &&
            self.auraSpell == other.auraSpell &&
            self.racemask == other.racemask &&
            self.gender == other.gender &&
            self.autocast == other.autocast &&
            self.questStartStatus == other.questStartStatus &&
            self.questEndStatus == other.questEndStatus;
  }

  @override
  int get hashCode {
    final self = this as SpellAreaEntity;
    return Object.hashAll([
      self.runtimeType,
      self.spell,
      self.area,
      self.questStart,
      self.questEnd,
      self.auraSpell,
      self.racemask,
      self.gender,
      self.autocast,
      self.questStartStatus,
      self.questEndStatus,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellAreaEntity;
    return 'SpellAreaEntity('
        'spell: ${self.spell}, '
        'area: ${self.area}, '
        'questStart: ${self.questStart}, '
        'questEnd: ${self.questEnd}, '
        'auraSpell: ${self.auraSpell}, '
        'racemask: ${self.racemask}, '
        'gender: ${self.gender}, '
        'autocast: ${self.autocast}, '
        'questStartStatus: ${self.questStartStatus}, '
        'questEndStatus: ${self.questEndStatus}'
        ')';
  }
}

final class SpellAreaKey {
  final int spell;
  final int area;
  final int questStart;
  final int auraSpell;
  final int racemask;
  final int gender;

  const SpellAreaKey({
    required this.spell,
    required this.area,
    required this.questStart,
    required this.auraSpell,
    required this.racemask,
    required this.gender,
  });

  factory SpellAreaKey.fromEntity(SpellAreaEntity entity) {
    return SpellAreaKey(
      spell: entity.spell,
      area: entity.area,
      questStart: entity.questStart,
      auraSpell: entity.auraSpell,
      racemask: entity.racemask,
      gender: entity.gender,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellAreaKey &&
            spell == other.spell &&
            area == other.area &&
            questStart == other.questStart &&
            auraSpell == other.auraSpell &&
            racemask == other.racemask &&
            gender == other.gender;
  }

  @override
  int get hashCode =>
      Object.hashAll([spell, area, questStart, auraSpell, racemask, gender]);

  @override
  String toString() {
    return 'SpellAreaKey('
        'spell: $spell, '
        'area: $area, '
        'questStart: $questStart, '
        'auraSpell: $auraSpell, '
        'racemask: $racemask, '
        'gender: $gender'
        ')';
  }
}

final class BriefSpellAreaEntity {
  final int spell;
  final int area;
  final int questStart;
  final int questEnd;
  final int auraSpell;
  final int racemask;
  final int gender;
  final int questStartStatus;
  final int questEndStatus;

  const BriefSpellAreaEntity({
    this.spell = 0,
    this.area = 0,
    this.questStart = 0,
    this.questEnd = 0,
    this.auraSpell = 0,
    this.racemask = 0,
    this.gender = 2,
    this.questStartStatus = 64,
    this.questEndStatus = 11,
  });

  factory BriefSpellAreaEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellAreaEntity(
      spell: (json['spell'] as num?)?.toInt() ?? 0,
      area: (json['area'] as num?)?.toInt() ?? 0,
      questStart: (json['quest_start'] as num?)?.toInt() ?? 0,
      questEnd: (json['quest_end'] as num?)?.toInt() ?? 0,
      auraSpell: (json['aura_spell'] as num?)?.toInt() ?? 0,
      racemask: (json['racemask'] as num?)?.toInt() ?? 0,
      gender: (json['gender'] as num?)?.toInt() ?? 2,
      questStartStatus: (json['quest_start_status'] as num?)?.toInt() ?? 64,
      questEndStatus: (json['quest_end_status'] as num?)?.toInt() ?? 11,
    );
  }

  SpellAreaKey get key {
    return SpellAreaKey(
      spell: spell,
      area: area,
      questStart: questStart,
      auraSpell: auraSpell,
      racemask: racemask,
      gender: gender,
    );
  }
}
