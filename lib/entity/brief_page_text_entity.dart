/// 页面文本列表和 Picker 展示模型。
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      text: json['Text']?.toString() ?? '',
      nextPageId: (json['NextPageID'] as num?)?.toInt() ?? 0,
      localeText: json['localeText']?.toString() ?? '',
    );
  }

  String get displayText => localeText.isNotEmpty ? localeText : text;

  int get key => id;
}
