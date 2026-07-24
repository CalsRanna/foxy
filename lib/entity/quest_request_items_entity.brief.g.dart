// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefQuestRequestItemsEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      emoteOnComplete: (json['EmoteOnComplete'] as num?)?.toInt() ?? 0,
      emoteOnIncomplete: (json['EmoteOnIncomplete'] as num?)?.toInt() ?? 0,
      completionText: json['CompletionText']?.toString() ?? '',
    );
  }

  int get key => id;
}
