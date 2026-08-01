// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_enchantment_template_collection_editor_view_model.dart';

mixin _ItemEnchantmentTemplateCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final enchController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());

  ItemEnchantmentTemplateEntity _collectCandidate() {
    return ItemEnchantmentTemplateEntity(
      entry: entryController.collect(),
      ench: enchController.collect(),
      chance: chanceController.collect(),
    );
  }

  void _applyCandidate(ItemEnchantmentTemplateEntity itemEnchantmentTemplate) {
    entryController.init(itemEnchantmentTemplate.entry);
    enchController.init(itemEnchantmentTemplate.ench);
    chanceController.init(itemEnchantmentTemplate.chance);
    _afterApplyCandidate(itemEnchantmentTemplate);
  }

  void _afterApplyCandidate(
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) {}
}
