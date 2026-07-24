import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_faction_reward_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_quest_faction_reward')
class QuestFactionRewardEntity with _QuestFactionRewardEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Difficulty0')
  final int difficulty0;

  @FoxyBriefField()
  @FoxyFullField('Difficulty1')
  final int difficulty1;

  @FoxyBriefField()
  @FoxyFullField('Difficulty2')
  final int difficulty2;

  @FoxyBriefField()
  @FoxyFullField('Difficulty3')
  final int difficulty3;

  @FoxyBriefField()
  @FoxyFullField('Difficulty4')
  final int difficulty4;

  @FoxyBriefField()
  @FoxyFullField('Difficulty5')
  final int difficulty5;

  @FoxyBriefField()
  @FoxyFullField('Difficulty6')
  final int difficulty6;

  @FoxyBriefField()
  @FoxyFullField('Difficulty7')
  final int difficulty7;

  @FoxyBriefField()
  @FoxyFullField('Difficulty8')
  final int difficulty8;

  @FoxyBriefField()
  @FoxyFullField('Difficulty9')
  final int difficulty9;

  const QuestFactionRewardEntity({
    this.id = 0,
    this.difficulty0 = 0,
    this.difficulty1 = 0,
    this.difficulty2 = 0,
    this.difficulty3 = 0,
    this.difficulty4 = 0,
    this.difficulty5 = 0,
    this.difficulty6 = 0,
    this.difficulty7 = 0,
    this.difficulty8 = 0,
    this.difficulty9 = 0,
  });

  factory QuestFactionRewardEntity.fromJson(Map<String, dynamic> json) =>
      _QuestFactionRewardEntityMixin.fromJson(json);
}
