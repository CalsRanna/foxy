// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_entity.dart';

mixin _QuestRequestItemsEntityMixin {
  int get id;
  int get emoteOnComplete;
  int get emoteOnIncomplete;
  String get completionText;
  int get verifiedBuild;

  static QuestRequestItemsEntity fromJson(Map<String, dynamic> json) {
    return QuestRequestItemsEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      emoteOnComplete: (json['EmoteOnComplete'] as num?)?.toInt() ?? 0,
      emoteOnIncomplete: (json['EmoteOnIncomplete'] as num?)?.toInt() ?? 0,
      completionText: json['CompletionText']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  QuestRequestItemsEntity copyWith({
    int? id,
    int? emoteOnComplete,
    int? emoteOnIncomplete,
    String? completionText,
    int? verifiedBuild,
  }) {
    return QuestRequestItemsEntity(
      id: id ?? this.id,
      emoteOnComplete: emoteOnComplete ?? this.emoteOnComplete,
      emoteOnIncomplete: emoteOnIncomplete ?? this.emoteOnIncomplete,
      completionText: completionText ?? this.completionText,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'EmoteOnComplete': emoteOnComplete,
      'EmoteOnIncomplete': emoteOnIncomplete,
      'CompletionText': completionText,
      'VerifiedBuild': verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestRequestItemsEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            emoteOnComplete == other.emoteOnComplete &&
            emoteOnIncomplete == other.emoteOnIncomplete &&
            completionText == other.completionText &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      emoteOnComplete,
      emoteOnIncomplete,
      completionText,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'QuestRequestItemsEntity('
        'id: $id, '
        'emoteOnComplete: $emoteOnComplete, '
        'emoteOnIncomplete: $emoteOnIncomplete, '
        'completionText: $completionText, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
