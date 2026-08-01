// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_spell_collection_editor_view_model.dart';

mixin _CreatureTemplateSpellCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final creatureIDController = registerController(IntFieldController());
  late final indexController = registerController(IntFieldController());
  late final spellController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) {}

  void _applyCandidate(CreatureTemplateSpellEntity creatureTemplateSpell) {
    creatureIDController.init(creatureTemplateSpell.creatureID);
    indexController.init(creatureTemplateSpell.index);
    spellController.init(creatureTemplateSpell.spell);
    verifiedBuildController.init(creatureTemplateSpell.verifiedBuild);
    _afterApplyCandidate(creatureTemplateSpell);
  }

  CreatureTemplateSpellEntity _collectCandidate() {
    return CreatureTemplateSpellEntity(
      creatureID: creatureIDController.collect(),
      index: indexController.collect(),
      spell: spellController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }
}
