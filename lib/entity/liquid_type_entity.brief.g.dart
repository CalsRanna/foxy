// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefLiquidTypeEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      soundBank: (json['SoundBank'] as num?)?.toInt() ?? 0,
      spellId: (json['SpellID'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
