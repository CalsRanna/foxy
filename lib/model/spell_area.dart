/// 法术区域技能
class SpellArea {
  int spell = 0;
  int area = 0;
  int questStart = 0;
  int questEnd = 0;
  int auraSpell = 0;
  int racemask = 0;
  int gender = 0;
  int autocast = 0;
  int questStartStatus = 0;
  int questEndStatus = 0;

  SpellArea();

  SpellArea.fromJson(Map<String, dynamic> json) {
    spell = json['spell'] ?? 0;
    area = json['area'] ?? 0;
    questStart = json['quest_start'] ?? 0;
    questEnd = json['quest_end'] ?? 0;
    auraSpell = json['aura_spell'] ?? 0;
    racemask = json['racemask'] ?? 0;
    gender = json['gender'] ?? 0;
    autocast = json['autocast'] ?? 0;
    questStartStatus = json['quest_start_status'] ?? 0;
    questEndStatus = json['quest_end_status'] ?? 0;
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
