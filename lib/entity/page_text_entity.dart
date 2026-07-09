class PageTextEntity {
  final int id;
  final String text;
  final int nextPageId;
  final int verifiedBuild;

  // locale display field
  final String localeText;

  String get displayText => localeText.isNotEmpty ? localeText : text;

  const PageTextEntity({
    this.id = 0,
    this.text = '',
    this.nextPageId = 0,
    this.verifiedBuild = 0,
    this.localeText = '',
  });

  factory PageTextEntity.fromJson(Map<String, dynamic> json) {
    return PageTextEntity(
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

  PageTextEntity copyWith({
    int? id,
    String? text,
    int? nextPageId,
    int? verifiedBuild,
    String? localeText,
  }) {
    return PageTextEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      nextPageId: nextPageId ?? this.nextPageId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
      localeText: localeText ?? this.localeText,
    );
  }
}

/// 页面文本列表/Picker 展示模型
class BriefPageTextEntity {
  final int id;
  final String text;
  final int nextPageId;
  final String localeText;

  String get displayText => localeText.isNotEmpty ? localeText : text;

  const BriefPageTextEntity({
    this.id = 0,
    this.text = '',
    this.nextPageId = 0,
    this.localeText = '',
  });

  factory BriefPageTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefPageTextEntity(
      id: json['ID'] ?? 0,
      text: json['Text'] ?? '',
      nextPageId: json['NextPageID'] ?? 0,
      localeText: json['localeText'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Text': text,
      'NextPageID': nextPageId,
      'localeText': localeText,
    };
  }

  BriefPageTextEntity copyWith({
    int? id,
    String? text,
    int? nextPageId,
    String? localeText,
  }) {
    return BriefPageTextEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      nextPageId: nextPageId ?? this.nextPageId,
      localeText: localeText ?? this.localeText,
    );
  }
}
