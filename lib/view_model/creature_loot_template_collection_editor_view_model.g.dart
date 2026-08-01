// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_loot_template_collection_editor_view_model.dart';

mixin _CreatureLootTemplateCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(FlagFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  CreatureLootTemplateEntity _collectCandidate() {
    return CreatureLootTemplateEntity(
      entry: entryController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect() == 1,
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }

  void _applyCandidate(CreatureLootTemplateEntity creatureLootTemplate) {
    entryController.init(creatureLootTemplate.entry);
    itemController.init(creatureLootTemplate.item);
    referenceController.init(creatureLootTemplate.reference);
    chanceController.init(creatureLootTemplate.chance);
    questRequiredController.init(creatureLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(creatureLootTemplate.lootMode);
    groupIdController.init(creatureLootTemplate.groupId);
    minCountController.init(creatureLootTemplate.minCount);
    maxCountController.init(creatureLootTemplate.maxCount);
    commentController.init(creatureLootTemplate.comment);
    _afterApplyCandidate(creatureLootTemplate);
  }

  void _afterApplyCandidate(CreatureLootTemplateEntity creatureLootTemplate) {}
}
