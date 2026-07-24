import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_request_items_entity.g.dart';

/// QuestRequestItems 模型
/// quest_request_items 表，1:1 关系与 quest_template，共享 ID 主键。

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
