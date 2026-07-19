class BriefPointOfInterestEntity {
  final int id;
  final String name;
  final String localeName;

  const BriefPointOfInterestEntity({
    this.id = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefPointOfInterestEntity.fromJson(Map<String, dynamic> json) {
    return BriefPointOfInterestEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      localeName: json['localeName']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  int get key => id;
}
