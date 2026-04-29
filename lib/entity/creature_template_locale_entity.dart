class CreatureTemplateLocaleEntity {
  int entry = 0;
  String locale = '';
  String name = '';
  String title = '';
  int verifiedBuild = 0;

  CreatureTemplateLocaleEntity();

  factory CreatureTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateLocaleEntity()
      ..entry = json['entry'] ?? 0
      ..locale = json['locale'] ?? ''
      ..name = json['Name'] ?? ''
      ..title = json['Title'] ?? ''
      ..verifiedBuild = json['VerifiedBuild'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'locale': locale,
      'Name': name,
      'Title': title,
      'VerifiedBuild': verifiedBuild,
    };
  }

  CreatureTemplateLocaleEntity copyWith({
    int? entry,
    String? locale,
    String? name,
    String? title,
    int? verifiedBuild,
  }) {
    return CreatureTemplateLocaleEntity()
      ..entry = entry ?? this.entry
      ..locale = locale ?? this.locale
      ..name = name ?? this.name
      ..title = title ?? this.title
      ..verifiedBuild = verifiedBuild ?? this.verifiedBuild;
  }
}
