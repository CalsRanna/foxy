import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin PageTextLocaleValidationMixin on ViewModelValidationMixin {
  void validatePageTextLocaleFields(PageTextLocaleEntity value) =>
      value._validateFields();
}

extension on PageTextLocaleEntity {
  void _validateFields() {
    if (id <= 0 || id > kPageTextMaxUnsignedInt) {
      throw RangeError.range(id, 1, kPageTextMaxUnsignedInt, 'ID');
    }
    if (!kPageTextLocaleOptions.containsKey(locale)) {
      throw ArgumentError.value(locale, 'locale', 'AzerothCore 不加载该语言代码');
    }
    if (verifiedBuild < kPageTextMinSignedInt ||
        verifiedBuild > kPageTextMaxSignedInt) {
      throw RangeError.range(
        verifiedBuild,
        kPageTextMinSignedInt,
        kPageTextMaxSignedInt,
        'VerifiedBuild',
      );
    }
  }
}
