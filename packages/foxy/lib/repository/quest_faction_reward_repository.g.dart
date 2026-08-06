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

mixin _QuestFactionRewardRepositoryMixin on RepositoryMixin {
  Future<int> copyQuestFactionReward(int key) async {
    final source = await getQuestFactionReward(key);
    if (source == null) {
      throw RecordNotFoundException(
        'foxy.dbc_quest_faction_reward record not found',
      );
    }
    final blank = await createQuestFactionReward();
    final copied = source.copyWith(id: blank.id);
    await storeQuestFactionReward(copied);
    return copied.id;
  }

  Future<int> countQuestFactionRewards({
    QuestFactionRewardFilter? filter,
  }) async {
    return _applyFilter(
      laconic.table('foxy.dbc_quest_faction_reward'),
      filter,
    ).count();
  }

  Future<QuestFactionRewardEntity> createQuestFactionReward() async {
    return QuestFactionRewardEntity(
      id: await nextMaxPlusOne('foxy.dbc_quest_faction_reward', '`ID`'),
    );
  }

  Future<void> destroyQuestFactionReward(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_quest_faction_reward'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_quest_faction_reward record not found',
      );
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

  Future<List<BriefQuestFactionRewardEntity>> getBriefQuestFactionRewards({
    int page = 1,
    QuestFactionRewardFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_quest_faction_reward').select([
      '`ID`',
      '`Difficulty0`',
      '`Difficulty1`',
      '`Difficulty2`',
      '`Difficulty3`',
      '`Difficulty4`',
      '`Difficulty5`',
      '`Difficulty6`',
      '`Difficulty7`',
      '`Difficulty8`',
      '`Difficulty9`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefQuestFactionRewardEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestFactionRewardEntity>> getQuestFactionRewards() async {
    var builder = laconic
        .table('foxy.dbc_quest_faction_reward')
        .orderBy('`ID`');
    final results = await builder.get();
    return results
        .map((e) => QuestFactionRewardEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeQuestFactionReward(
    QuestFactionRewardEntity questFactionReward,
  ) async {
    if (questFactionReward.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(questFactionReward);
    final json = prepareWriteJson(questFactionReward.toJson());
    try {
      await laconic.table('foxy.dbc_quest_faction_reward').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questFactionReward.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_quest_faction_reward', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_quest_faction_reward').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_quest_faction_reward',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateQuestFactionReward(
    int originalKey,
    QuestFactionRewardEntity questFactionReward,
  ) async {
    await _beforeUpdate(originalKey, questFactionReward);
    final json = prepareWriteJson(questFactionReward.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_quest_faction_reward'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_quest_faction_reward',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_quest_faction_reward record not found',
      );
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    QuestFactionRewardFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    QuestFactionRewardEntity questFactionReward,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestFactionRewardEntity questFactionReward,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
