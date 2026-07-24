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
