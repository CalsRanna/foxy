import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_sort_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'QuestSortFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'name',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class QuestSortRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_quest_sort';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyQuestSort(int key) async {
    final source = await getQuestSort(key);
    if (source == null) {
      throw StateError('原任务排序不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeQuestSort(copied);
    return copied.id;
  }

  Future<int> countQuestSorts({QuestSortFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestSortEntity> createQuestSort() async {
    return QuestSortEntity(id: await _getNextId());
  }

  Future<void> destroyQuestSort(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原任务排序不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefQuestSortEntity>> getBriefQuestSorts({
    int page = 1,
    QuestSortFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'SortName_lang_zhCN'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefQuestSortEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<QuestSortEntity?> getQuestSort(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestSortEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getQuestSortLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<QuestSortEntity>> getQuestSorts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => QuestSortEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveQuestSortLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeQuestSort(QuestSortEntity questSort) async {
    if (questSort.id <= 0) {
      throw StateError('任务排序 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([questSort.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('任务排序 ${questSort.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateQuestSort(
    int originalKey,
    QuestSortEntity questSort,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(questSort.toJson());
      if (matchedRows == 0) {
        throw StateError('原任务排序不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的任务排序 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, QuestSortFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'SortName_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 32768) {
      throw StateError('任务排序编号已超出 QuestSortID 可引用范围');
    }
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
