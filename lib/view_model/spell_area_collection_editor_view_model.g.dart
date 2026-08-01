// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_area_collection_editor_view_model.dart';

mixin _SpellAreaCollectionEditorViewModelMixin on FieldControllerMixin {
  late final spellController = registerController(IntFieldController());
  late final areaController = registerController(IntFieldController());
  late final questStartController = registerController(IntFieldController());
  late final questEndController = registerController(IntFieldController());
  late final auraSpellController = registerController(IntFieldController());
  late final racemaskController = registerController(FlagFieldController());
  late final genderController = registerController(
    SelectFieldController<int>(fallback: 2),
  );
  late final autocastController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final questStartStatusController = registerController(
    FlagFieldController(),
  );
  late final questEndStatusController = registerController(
    FlagFieldController(),
  );

  void _afterApplyCandidate(SpellAreaEntity spellArea) {}

  void _applyCandidate(SpellAreaEntity spellArea) {
    spellController.init(spellArea.spell);
    areaController.init(spellArea.area);
    questStartController.init(spellArea.questStart);
    questEndController.init(spellArea.questEnd);
    auraSpellController.init(spellArea.auraSpell);
    racemaskController.init(spellArea.racemask);
    genderController.init(spellArea.gender);
    autocastController.init(spellArea.autocast);
    questStartStatusController.init(spellArea.questStartStatus);
    questEndStatusController.init(spellArea.questEndStatus);
    _afterApplyCandidate(spellArea);
  }

  SpellAreaEntity _collectCandidate() {
    return SpellAreaEntity(
      spell: spellController.collect(),
      area: areaController.collect(),
      questStart: questStartController.collect(),
      questEnd: questEndController.collect(),
      auraSpell: auraSpellController.collect(),
      racemask: racemaskController.collect(),
      gender: genderController.collect(),
      autocast: autocastController.collect(),
      questStartStatus: questStartStatusController.collect(),
      questEndStatus: questEndStatusController.collect(),
    );
  }
}
