// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_entity.dart';

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
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      emoteOnComplete: json['EmoteOnComplete'] == true
          ? 1
          : json['EmoteOnComplete'] == false
          ? 0
          : (json['EmoteOnComplete'] as num?)?.toInt() ?? 0,
      emoteOnIncomplete: json['EmoteOnIncomplete'] == true
          ? 1
          : json['EmoteOnIncomplete'] == false
          ? 0
          : (json['EmoteOnIncomplete'] as num?)?.toInt() ?? 0,
      completionText: json['CompletionText']?.toString() ?? '',
    );
  }

  @override
  int get hashCode =>
      Object.hashAll([id, emoteOnComplete, emoteOnIncomplete, completionText]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefQuestRequestItemsEntity &&
            id == other.id &&
            emoteOnComplete == other.emoteOnComplete &&
            emoteOnIncomplete == other.emoteOnIncomplete &&
            completionText == other.completionText;
  }

  @override
  String toString() {
    return 'BriefQuestRequestItemsEntity('
        'id: $id, '
        'emoteOnComplete: $emoteOnComplete, '
        'emoteOnIncomplete: $emoteOnIncomplete, '
        'completionText: $completionText'
        ')';
  }
}

mixin _QuestRequestItemsEntityMixin {
  @override
  int get hashCode {
    final self = this as QuestRequestItemsEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.emoteOnComplete,
      self.emoteOnIncomplete,
      self.completionText,
      self.verifiedBuild,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestRequestItemsEntity;
    return identical(self, other) ||
        other is QuestRequestItemsEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.emoteOnComplete == other.emoteOnComplete &&
            self.emoteOnIncomplete == other.emoteOnIncomplete &&
            self.completionText == other.completionText &&
            self.verifiedBuild == other.verifiedBuild;
  }

  QuestRequestItemsEntity copyWith({
    int? id,
    int? emoteOnComplete,
    int? emoteOnIncomplete,
    String? completionText,
    int? verifiedBuild,
  }) {
    final self = this as QuestRequestItemsEntity;
    return QuestRequestItemsEntity(
      id: id ?? self.id,
      emoteOnComplete: emoteOnComplete ?? self.emoteOnComplete,
      emoteOnIncomplete: emoteOnIncomplete ?? self.emoteOnIncomplete,
      completionText: completionText ?? self.completionText,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestRequestItemsEntity;
    return {
      'ID': self.id,
      'EmoteOnComplete': self.emoteOnComplete,
      'EmoteOnIncomplete': self.emoteOnIncomplete,
      'CompletionText': self.completionText,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  String toString() {
    final self = this as QuestRequestItemsEntity;
    return 'QuestRequestItemsEntity('
        'id: ${self.id}, '
        'emoteOnComplete: ${self.emoteOnComplete}, '
        'emoteOnIncomplete: ${self.emoteOnIncomplete}, '
        'completionText: ${self.completionText}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }

  static QuestRequestItemsEntity fromJson(Map<String, dynamic> json) {
    return QuestRequestItemsEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      emoteOnComplete: json['EmoteOnComplete'] == true
          ? 1
          : json['EmoteOnComplete'] == false
          ? 0
          : (json['EmoteOnComplete'] as num?)?.toInt() ?? 0,
      emoteOnIncomplete: json['EmoteOnIncomplete'] == true
          ? 1
          : json['EmoteOnIncomplete'] == false
          ? 0
          : (json['EmoteOnIncomplete'] as num?)?.toInt() ?? 0,
      completionText: json['CompletionText']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'] == true
          ? 1
          : json['VerifiedBuild'] == false
          ? 0
          : (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }
}
