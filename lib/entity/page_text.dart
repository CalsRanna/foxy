class PageText {
  final int id;
  final String text;
  final int nextPageId;
  final int verifiedBuild;

  // locale display field
  final String localeText;

  String get displayText => localeText.isNotEmpty ? localeText : text;

  const PageText({
    this.id = 0,
    this.text = '',
    this.nextPageId = 0,
    this.verifiedBuild = 0,
    this.localeText = '',
  });

  factory PageText.fromJson(Map<String, dynamic> json) {
    return PageText(
      id: json['ID'] ?? 0,
      text: json['Text'] ?? '',
      nextPageId: json['NextPageID'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
      localeText: json['localeText'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Text': text,
      'NextPageID': nextPageId,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
