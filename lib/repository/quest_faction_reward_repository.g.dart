// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_faction_reward_repository.dart';

mixin _QuestFactionRewardRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestFactionReward(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_quest_faction_reward'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestFactionRewardEntity?> getQuestFactionReward(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_quest_faction_reward'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestFactionRewardEntity.fromJson(results.first.toMap());
  }

  Future<void> updateQuestFactionReward(
    int originalKey,
    QuestFactionRewardEntity questFactionReward,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_quest_faction_reward'),
        originalKey,
      ).update(questFactionReward.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
