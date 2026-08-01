// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickpocketing_loot_template_collection_editor_view_model.dart';

mixin _PickpocketingLootTemplateCollectionEditorViewModelMixin
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

  PickpocketingLootTemplateEntity _collectCandidate() {
    return PickpocketingLootTemplateEntity(
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

  void _applyCandidate(
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) {
    entryController.init(pickpocketingLootTemplate.entry);
    itemController.init(pickpocketingLootTemplate.item);
    referenceController.init(pickpocketingLootTemplate.reference);
    chanceController.init(pickpocketingLootTemplate.chance);
    questRequiredController.init(
      pickpocketingLootTemplate.questRequired ? 1 : 0,
    );
    lootModeController.init(pickpocketingLootTemplate.lootMode);
    groupIdController.init(pickpocketingLootTemplate.groupId);
    minCountController.init(pickpocketingLootTemplate.minCount);
    maxCountController.init(pickpocketingLootTemplate.maxCount);
    commentController.init(pickpocketingLootTemplate.comment);
    _afterApplyCandidate(pickpocketingLootTemplate);
  }

  void _afterApplyCandidate(
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) {}
}
