// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_custom_attr_single_editor_view_model.dart';

mixin _SpellCustomAttrSingleEditorViewModelMixin on FieldControllerMixin {
  late final spellIdController = registerController(IntFieldController());
  late final attributesController = registerController(FlagFieldController());

  void _afterApplyCandidate(SpellCustomAttrEntity spellCustomAttr) {}

  void _applyCandidate(SpellCustomAttrEntity spellCustomAttr) {
    spellIdController.init(spellCustomAttr.spellId);
    attributesController.init(spellCustomAttr.attributes);
    _afterApplyCandidate(spellCustomAttr);
  }

  SpellCustomAttrEntity _collectCandidate() {
    return SpellCustomAttrEntity(
      spellId: spellIdController.collect(),
      attributes: attributesController.collect(),
    );
  }
}
