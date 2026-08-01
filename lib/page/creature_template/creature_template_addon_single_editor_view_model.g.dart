// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_addon_single_editor_view_model.dart';

mixin _CreatureTemplateAddonSingleEditorViewModelMixin on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final pathIdController = registerController(IntFieldController());
  late final mountController = registerController(IntFieldController());
  late final emoteController = registerController(IntFieldController());
  late final bytes1Controller = registerController(IntFieldController());
  late final bytes2Controller = registerController(IntFieldController());
  late final visibilityDistanceTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final aurasController = registerController(StringFieldController());

  CreatureTemplateAddonEntity _collectCandidate() {
    return CreatureTemplateAddonEntity(
      entry: entryController.collect(),
      pathId: pathIdController.collect(),
      mount: mountController.collect(),
      emote: emoteController.collect(),
      bytes1: bytes1Controller.collect(),
      bytes2: bytes2Controller.collect(),
      visibilityDistanceType: visibilityDistanceTypeController.collect(),
      auras: aurasController.collect(),
    );
  }

  void _applyCandidate(CreatureTemplateAddonEntity creatureTemplateAddon) {
    entryController.init(creatureTemplateAddon.entry);
    pathIdController.init(creatureTemplateAddon.pathId);
    mountController.init(creatureTemplateAddon.mount);
    emoteController.init(creatureTemplateAddon.emote);
    bytes1Controller.init(creatureTemplateAddon.bytes1);
    bytes2Controller.init(creatureTemplateAddon.bytes2);
    visibilityDistanceTypeController.init(
      creatureTemplateAddon.visibilityDistanceType,
    );
    aurasController.init(creatureTemplateAddon.auras);
    _afterApplyCandidate(creatureTemplateAddon);
  }

  void _afterApplyCandidate(
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) {}
}
