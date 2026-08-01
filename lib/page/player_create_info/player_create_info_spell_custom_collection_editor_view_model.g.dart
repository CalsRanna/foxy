// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_spell_custom_collection_editor_view_model.dart';

mixin _PlayerCreateInfoSpellCustomCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final raceMaskController = registerController(FlagFieldController());
  late final classMaskController = registerController(FlagFieldController());
  late final spellController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

  PlayerCreateInfoSpellCustomEntity _collectCandidate() {
    return PlayerCreateInfoSpellCustomEntity(
      raceMask: raceMaskController.collect(),
      classMask: classMaskController.collect(),
      spell: spellController.collect(),
      note: noteController.collect(),
    );
  }

  void _applyCandidate(
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) {
    raceMaskController.init(playerCreateInfoSpellCustom.raceMask);
    classMaskController.init(playerCreateInfoSpellCustom.classMask);
    spellController.init(playerCreateInfoSpellCustom.spell);
    noteController.init(playerCreateInfoSpellCustom.note);
    _afterApplyCandidate(playerCreateInfoSpellCustom);
  }

  void _afterApplyCandidate(
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) {}
}
