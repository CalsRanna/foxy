import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GlyphPropertyValidationMixin on ViewModelValidationMixin {
  void validateGlyphPropertyFields(GlyphPropertyEntity value) {
    final id = value.id;
    final spellId = value.spellId;
    final glyphSlotFlags = value.glyphSlotFlags;
    final spellIconId = value.spellIconId;

    void requireRange(int value, int minimum, int maximum, String name) {
      if (value < minimum || value > maximum) {
        throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
      }
    }

    requireRange(id, 1, 0xffff, 'ID');
    requireRange(spellId, 0, 0x7fffffff, 'SpellID');
    requireRange(glyphSlotFlags, 0, 0x7fffffff, 'GlyphSlotFlags');
    requireRange(spellIconId, 0, 0x7fffffff, 'SpellIconID');
  }
}
