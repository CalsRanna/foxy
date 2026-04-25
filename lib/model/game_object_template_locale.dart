class GameObjectTemplateLocale {
  int entry = 0;
  String locale = '';
  String name = '';
  String castBarCaption = '';
  int verifiedBuild = 0;

  GameObjectTemplateLocale();

  GameObjectTemplateLocale.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    locale = json['locale'] ?? '';
    name = json['name'] ?? '';
    castBarCaption = json['castBarCaption'] ?? '';
    verifiedBuild = json['VerifiedBuild'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'locale': locale,
      'name': name,
      'castBarCaption': castBarCaption,
      'VerifiedBuild': verifiedBuild,
    };
  }

  GameObjectTemplateLocale copyWith({
    int? entry,
    String? locale,
    String? name,
    String? castBarCaption,
    int? verifiedBuild,
  }) {
    return GameObjectTemplateLocale()
      ..entry = entry ?? this.entry
      ..locale = locale ?? this.locale
      ..name = name ?? this.name
      ..castBarCaption = castBarCaption ?? this.castBarCaption
      ..verifiedBuild = verifiedBuild ?? this.verifiedBuild;
  }
}
