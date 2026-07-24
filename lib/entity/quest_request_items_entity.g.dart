// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_entity.dart';

mixin _QuestRequestItemsEntityMixin {
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
}
