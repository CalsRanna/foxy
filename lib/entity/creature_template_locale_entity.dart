class CreatureTemplateLocaleEntity {
  final int entry;
  final String locale;
  final String name;
  final String title;
  final int verifiedBuild;

  const CreatureTemplateLocaleEntity({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.title = '',
    this.verifiedBuild = 0,
  });

  factory CreatureTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateLocaleEntity(
      entry: json['entry'] ?? 0,
      locale: json['locale'] ?? '',
      name: json['Name'] ?? '',
      title: json['Title'] ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  CreatureTemplateLocaleEntity copyWith({
    int? entry,
    String? locale,
    String? name,
    String? title,
    int? verifiedBuild,
  }) {
    return CreatureTemplateLocaleEntity(
      entry: entry ?? this.entry,
      locale: locale ?? this.locale,
      name: name ?? this.name,
      title: title ?? this.title,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
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
}
