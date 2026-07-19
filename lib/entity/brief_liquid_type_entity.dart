class BriefLiquidTypeEntity {
  final int id;
  final String name;
  final int flags;
  final int soundBank;
  final int spellId;

  const BriefLiquidTypeEntity({
    this.id = 0,
    this.name = '',
    this.flags = 0,
    this.soundBank = 0,
    this.spellId = 0,
  });

  factory BriefLiquidTypeEntity.fromJson(Map<String, dynamic> json) {
    return BriefLiquidTypeEntity(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      flags: json['Flags'] ?? 0,
      soundBank: json['SoundBank'] ?? 0,
      spellId: json['SpellID'] ?? 0,
    );
  }

  int get key => id;
}
