/// 宠物技能数据 — 对应 foxy.dbc_creature_spell_data 表
class CreatureSpellDataEntity {
  final int id;
  final int spells0;
  final int spells1;
  final int spells2;
  final int spells3;
  final int availability0;
  final int availability1;
  final int availability2;
  final int availability3;

  const CreatureSpellDataEntity({
    this.id = 0,
    this.spells0 = 0,
    this.spells1 = 0,
    this.spells2 = 0,
    this.spells3 = 0,
    this.availability0 = 0,
    this.availability1 = 0,
    this.availability2 = 0,
    this.availability3 = 0,
  });

  factory CreatureSpellDataEntity.fromJson(Map<String, dynamic> json) {
    return CreatureSpellDataEntity(
      id: json['ID'] ?? 0,
      spells0: json['Spells0'] ?? 0,
      spells1: json['Spells1'] ?? 0,
      spells2: json['Spells2'] ?? 0,
      spells3: json['Spells3'] ?? 0,
      availability0: json['Availability0'] ?? 0,
      availability1: json['Availability1'] ?? 0,
      availability2: json['Availability2'] ?? 0,
      availability3: json['Availability3'] ?? 0,
    );
  }

  CreatureSpellDataEntity copyWith({
    int? id,
    int? spells0,
    int? spells1,
    int? spells2,
    int? spells3,
    int? availability0,
    int? availability1,
    int? availability2,
    int? availability3,
  }) {
    return CreatureSpellDataEntity(
      id: id ?? this.id,
      spells0: spells0 ?? this.spells0,
      spells1: spells1 ?? this.spells1,
      spells2: spells2 ?? this.spells2,
      spells3: spells3 ?? this.spells3,
      availability0: availability0 ?? this.availability0,
      availability1: availability1 ?? this.availability1,
      availability2: availability2 ?? this.availability2,
      availability3: availability3 ?? this.availability3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Spells0': spells0,
      'Spells1': spells1,
      'Spells2': spells2,
      'Spells3': spells3,
      'Availability0': availability0,
      'Availability1': availability1,
      'Availability2': availability2,
      'Availability3': availability3,
    };
  }
}
