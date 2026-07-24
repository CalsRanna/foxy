import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestTemplateAddonRepository with RepositoryMixin {
  static const _table = 'quest_template_addon';

  Future<int> copyQuestTemplateAddon(int key) async {
    final source = await getQuestTemplateAddon(key);
    if (source == null) {
      throw StateError('原任务模板附加数据不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeQuestTemplateAddon(copied);
    return copied.id;
  }

  Future<int> countQuestTemplateAddons() {
    return laconic.table(_table).count();
  }

  Future<QuestTemplateAddonEntity> createQuestTemplateAddon([int? id]) async {
    return QuestTemplateAddonEntity(
      id: id ?? await nextMaxPlusOne(_table, 'ID'),
    );
  }

  Future<void> destroyQuestTemplateAddon(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原任务模板附加数据不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefQuestTemplateAddonEntity>> getBriefQuestTemplateAddons({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select([
          'ID',
          'MaxLevel',
          'PrevQuestID',
          'NextQuestID',
          'SpecialFlags',
        ])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefQuestTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<QuestTemplateAddonEntity?> getQuestTemplateAddon(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestTemplateAddonEntity>> getQuestTemplateAddons() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => QuestTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeQuestTemplateAddon(QuestTemplateAddonEntity model) async {
    if (model.id <= 0) {
      throw StateError('任务模板附加数据 ID 必须显式指定');
    }
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('任务模板附加数据 ${model.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateQuestTemplateAddon(
    int originalKey,
    QuestTemplateAddonEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原任务模板附加数据不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的任务模板附加数据 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
