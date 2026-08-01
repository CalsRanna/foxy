// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prospecting_loot_template_collection_editor_view_model.dart';

mixin _ProspectingLootTemplateCollectionEditorViewModelMixin
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

  void _afterApplyCandidate(
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) {}

  void _applyCandidate(ProspectingLootTemplateEntity prospectingLootTemplate) {
    entryController.init(prospectingLootTemplate.entry);
    itemController.init(prospectingLootTemplate.item);
    referenceController.init(prospectingLootTemplate.reference);
    chanceController.init(prospectingLootTemplate.chance);
    questRequiredController.init(prospectingLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(prospectingLootTemplate.lootMode);
    groupIdController.init(prospectingLootTemplate.groupId);
    minCountController.init(prospectingLootTemplate.minCount);
    maxCountController.init(prospectingLootTemplate.maxCount);
    commentController.init(prospectingLootTemplate.comment);
    _afterApplyCandidate(prospectingLootTemplate);
  }

  ProspectingLootTemplateEntity _collectCandidate() {
    return ProspectingLootTemplateEntity(
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
}
