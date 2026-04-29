class PageTextLocale {
  int id = 0;
  String locale = '';
  String text = '';
  int verifiedBuild = 0;

  PageTextLocale();

  factory PageTextLocale.fromJson(Map<String, dynamic> json) {
    return PageTextLocale()
      ..id = json['ID'] ?? 0
      ..locale = json['locale'] ?? ''
      ..text = json['Text'] ?? ''
      ..verifiedBuild = json['VerifiedBuild'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'locale': locale,
      'Text': text,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
