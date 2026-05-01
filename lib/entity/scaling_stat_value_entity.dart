class ScalingStatValueEntity {
  final int id;
  final int charlevel;
  final int shoulderBudget;
  final int trinketBudget;
  final int weaponBudget1H;
  final int rangedBudget;
  final int clothShoulderArmor;
  final int leatherShoulderArmor;
  final int mailShoulderArmor;
  final int plateShoulderArmor;
  final int weaponDPS1H;
  final int weaponDPS2H;
  final int spellcasterDPS1H;
  final int spellcasterDPS2H;
  final int rangedDPS;
  final int wandDPS;
  final int spellPower;
  final int primaryBudget;
  final int tertiaryBudget;
  final int clothCloakArmor;
  final int clothChestArmor;
  final int leatherChestArmor;
  final int mailChestArmor;
  final int plateChestArmor;

  const ScalingStatValueEntity({
    this.id = 0,
    this.charlevel = 0,
    this.shoulderBudget = 0,
    this.trinketBudget = 0,
    this.weaponBudget1H = 0,
    this.rangedBudget = 0,
    this.clothShoulderArmor = 0,
    this.leatherShoulderArmor = 0,
    this.mailShoulderArmor = 0,
    this.plateShoulderArmor = 0,
    this.weaponDPS1H = 0,
    this.weaponDPS2H = 0,
    this.spellcasterDPS1H = 0,
    this.spellcasterDPS2H = 0,
    this.rangedDPS = 0,
    this.wandDPS = 0,
    this.spellPower = 0,
    this.primaryBudget = 0,
    this.tertiaryBudget = 0,
    this.clothCloakArmor = 0,
    this.clothChestArmor = 0,
    this.leatherChestArmor = 0,
    this.mailChestArmor = 0,
    this.plateChestArmor = 0,
  });

  factory ScalingStatValueEntity.fromJson(Map<String, dynamic> json) {
    return ScalingStatValueEntity(
      id: json['ID'] ?? 0,
      charlevel: json['Charlevel'] ?? 0,
      shoulderBudget: json['ShoulderBudget'] ?? 0,
      trinketBudget: json['TrinketBudget'] ?? 0,
      weaponBudget1H: json['WeaponBudget1H'] ?? 0,
      rangedBudget: json['RangedBudget'] ?? 0,
      clothShoulderArmor: json['ClothShoulderArmor'] ?? 0,
      leatherShoulderArmor: json['LeatherShoulderArmor'] ?? 0,
      mailShoulderArmor: json['MailShoulderArmor'] ?? 0,
      plateShoulderArmor: json['PlateShoulderArmor'] ?? 0,
      weaponDPS1H: json['WeaponDPS1H'] ?? 0,
      weaponDPS2H: json['WeaponDPS2H'] ?? 0,
      spellcasterDPS1H: json['SpellcasterDPS1H'] ?? 0,
      spellcasterDPS2H: json['SpellcasterDPS2H'] ?? 0,
      rangedDPS: json['RangedDPS'] ?? 0,
      wandDPS: json['WandDPS'] ?? 0,
      spellPower: json['SpellPower'] ?? 0,
      primaryBudget: json['PrimaryBudget'] ?? 0,
      tertiaryBudget: json['TertiaryBudget'] ?? 0,
      clothCloakArmor: json['ClothCloakArmor'] ?? 0,
      clothChestArmor: json['ClothChestArmor'] ?? 0,
      leatherChestArmor: json['LeatherChestArmor'] ?? 0,
      mailChestArmor: json['MailChestArmor'] ?? 0,
      plateChestArmor: json['PlateChestArmor'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Charlevel': charlevel,
      'ShoulderBudget': shoulderBudget,
      'TrinketBudget': trinketBudget,
      'WeaponBudget1H': weaponBudget1H,
      'RangedBudget': rangedBudget,
      'ClothShoulderArmor': clothShoulderArmor,
      'LeatherShoulderArmor': leatherShoulderArmor,
      'MailShoulderArmor': mailShoulderArmor,
      'PlateShoulderArmor': plateShoulderArmor,
      'WeaponDPS1H': weaponDPS1H,
      'WeaponDPS2H': weaponDPS2H,
      'SpellcasterDPS1H': spellcasterDPS1H,
      'SpellcasterDPS2H': spellcasterDPS2H,
      'RangedDPS': rangedDPS,
      'WandDPS': wandDPS,
      'SpellPower': spellPower,
      'PrimaryBudget': primaryBudget,
      'TertiaryBudget': tertiaryBudget,
      'ClothCloakArmor': clothCloakArmor,
      'ClothChestArmor': clothChestArmor,
      'LeatherChestArmor': leatherChestArmor,
      'MailChestArmor': mailChestArmor,
      'PlateChestArmor': plateChestArmor,
    };
  }
}

class BriefScalingStatValueEntity {
  final int id;
  final int charlevel;

  const BriefScalingStatValueEntity({this.id = 0, this.charlevel = 0});

  factory BriefScalingStatValueEntity.fromJson(Map<String, dynamic> json) {
    return BriefScalingStatValueEntity(
      id: json['ID'] ?? 0,
      charlevel: json['Charlevel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Charlevel': charlevel};
  }
}
