/// 法术区域技能
class SpellArea {
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

  const SpellArea({
    this.spell = 0,
    this.area = 0,
    this.questStart = 0,
    this.questEnd = 0,
    this.auraSpell = 0,
    this.racemask = 0,
    this.gender = 0,
    this.autocast = 0,
    this.questStartStatus = 0,
    this.questEndStatus = 0,
  });

  factory SpellArea.fromJson(Map<String, dynamic> json) {
    return SpellArea(
      spell: json['spell'] ?? 0,
      area: json['area'] ?? 0,
      questStart: json['quest_start'] ?? 0,
      questEnd: json['quest_end'] ?? 0,
      auraSpell: json['aura_spell'] ?? 0,
      racemask: json['racemask'] ?? 0,
      gender: json['gender'] ?? 0,
      autocast: json['autocast'] ?? 0,
      questStartStatus: json['quest_start_status'] ?? 0,
      questEndStatus: json['quest_end_status'] ?? 0,
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
}
