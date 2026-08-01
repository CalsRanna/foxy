// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_vendor_collection_editor_view_model.dart';

mixin _NpcVendorCollectionEditorViewModelMixin on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final slotController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final maxcountController = registerController(IntFieldController());
  late final incrtimeController = registerController(IntFieldController());
  late final extendedCostController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(NpcVendorEntity npcVendor) {}

  void _applyCandidate(NpcVendorEntity npcVendor) {
    entryController.init(npcVendor.entry);
    slotController.init(npcVendor.slot);
    itemController.init(npcVendor.item);
    maxcountController.init(npcVendor.maxcount);
    incrtimeController.init(npcVendor.incrtime);
    extendedCostController.init(npcVendor.extendedCost);
    verifiedBuildController.init(npcVendor.verifiedBuild);
    _afterApplyCandidate(npcVendor);
  }

  NpcVendorEntity _collectCandidate() {
    return NpcVendorEntity(
      entry: entryController.collect(),
      slot: slotController.collect(),
      item: itemController.collect(),
      maxcount: maxcountController.collect(),
      incrtime: incrtimeController.collect(),
      extendedCost: extendedCostController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }
}
