// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_group_collection_editor_view_model.dart';

mixin _SpellGroupCollectionEditorViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final spellIdController = registerController(IntFieldController());

  void _afterApplyCandidate(SpellGroupEntity spellGroup) {}

  void _applyCandidate(SpellGroupEntity spellGroup) {
    idController.init(spellGroup.id);
    spellIdController.init(spellGroup.spellId);
    _afterApplyCandidate(spellGroup);
  }

  SpellGroupEntity _collectCandidate() {
    return SpellGroupEntity(
      id: idController.collect(),
      spellId: spellIdController.collect(),
    );
  }
}
