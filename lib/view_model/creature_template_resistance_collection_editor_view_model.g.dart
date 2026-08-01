// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_resistance_collection_editor_view_model.dart';

mixin _CreatureTemplateResistanceCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final creatureIDController = registerController(IntFieldController());
  late final schoolController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final resistanceController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  CreatureTemplateResistanceEntity _collectCandidate() {
    return CreatureTemplateResistanceEntity(
      creatureID: creatureIDController.collect(),
      school: schoolController.collect(),
      resistance: resistanceController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _applyCandidate(
    CreatureTemplateResistanceEntity creatureTemplateResistance,
  ) {
    creatureIDController.init(creatureTemplateResistance.creatureID);
    schoolController.init(creatureTemplateResistance.school);
    resistanceController.init(creatureTemplateResistance.resistance);
    verifiedBuildController.init(creatureTemplateResistance.verifiedBuild);
    _afterApplyCandidate(creatureTemplateResistance);
  }

  void _afterApplyCandidate(
    CreatureTemplateResistanceEntity creatureTemplateResistance,
  ) {}
}
