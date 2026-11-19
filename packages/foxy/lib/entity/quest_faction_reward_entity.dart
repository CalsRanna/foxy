import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'quest_faction_reward_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_quest_faction_reward')
class QuestFactionRewardEntity with _QuestFactionRewardEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度0阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty0')
  final int difficulty0;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度1阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty1')
  final int difficulty1;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度2阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty2')
  final int difficulty2;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度3阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty3')
  final int difficulty3;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度4阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty4')
  final int difficulty4;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度5阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty5')
  final int difficulty5;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度6阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty6')
  final int difficulty6;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度7阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty7')
  final int difficulty7;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度8阵营', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Difficulty8')
  final int difficulty8;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('难度9阵营', table: 'foxy.dbc_faction', column: 'ID')
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
