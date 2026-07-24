// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_area_entity.dart';

mixin _SpellAreaEntityMixin {
  int get spell;
  int get area;
  int get questStart;
  int get questEnd;
  int get auraSpell;
  int get racemask;
  int get gender;
  int get autocast;
  int get questStartStatus;
  int get questEndStatus;

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
    return SpellAreaEntity(
      spell: spell ?? this.spell,
      area: area ?? this.area,
      questStart: questStart ?? this.questStart,
      questEnd: questEnd ?? this.questEnd,
      auraSpell: auraSpell ?? this.auraSpell,
      racemask: racemask ?? this.racemask,
      gender: gender ?? this.gender,
      autocast: autocast ?? this.autocast,
      questStartStatus: questStartStatus ?? this.questStartStatus,
      questEndStatus: questEndStatus ?? this.questEndStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spell': spell,
      'area': area,
      'quest_start': questStart,
      'quest_end': questEnd,
      'aura_spell': auraSpell,
      'racemask': racemask,
      'gender': gender,
      'autocast': autocast,
      'quest_start_status': questStartStatus,
      'quest_end_status': questEndStatus,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellAreaEntity &&
            runtimeType == other.runtimeType &&
            spell == other.spell &&
            area == other.area &&
            questStart == other.questStart &&
            questEnd == other.questEnd &&
            auraSpell == other.auraSpell &&
            racemask == other.racemask &&
            gender == other.gender &&
            autocast == other.autocast &&
            questStartStatus == other.questStartStatus &&
            questEndStatus == other.questEndStatus;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      spell,
      area,
      questStart,
      questEnd,
      auraSpell,
      racemask,
      gender,
      autocast,
      questStartStatus,
      questEndStatus,
    ]);
  }

  @override
  String toString() {
    return 'SpellAreaEntity('
        'spell: $spell, '
        'area: $area, '
        'questStart: $questStart, '
        'questEnd: $questEnd, '
        'auraSpell: $auraSpell, '
        'racemask: $racemask, '
        'gender: $gender, '
        'autocast: $autocast, '
        'questStartStatus: $questStartStatus, '
        'questEndStatus: $questEndStatus'
        ')';
  }
}
