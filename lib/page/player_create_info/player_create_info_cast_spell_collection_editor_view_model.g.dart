// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_cast_spell_collection_editor_view_model.dart';

mixin _PlayerCreateInfoCastSpellCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final raceMaskController = registerController(FlagFieldController());
  late final classMaskController = registerController(FlagFieldController());
  late final spellController = registerController(IntFieldController());
  late final noteController = registerController(
    NullableStringFieldController(),
  );

  PlayerCreateInfoCastSpellEntity _collectCandidate() {
    return PlayerCreateInfoCastSpellEntity(
      raceMask: raceMaskController.collect(),
      classMask: classMaskController.collect(),
      spell: spellController.collect(),
      note: noteController.collect(),
    );
  }

  void _applyCandidate(
    PlayerCreateInfoCastSpellEntity playerCreateInfoCastSpell,
  ) {
    raceMaskController.init(playerCreateInfoCastSpell.raceMask);
    classMaskController.init(playerCreateInfoCastSpell.classMask);
    spellController.init(playerCreateInfoCastSpell.spell);
    noteController.init(playerCreateInfoCastSpell.note);
    _afterApplyCandidate(playerCreateInfoCastSpell);
  }

  void _afterApplyCandidate(
    PlayerCreateInfoCastSpellEntity playerCreateInfoCastSpell,
  ) {}
}
