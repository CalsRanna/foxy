// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_on_kill_reputation_single_editor_view_model.dart';

mixin _CreatureOnKillReputationSingleEditorViewModelMixin
    on FieldControllerMixin {
  late final creatureIDController = registerController(IntFieldController());
  late final rewOnKillRepFaction1Controller = registerController(
    IntFieldController(),
  );
  late final rewOnKillRepFaction2Controller = registerController(
    IntFieldController(),
  );
  late final maxStanding1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final maxStanding2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final isTeamAward1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final isTeamAward2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final rewOnKillRepValue1Controller = registerController(
    DoubleFieldController(),
  );
  late final rewOnKillRepValue2Controller = registerController(
    DoubleFieldController(),
  );
  late final teamDependentController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  CreatureOnKillReputationEntity _collectCandidate() {
    return CreatureOnKillReputationEntity(
      creatureID: creatureIDController.collect(),
      rewOnKillRepFaction1: rewOnKillRepFaction1Controller.collect(),
      rewOnKillRepFaction2: rewOnKillRepFaction2Controller.collect(),
      maxStanding1: maxStanding1Controller.collect(),
      maxStanding2: maxStanding2Controller.collect(),
      isTeamAward1: isTeamAward1Controller.collect() == 1,
      isTeamAward2: isTeamAward2Controller.collect() == 1,
      rewOnKillRepValue1: rewOnKillRepValue1Controller.collect(),
      rewOnKillRepValue2: rewOnKillRepValue2Controller.collect(),
      teamDependent: teamDependentController.collect(),
    );
  }

  void _applyCandidate(
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) {
    creatureIDController.init(creatureOnKillReputation.creatureID);
    rewOnKillRepFaction1Controller.init(
      creatureOnKillReputation.rewOnKillRepFaction1,
    );
    rewOnKillRepFaction2Controller.init(
      creatureOnKillReputation.rewOnKillRepFaction2,
    );
    maxStanding1Controller.init(creatureOnKillReputation.maxStanding1);
    maxStanding2Controller.init(creatureOnKillReputation.maxStanding2);
    isTeamAward1Controller.init(creatureOnKillReputation.isTeamAward1 ? 1 : 0);
    isTeamAward2Controller.init(creatureOnKillReputation.isTeamAward2 ? 1 : 0);
    rewOnKillRepValue1Controller.init(
      creatureOnKillReputation.rewOnKillRepValue1,
    );
    rewOnKillRepValue2Controller.init(
      creatureOnKillReputation.rewOnKillRepValue2,
    );
    teamDependentController.init(creatureOnKillReputation.teamDependent);
    _afterApplyCandidate(creatureOnKillReputation);
  }

  void _afterApplyCandidate(
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) {}
}
