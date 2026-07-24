// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefScalingStatValueEntity {
  final int id;
  final int charlevel;
  final int shoulderBudget;
  final int trinketBudget;
  final int weaponBudget1H;
  final int rangedBudget;
  final int primaryBudget;
  final int tertiaryBudget;

  const BriefScalingStatValueEntity({
    this.id = 0,
    this.charlevel = 0,
    this.shoulderBudget = 0,
    this.trinketBudget = 0,
    this.weaponBudget1H = 0,
    this.rangedBudget = 0,
    this.primaryBudget = 0,
    this.tertiaryBudget = 0,
  });

  factory BriefScalingStatValueEntity.fromJson(Map<String, dynamic> json) {
    return BriefScalingStatValueEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      charlevel: (json['Charlevel'] as num?)?.toInt() ?? 0,
      shoulderBudget: (json['ShoulderBudget'] as num?)?.toInt() ?? 0,
      trinketBudget: (json['TrinketBudget'] as num?)?.toInt() ?? 0,
      weaponBudget1H: (json['WeaponBudget1H'] as num?)?.toInt() ?? 0,
      rangedBudget: (json['RangedBudget'] as num?)?.toInt() ?? 0,
      primaryBudget: (json['PrimaryBudget'] as num?)?.toInt() ?? 0,
      tertiaryBudget: (json['TertiaryBudget'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
