class PageText {
  int id = 0;
  String text = '';
  int nextPageId = 0;
  int verifiedBuild = 0;

  // locale display field
  String localeText = '';

  String get displayText => localeText.isNotEmpty ? localeText : text;

  PageText();

  PageText.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    text = json['Text'] ?? '';
    nextPageId = json['NextPageID'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? 0;
    localeText = json['localeText'] ?? '';
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
