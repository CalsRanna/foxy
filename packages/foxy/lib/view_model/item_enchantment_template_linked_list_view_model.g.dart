// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_enchantment_template_linked_list_view_model.dart';

mixin _ItemEnchantmentTemplateLinkedListViewModelMixin on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final enchController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());

  void _afterApplyCandidate(
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) {}

  void _applyCandidate(ItemEnchantmentTemplateEntity itemEnchantmentTemplate) {
    entryController.init(itemEnchantmentTemplate.entry);
    enchController.init(itemEnchantmentTemplate.ench);
    chanceController.init(itemEnchantmentTemplate.chance);
    _afterApplyCandidate(itemEnchantmentTemplate);
  }

  ItemEnchantmentTemplateEntity _collectCandidate() {
    return ItemEnchantmentTemplateEntity(
      entry: entryController.collect(),
      ench: enchController.collect(),
      chance: chanceController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'item_enchantment_template',
          actionType: action,
          entityName: 'ItemEnchantmentTemplate',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
