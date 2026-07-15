/// 法术区域技能
class SpellAreaEntity {
  final int spell;
  final int area;
  final int questStart;
  final int questEnd;
  final int auraSpell;
  final int racemask;
  final int gender;
  final int autocast;
  final int questStartStatus;
  final int questEndStatus;

  const SpellAreaEntity({
    this.spell = 0,
    this.area = 0,
    this.questStart = 0,
    this.questEnd = 0,
    this.auraSpell = 0,
    this.racemask = 0,
    this.gender = 2,
    this.autocast = 0,
    this.questStartStatus = 64,
    this.questEndStatus = 11,
  });

  factory SpellAreaEntity.fromJson(Map<String, dynamic> json) {
    return SpellAreaEntity(
      spell: json['spell'] ?? 0,
      area: json['area'] ?? 0,
      questStart: json['quest_start'] ?? 0,
      questEnd: json['quest_end'] ?? 0,
      auraSpell: json['aura_spell'] ?? 0,
      racemask: json['racemask'] ?? 0,
      gender: json['gender'] ?? 2,
      autocast: json['autocast'] ?? 0,
      questStartStatus: json['quest_start_status'] ?? 64,
      questEndStatus: json['quest_end_status'] ?? 11,
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
}
