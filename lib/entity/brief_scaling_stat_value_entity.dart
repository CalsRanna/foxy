class BriefScalingStatValueEntity {
  final int id;
  final int charlevel;
  final int primaryBudget;
  final int tertiaryBudget;
  final int shoulderBudget;
  final int trinketBudget;
  final int weaponBudget1H;
  final int rangedBudget;

  const BriefScalingStatValueEntity({
    this.id = 0,
    this.charlevel = 0,
    this.primaryBudget = 0,
    this.tertiaryBudget = 0,
    this.shoulderBudget = 0,
    this.trinketBudget = 0,
    this.weaponBudget1H = 0,
    this.rangedBudget = 0,
  });

  factory BriefScalingStatValueEntity.fromJson(Map<String, dynamic> json) {
    return BriefScalingStatValueEntity(
      id: json['ID'] ?? 0,
      charlevel: json['Charlevel'] ?? 0,
      primaryBudget: json['PrimaryBudget'] ?? 0,
      tertiaryBudget: json['TertiaryBudget'] ?? 0,
      shoulderBudget: json['ShoulderBudget'] ?? 0,
      trinketBudget: json['TrinketBudget'] ?? 0,
      weaponBudget1H: json['WeaponBudget1H'] ?? 0,
      rangedBudget: json['RangedBudget'] ?? 0,
    );
  }

  int get key => id;
}
