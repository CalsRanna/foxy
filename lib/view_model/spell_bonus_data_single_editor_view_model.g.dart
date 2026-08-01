// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_bonus_data_single_editor_view_model.dart';

mixin _SpellBonusDataSingleEditorViewModelMixin on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final directBonusController = registerController(
    DoubleFieldController(),
  );
  late final dotBonusController = registerController(DoubleFieldController());
  late final apBonusController = registerController(DoubleFieldController());
  late final apDotBonusController = registerController(DoubleFieldController());
  late final commentsController = registerController(StringFieldController());

  void _afterApplyCandidate(SpellBonusDataEntity spellBonusData) {}

  void _applyCandidate(SpellBonusDataEntity spellBonusData) {
    entryController.init(spellBonusData.entry);
    directBonusController.init(spellBonusData.directBonus);
    dotBonusController.init(spellBonusData.dotBonus);
    apBonusController.init(spellBonusData.apBonus);
    apDotBonusController.init(spellBonusData.apDotBonus);
    commentsController.init(spellBonusData.comments);
    _afterApplyCandidate(spellBonusData);
  }

  SpellBonusDataEntity _collectCandidate() {
    return SpellBonusDataEntity(
      entry: entryController.collect(),
      directBonus: directBonusController.collect(),
      dotBonus: dotBonusController.collect(),
      apBonus: apBonusController.collect(),
      apDotBonus: apDotBonusController.collect(),
      comments: commentsController.collect(),
    );
  }
}
