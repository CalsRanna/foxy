class GameObjectTemplateLocaleEntity {
  final int entry;
  final String locale;
  final String name;
  final String castBarCaption;
  final int verifiedBuild;

  const GameObjectTemplateLocaleEntity({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.castBarCaption = '',
    this.verifiedBuild = 0,
  });

  factory GameObjectTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateLocaleEntity(
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

  GameObjectTemplateLocaleEntity copyWith({
    int? entry,
    String? locale,
    String? name,
    String? castBarCaption,
    int? verifiedBuild,
  }) {
    return GameObjectTemplateLocaleEntity(
      entry: entry ?? this.entry,
      locale: locale ?? this.locale,
      name: name ?? this.name,
      castBarCaption: castBarCaption ?? this.castBarCaption,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }
}
