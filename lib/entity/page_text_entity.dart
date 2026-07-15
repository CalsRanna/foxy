class PageTextEntity {
  static const maxUnsignedInt = 0xFFFFFFFF;
  static const minSignedInt = -0x80000000;
  static const maxSignedInt = 0x7FFFFFFF;

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

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Text': text,
      'NextPageID': nextPageId,
      'VerifiedBuild': verifiedBuild,
    };
  }

  void validate() {
    if (id <= 0 || id > maxUnsignedInt) {
      throw RangeError.range(id, 1, maxUnsignedInt, 'ID');
    }
    if (nextPageId < 0 || nextPageId > maxUnsignedInt) {
      throw RangeError.range(nextPageId, 0, maxUnsignedInt, 'NextPageID');
    }
    if (verifiedBuild < minSignedInt || verifiedBuild > maxSignedInt) {
      throw RangeError.range(
        verifiedBuild,
        minSignedInt,
        maxSignedInt,
        'VerifiedBuild',
      );
    }
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
