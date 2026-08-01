// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_addon_single_editor_view_model.dart';

mixin _GameObjectTemplateAddonSingleEditorViewModelMixin
    on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final factionController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final minGoldController = registerController(IntFieldController());
  late final maxGoldController = registerController(IntFieldController());
  late final artkit0Controller = registerController(IntFieldController());
  late final artkit1Controller = registerController(IntFieldController());
  late final artkit2Controller = registerController(IntFieldController());
  late final artkit3Controller = registerController(IntFieldController());

  GameObjectTemplateAddonEntity _collectCandidate() {
    return GameObjectTemplateAddonEntity(
      entry: entryController.collect(),
      faction: factionController.collect(),
      flags: flagsController.collect(),
      minGold: minGoldController.collect(),
      maxGold: maxGoldController.collect(),
      artkit0: artkit0Controller.collect(),
      artkit1: artkit1Controller.collect(),
      artkit2: artkit2Controller.collect(),
      artkit3: artkit3Controller.collect(),
    );
  }

  void _applyCandidate(GameObjectTemplateAddonEntity gameObjectTemplateAddon) {
    entryController.init(gameObjectTemplateAddon.entry);
    factionController.init(gameObjectTemplateAddon.faction);
    flagsController.init(gameObjectTemplateAddon.flags);
    minGoldController.init(gameObjectTemplateAddon.minGold);
    maxGoldController.init(gameObjectTemplateAddon.maxGold);
    artkit0Controller.init(gameObjectTemplateAddon.artkit0);
    artkit1Controller.init(gameObjectTemplateAddon.artkit1);
    artkit2Controller.init(gameObjectTemplateAddon.artkit2);
    artkit3Controller.init(gameObjectTemplateAddon.artkit3);
    _afterApplyCandidate(gameObjectTemplateAddon);
  }

  void _afterApplyCandidate(
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) {}
}
