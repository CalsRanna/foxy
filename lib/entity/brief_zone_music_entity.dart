class BriefZoneMusicEntity {
  final int id;
  final String setName;
  final int sounds0;
  final int sounds1;

  const BriefZoneMusicEntity({
    this.id = 0,
    this.setName = '',
    this.sounds0 = 0,
    this.sounds1 = 0,
  });

  factory BriefZoneMusicEntity.fromJson(Map<String, dynamic> json) {
    return BriefZoneMusicEntity(
      id: json['ID'] ?? 0,
      setName: json['SetName'] ?? '',
      sounds0: json['Sounds0'] ?? 0,
      sounds1: json['Sounds1'] ?? 0,
    );
  }

  int get key => id;
}
