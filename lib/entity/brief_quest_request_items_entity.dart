import 'package:foxy/entity/quest_request_items_key.dart';

class BriefQuestRequestItemsEntity {
  final int id;
  final int emoteOnComplete;
  final int emoteOnIncomplete;
  final String completionText;

  const BriefQuestRequestItemsEntity({
    this.id = 0,
    this.emoteOnComplete = 0,
    this.emoteOnIncomplete = 0,
    this.completionText = '',
  });

  factory BriefQuestRequestItemsEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestRequestItemsEntity(
      id: json['ID'] ?? 0,
      emoteOnComplete: json['EmoteOnComplete'] ?? 0,
      emoteOnIncomplete: json['EmoteOnIncomplete'] ?? 0,
      completionText: json['CompletionText']?.toString() ?? '',
    );
  }

  QuestRequestItemsKey get key => QuestRequestItemsKey(id: id);
}
