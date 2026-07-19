import 'package:foxy/entity/page_text_locale_key.dart';

/// 页面文本本地化内嵌列表展示模型。
class BriefPageTextLocaleEntity {
  final int id;
  final String locale;
  final String text;
  final int verifiedBuild;

  const BriefPageTextLocaleEntity({
    this.id = 0,
    this.locale = '',
    this.text = '',
    this.verifiedBuild = 0,
  });

  factory BriefPageTextLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefPageTextLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      text: json['Text']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  PageTextLocaleKey get key => PageTextLocaleKey(id: id, locale: locale);
}
