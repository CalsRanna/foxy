import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin PageTextValidationMixin on ViewModelValidationMixin {
  void validatePageTextFields(PageTextEntity value) {
    final id = value.id;
    final nextPageId = value.nextPageId;
    final verifiedBuild = value.verifiedBuild;

    if (id <= 0 || id > kPageTextMaxUnsignedInt) {
      throw RangeError.range(id, 1, kPageTextMaxUnsignedInt, 'ID');
    }
    if (nextPageId < 0 || nextPageId > kPageTextMaxUnsignedInt) {
      throw RangeError.range(
        nextPageId,
        0,
        kPageTextMaxUnsignedInt,
        'NextPageID',
      );
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
