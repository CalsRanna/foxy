// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_faction_reward_repository.dart';

final class QuestFactionRewardFilter {
  final String id;

  const QuestFactionRewardFilter({this.id = ''});

  factory QuestFactionRewardFilter.fromJson(Map<String, dynamic> json) {
    return QuestFactionRewardFilter(id: json['id']?.toString() ?? '');
  }

  QuestFactionRewardFilter copyWith({String? id}) {
    return QuestFactionRewardFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
