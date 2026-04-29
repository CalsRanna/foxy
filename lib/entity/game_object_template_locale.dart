class GameObjectTemplateLocale {
  final int entry;
  final String locale;
  final String name;
  final String castBarCaption;
  final int verifiedBuild;

  const GameObjectTemplateLocale({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.castBarCaption = '',
    this.verifiedBuild = 0,
  });

  factory GameObjectTemplateLocale.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateLocale(
      entry: json['entry'] ?? 0,
      locale: json['locale'] ?? '',
      name: json['name'] ?? '',
      castBarCaption: json['castBarCaption'] ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
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
    return GameObjectTemplateLocale(
      entry: entry ?? this.entry,
      locale: locale ?? this.locale,
      name: name ?? this.name,
      castBarCaption: castBarCaption ?? this.castBarCaption,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }
}
