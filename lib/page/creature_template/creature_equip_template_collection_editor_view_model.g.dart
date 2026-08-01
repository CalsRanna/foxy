// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_equip_template_collection_editor_view_model.dart';

mixin _CreatureEquipTemplateCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final creatureIDController = registerController(IntFieldController());
  late final idController = registerController(IntFieldController());
  late final itemID1Controller = registerController(IntFieldController());
  late final itemID2Controller = registerController(IntFieldController());
  late final itemID3Controller = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  CreatureEquipTemplateEntity _collectCandidate() {
    return CreatureEquipTemplateEntity(
      creatureID: creatureIDController.collect(),
      id: idController.collect(),
      itemID1: itemID1Controller.collect(),
      itemID2: itemID2Controller.collect(),
      itemID3: itemID3Controller.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _applyCandidate(CreatureEquipTemplateEntity creatureEquipTemplate) {
    creatureIDController.init(creatureEquipTemplate.creatureID);
    idController.init(creatureEquipTemplate.id);
    itemID1Controller.init(creatureEquipTemplate.itemID1);
    itemID2Controller.init(creatureEquipTemplate.itemID2);
    itemID3Controller.init(creatureEquipTemplate.itemID3);
    verifiedBuildController.init(creatureEquipTemplate.verifiedBuild);
    _afterApplyCandidate(creatureEquipTemplate);
  }

  void _afterApplyCandidate(
    CreatureEquipTemplateEntity creatureEquipTemplate,
  ) {}
}
