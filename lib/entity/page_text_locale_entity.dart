class PageTextLocaleEntity {
  final int id;
  final String locale;
  final String text;
  final int verifiedBuild;

  const PageTextLocaleEntity({
    this.id = 0,
    this.locale = '',
    this.text = '',
    this.verifiedBuild = 0,
  });

  factory PageTextLocaleEntity.fromJson(Map<String, dynamic> json) {
    return PageTextLocaleEntity(
      id: json['ID'] ?? 0,
      locale: json['locale'] ?? '',
      text: json['Text'] ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'locale': locale,
      'Text': text,
      'VerifiedBuild': verifiedBuild,
    };
  }

  PageTextLocaleEntity copyWith({
    int? id,
    String? locale,
    String? text,
    int? verifiedBuild,
  }) {
    return PageTextLocaleEntity(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      text: text ?? this.text,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }
}
