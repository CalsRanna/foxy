class CreatureTemplateLocale {
  int entry = 0;
  String locale = '';
  String name = '';
  String title = '';
  int verifiedBuild = 0;

  CreatureTemplateLocale();

  CreatureTemplateLocale.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    locale = json['locale'] ?? '';
    name = json['Name'] ?? '';
    title = json['Title'] ?? '';
    verifiedBuild = json['VerifiedBuild'] ?? 0;
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

  CreatureTemplateLocale copyWith({
    int? entry,
    String? locale,
    String? name,
    String? title,
    int? verifiedBuild,
  }) {
    return CreatureTemplateLocale()
      ..entry = entry ?? this.entry
      ..locale = locale ?? this.locale
      ..name = name ?? this.name
      ..title = title ?? this.title
      ..verifiedBuild = verifiedBuild ?? this.verifiedBuild;
  }
}
