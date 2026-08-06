import 'package:foxy_annotation/entity_annotations.dart';

part 'quest_request_items_entity.g.dart';

/// QuestRequestItems model
/// quest_request_items table, 1:1 with quest_template, sharing the ID
/// primary key.

@FoxyBriefEntity()
@FoxyFullEntity(table: 'quest_request_items')
class QuestRequestItemsEntity with _QuestRequestItemsEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('EmoteOnComplete')
  final int emoteOnComplete;

  @FoxyBriefField()
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
