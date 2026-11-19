import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'quest_request_items_entity.g.dart';

/// QuestRequestItems model
/// quest_request_items table, 1:1 with quest_template, sharing the ID
/// primary key.

@FoxyBriefEntity()
@FoxyFullEntity()
class QuestRequestItemsEntity with _QuestRequestItemsEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference('任务', table: 'quest_template', column: 'ID')
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('完成表情', table: 'foxy.dbc_emotes', column: 'ID')
  @FoxyFullField('EmoteOnComplete')
  final int emoteOnComplete;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('未完成表情', table: 'foxy.dbc_emotes', column: 'ID')
  @FoxyFullField('EmoteOnIncomplete')
  final int emoteOnIncomplete;

  @FoxyBriefField()
  @FoxyFullField('CompletionText')
  final String completionText;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const QuestRequestItemsEntity({
    this.id = 0,
    this.emoteOnComplete = 0,
    this.emoteOnIncomplete = 0,
    this.completionText = '',
    this.verifiedBuild = 0,
  });

  factory QuestRequestItemsEntity.fromJson(Map<String, dynamic> json) =>
      _QuestRequestItemsEntityMixin.fromJson(json);
}
