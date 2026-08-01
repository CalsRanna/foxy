// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_detail_view_model.dart';

mixin _GlyphPropertyDetailViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final spellIdController = registerController(IntFieldController());
  late final glyphSlotFlagsController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellIconIdController = registerController(IntFieldController());

  void _afterApplyCandidate(GlyphPropertyEntity glyphProperty) {}

  void _applyCandidate(GlyphPropertyEntity glyphProperty) {
    idController.init(glyphProperty.id);
    spellIdController.init(glyphProperty.spellId);
    glyphSlotFlagsController.init(glyphProperty.glyphSlotFlags);
    spellIconIdController.init(glyphProperty.spellIconId);
    _afterApplyCandidate(glyphProperty);
  }

  GlyphPropertyEntity _collectCandidate() {
    return GlyphPropertyEntity(
      id: idController.collect(),
      spellId: spellIdController.collect(),
      glyphSlotFlags: glyphSlotFlagsController.collect(),
      spellIconId: spellIconIdController.collect(),
    );
  }
}
