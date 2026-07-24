import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestRequestItemsRepository with RepositoryMixin {
  static const _table = 'quest_request_items';

  Future<int> copyQuestRequestItems(int key) async {
    final source = await getQuestRequestItems(key);
    if (source == null) {
      throw StateError('原任务提交物品数据不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeQuestRequestItems(copied);
    return copied.id;
  }

  Future<int> countQuestRequestItems() {
    return laconic.table(_table).count();
  }

  Future<QuestRequestItemsEntity> createQuestRequestItems([int? id]) async {
    return QuestRequestItemsEntity(
      id: id ?? await nextMaxPlusOne(_table, 'ID'),
    );
  }

  Future<void> destroyQuestRequestItems(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原任务提交物品数据不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefQuestRequestItemsEntity>> getBriefQuestRequestItems({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select([
          'ID',
          'EmoteOnComplete',
          'EmoteOnIncomplete',
          'CompletionText',
        ])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefQuestRequestItemsEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<QuestRequestItemsEntity?> getQuestRequestItems(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestRequestItemsEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestRequestItemsEntity>> getQuestRequestItemsList() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => QuestRequestItemsEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeQuestRequestItems(QuestRequestItemsEntity model) async {
    if (model.id <= 0) {
      throw StateError('任务提交物品数据 ID 必须显式指定');
    }
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('任务提交物品数据 ${model.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateQuestRequestItems(
    int originalKey,
    QuestRequestItemsEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原任务提交物品数据不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的任务提交物品数据 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
