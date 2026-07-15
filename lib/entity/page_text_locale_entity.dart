import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_entity.dart';

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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale'] as String? ?? '',
      text: json['Text'] as String? ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
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

  void validate() {
    if (id <= 0 || id > PageTextEntity.maxUnsignedInt) {
      throw RangeError.range(id, 1, PageTextEntity.maxUnsignedInt, 'ID');
    }
    if (!kPageTextLocaleOptions.containsKey(locale)) {
      throw ArgumentError.value(locale, 'locale', 'AzerothCore 不加载该语言代码');
    }
    if (verifiedBuild < PageTextEntity.minSignedInt ||
        verifiedBuild > PageTextEntity.maxSignedInt) {
      throw RangeError.range(
        verifiedBuild,
        PageTextEntity.minSignedInt,
        PageTextEntity.maxSignedInt,
        'VerifiedBuild',
      );
    }
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
