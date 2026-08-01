// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_loot_template_collection_editor_view_model.dart';

mixin _SpellLootTemplateCollectionEditorViewModelMixin on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(IntFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  void _afterApplyCandidate(SpellLootTemplateEntity spellLootTemplate) {}

  void _applyCandidate(SpellLootTemplateEntity spellLootTemplate) {
    entryController.init(spellLootTemplate.entry);
    itemController.init(spellLootTemplate.item);
    referenceController.init(spellLootTemplate.reference);
    chanceController.init(spellLootTemplate.chance);
    questRequiredController.init(spellLootTemplate.questRequired);
    lootModeController.init(spellLootTemplate.lootMode);
    groupIdController.init(spellLootTemplate.groupId);
    minCountController.init(spellLootTemplate.minCount);
    maxCountController.init(spellLootTemplate.maxCount);
    commentController.init(spellLootTemplate.comment);
    _afterApplyCandidate(spellLootTemplate);
  }

  SpellLootTemplateEntity _collectCandidate() {
    return SpellLootTemplateEntity(
      entry: entryController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect(),
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }
}
