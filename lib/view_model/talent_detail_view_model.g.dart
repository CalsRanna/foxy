// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_detail_view_model.dart';

mixin _TalentDetailViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final tabIdController = registerController(IntFieldController());
  late final tierIdController = registerController(IntFieldController());
  late final columnIndexController = registerController(IntFieldController());
  late final spellRank0Controller = registerController(IntFieldController());
  late final spellRank1Controller = registerController(IntFieldController());
  late final spellRank2Controller = registerController(IntFieldController());
  late final spellRank3Controller = registerController(IntFieldController());
  late final spellRank4Controller = registerController(IntFieldController());
  late final spellRank5Controller = registerController(IntFieldController());
  late final spellRank6Controller = registerController(IntFieldController());
  late final spellRank7Controller = registerController(IntFieldController());
  late final spellRank8Controller = registerController(IntFieldController());
  late final prereqTalent0Controller = registerController(IntFieldController());
  late final prereqTalent1Controller = registerController(IntFieldController());
  late final prereqTalent2Controller = registerController(IntFieldController());
  late final prereqRank0Controller = registerController(IntFieldController());
  late final prereqRank1Controller = registerController(IntFieldController());
  late final prereqRank2Controller = registerController(IntFieldController());
  late final flagsController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final requiredSpellIdController = registerController(
    IntFieldController(),
  );
  late final categoryMask0Controller = registerController(IntFieldController());
  late final categoryMask1Controller = registerController(IntFieldController());

  void _afterApplyCandidate(TalentEntity talent) {}

  void _applyCandidate(TalentEntity talent) {
    idController.init(talent.id);
    tabIdController.init(talent.tabId);
    tierIdController.init(talent.tierId);
    columnIndexController.init(talent.columnIndex);
    spellRank0Controller.init(talent.spellRank0);
    spellRank1Controller.init(talent.spellRank1);
    spellRank2Controller.init(talent.spellRank2);
    spellRank3Controller.init(talent.spellRank3);
    spellRank4Controller.init(talent.spellRank4);
    spellRank5Controller.init(talent.spellRank5);
    spellRank6Controller.init(talent.spellRank6);
    spellRank7Controller.init(talent.spellRank7);
    spellRank8Controller.init(talent.spellRank8);
    prereqTalent0Controller.init(talent.prereqTalent0);
    prereqTalent1Controller.init(talent.prereqTalent1);
    prereqTalent2Controller.init(talent.prereqTalent2);
    prereqRank0Controller.init(talent.prereqRank0);
    prereqRank1Controller.init(talent.prereqRank1);
    prereqRank2Controller.init(talent.prereqRank2);
    flagsController.init(talent.flags);
    requiredSpellIdController.init(talent.requiredSpellId);
    categoryMask0Controller.init(talent.categoryMask0);
    categoryMask1Controller.init(talent.categoryMask1);
    _afterApplyCandidate(talent);
  }

  TalentEntity _collectCandidate() {
    return TalentEntity(
      id: idController.collect(),
      tabId: tabIdController.collect(),
      tierId: tierIdController.collect(),
      columnIndex: columnIndexController.collect(),
      spellRank0: spellRank0Controller.collect(),
      spellRank1: spellRank1Controller.collect(),
      spellRank2: spellRank2Controller.collect(),
      spellRank3: spellRank3Controller.collect(),
      spellRank4: spellRank4Controller.collect(),
      spellRank5: spellRank5Controller.collect(),
      spellRank6: spellRank6Controller.collect(),
      spellRank7: spellRank7Controller.collect(),
      spellRank8: spellRank8Controller.collect(),
      prereqTalent0: prereqTalent0Controller.collect(),
      prereqTalent1: prereqTalent1Controller.collect(),
      prereqTalent2: prereqTalent2Controller.collect(),
      prereqRank0: prereqRank0Controller.collect(),
      prereqRank1: prereqRank1Controller.collect(),
      prereqRank2: prereqRank2Controller.collect(),
      flags: flagsController.collect(),
      requiredSpellId: requiredSpellIdController.collect(),
      categoryMask0: categoryMask0Controller.collect(),
      categoryMask1: categoryMask1Controller.collect(),
    );
  }
}
