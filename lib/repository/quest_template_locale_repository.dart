import 'package:foxy/entity/brief_quest_template_locale_entity.dart';
import 'package:foxy/entity/quest_template_locale_entity.dart';
import 'package:foxy/entity/quest_template_locale_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestTemplateLocaleRepository with RepositoryMixin {
  static const _table = 'quest_template_locale';
  static const primaryKeyColumns = {'ID', 'locale'};

  Future<void> applyQuestTemplateLocaleChanges({
    required List<QuestTemplateLocaleEntity> creations,
    required List<QuestTemplateLocaleKey> deletions,
    required Map<QuestTemplateLocaleKey, QuestTemplateLocaleEntity> updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyQuestTemplateLocale(key);
      }
      for (final update in updates.entries) {
        await updateQuestTemplateLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeQuestTemplateLocale(locale);
      }
    });
  }

  Future<int> countQuestTemplateLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<QuestTemplateLocaleEntity> createQuestTemplateLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return QuestTemplateLocaleEntity(id: id, locale: locale);
  }

  Future<void> destroyQuestTemplateLocale(QuestTemplateLocaleKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原任务模板本地化记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefQuestTemplateLocaleEntity>> getBriefQuestTemplateLocales({
    required int id,
    int page = 1,
  }) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'Title'])
        .where('ID', id)
        .orderBy('locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefQuestTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<QuestTemplateLocaleEntity?> getQuestTemplateLocale(
    QuestTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestTemplateLocaleEntity>>
  getQuestTemplateLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => QuestTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeQuestTemplateLocale(QuestTemplateLocaleEntity model) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('任务模板本地化主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateQuestTemplateLocale(
    QuestTemplateLocaleKey originalKey,
    QuestTemplateLocaleEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原任务模板本地化记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的任务模板本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, QuestTemplateLocaleKey key) {
    return builder.where('ID', key.id).where('locale', key.locale);
  }
}
