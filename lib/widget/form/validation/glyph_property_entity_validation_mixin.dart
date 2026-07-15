import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GlyphPropertyValidationMixin on ViewModelValidationMixin {
  void validateGlyphPropertyFields(GlyphPropertyEntity value) =>
      value._validateFields();
}

extension on GlyphPropertyEntity {
  void _validateFields() {
    _requireRange(id, 1, 0xffff, 'ID');
    _requireRange(spellId, 0, 0x7fffffff, 'SpellID');
    _requireRange(glyphSlotFlags, 0, 0x7fffffff, 'GlyphSlotFlags');
    _requireRange(spellIconId, 0, 0x7fffffff, 'SpellIconID');
  }

  void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }
}
