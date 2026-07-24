import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_on_kill_reputation_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'creature_onkill_reputation')
class CreatureOnKillReputationEntity with _CreatureOnKillReputationEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('creature_id', key: true)
  final int creatureID;

  @FoxyBriefField()
  @FoxyFullField('RewOnKillRepFaction1')
  final int rewOnKillRepFaction1;

  @FoxyBriefField()
  @FoxyFullField('RewOnKillRepFaction2')
  final int rewOnKillRepFaction2;

  @FoxyFullField('MaxStanding1')
  final int maxStanding1;

  @FoxyFullField('MaxStanding2')
  final int maxStanding2;

  @FoxyFullField('IsTeamAward1')
  final bool isTeamAward1;

  @FoxyFullField('IsTeamAward2')
  final bool isTeamAward2;

  @FoxyBriefField()
  @FoxyFullField('RewOnKillRepValue1')
  final double rewOnKillRepValue1;

  @FoxyBriefField()
  @FoxyFullField('RewOnKillRepValue2')
  final double rewOnKillRepValue2;

  @FoxyBriefField()
  @FoxyFullField('TeamDependent')
  final int teamDependent;

  const CreatureOnKillReputationEntity({
    this.creatureID = 0,
    this.rewOnKillRepFaction1 = 0,
    this.rewOnKillRepFaction2 = 0,
    this.maxStanding1 = 0,
    this.maxStanding2 = 0,
    this.isTeamAward1 = false,
    this.isTeamAward2 = false,
    this.rewOnKillRepValue1 = 0.0,
    this.rewOnKillRepValue2 = 0.0,
    this.teamDependent = 0,
  });

  factory CreatureOnKillReputationEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureOnKillReputationEntityMixin.fromJson(json);
}
