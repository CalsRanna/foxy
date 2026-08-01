// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_loot_template_detail_view_model.dart';

mixin _ReferenceLootTemplateDetailViewModelMixin on FieldControllerMixin {
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

  ReferenceLootTemplateEntity _collectCandidate() {
    return ReferenceLootTemplateEntity(
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

  void _applyCandidate(ReferenceLootTemplateEntity referenceLootTemplate) {
    entryController.init(referenceLootTemplate.entry);
    itemController.init(referenceLootTemplate.item);
    referenceController.init(referenceLootTemplate.reference);
    chanceController.init(referenceLootTemplate.chance);
    questRequiredController.init(referenceLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(referenceLootTemplate.lootMode);
    groupIdController.init(referenceLootTemplate.groupId);
    minCountController.init(referenceLootTemplate.minCount);
    maxCountController.init(referenceLootTemplate.maxCount);
    commentController.init(referenceLootTemplate.comment);
    _afterApplyCandidate(referenceLootTemplate);
  }

  void _afterApplyCandidate(
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) {}
}
