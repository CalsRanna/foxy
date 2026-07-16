/// 页面文本列表/Picker 展示模型
class BriefPageTextEntity {
  final int id;
  final String text;
  final int nextPageId;
  final String localeText;

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

  String get displayText => localeText.isNotEmpty ? localeText : text;

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

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Text': text,
      'NextPageID': nextPageId,
      'localeText': localeText,
    };
  }
}

class PageTextEntity {
  final int id;
  final String text;
  final int nextPageId;
  final int verifiedBuild;

  const PageTextEntity({
    this.id = 0,
    this.text = '',
    this.nextPageId = 0,
    this.verifiedBuild = 0,
  });

  factory PageTextEntity.fromJson(Map<String, dynamic> json) {
    return PageTextEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      text: json['Text'] as String? ?? '',
      nextPageId: (json['NextPageID'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  PageTextEntity copyWith({
    int? id,
    String? text,
    int? nextPageId,
    int? verifiedBuild,
  }) {
    return PageTextEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      nextPageId: nextPageId ?? this.nextPageId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
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
