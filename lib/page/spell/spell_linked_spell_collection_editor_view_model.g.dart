// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_linked_spell_collection_editor_view_model.dart';

mixin _SpellLinkedSpellCollectionEditorViewModelMixin on FieldControllerMixin {
  late final spellTriggerController = registerController(IntFieldController());
  late final spellEffectController = registerController(IntFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final commentController = registerController(StringFieldController());

  SpellLinkedSpellEntity _collectCandidate() {
    return SpellLinkedSpellEntity(
      spellTrigger: spellTriggerController.collect(),
      spellEffect: spellEffectController.collect(),
      type: typeController.collect(),
      comment: commentController.collect(),
    );
  }

  void _applyCandidate(SpellLinkedSpellEntity spellLinkedSpell) {
    spellTriggerController.init(spellLinkedSpell.spellTrigger);
    spellEffectController.init(spellLinkedSpell.spellEffect);
    typeController.init(spellLinkedSpell.type);
    commentController.init(spellLinkedSpell.comment);
    _afterApplyCandidate(spellLinkedSpell);
  }

  void _afterApplyCandidate(SpellLinkedSpellEntity spellLinkedSpell) {}
}
