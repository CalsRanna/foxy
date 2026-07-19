import 'package:foxy/entity/brief_quest_request_items_locale_entity.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/entity/quest_request_items_locale_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestRequestItemsLocaleRepository with RepositoryMixin {
  static const _table = 'quest_request_items_locale';
  static const primaryKeyColumns = {'ID', 'locale'};

  Future<void> applyQuestRequestItemsLocaleChanges({
    required List<QuestRequestItemsLocaleEntity> creations,
    required List<QuestRequestItemsLocaleKey> deletions,
    required Map<QuestRequestItemsLocaleKey, QuestRequestItemsLocaleEntity>
    updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyQuestRequestItemsLocale(key);
      }
      for (final update in updates.entries) {
        await updateQuestRequestItemsLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeQuestRequestItemsLocale(locale);
      }
    });
  }

  Future<int> countQuestRequestItemsLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<QuestRequestItemsLocaleEntity> createQuestRequestItemsLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return QuestRequestItemsLocaleEntity(id: id, locale: locale);
  }

  Future<void> destroyQuestRequestItemsLocale(
    QuestRequestItemsLocaleKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原任务物品本地化记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefQuestRequestItemsLocaleEntity>>
  getBriefQuestRequestItemsLocales({required int id, int page = 1}) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'CompletionText'])
        .where('ID', id)
        .orderBy('locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefQuestRequestItemsLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<QuestRequestItemsLocaleEntity?> getQuestRequestItemsLocale(
    QuestRequestItemsLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestRequestItemsLocaleEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestRequestItemsLocaleEntity>>
  getQuestRequestItemsLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => QuestRequestItemsLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeQuestRequestItemsLocale(
    QuestRequestItemsLocaleEntity model,
  ) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('任务物品本地化主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateQuestRequestItemsLocale(
    QuestRequestItemsLocaleKey originalKey,
    QuestRequestItemsLocaleEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原任务物品本地化记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的任务物品本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, QuestRequestItemsLocaleKey key) {
    return builder.where('ID', key.id).where('locale', key.locale);
  }
}
