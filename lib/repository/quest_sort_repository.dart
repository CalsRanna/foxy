import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/entity/quest_sort_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestSortRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_quest_sort';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copyQuestSort(int id) async {
    var source = await getQuestSort(id);
    if (source == null) return;
    final nextId = await _getNextId();
    final candidate = source.copyWith(id: nextId);
    var json = candidate.toJson();
    await laconic.table(_table).insert([json]);
  }

  Future<int> countQuestSorts({QuestSortFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestSortEntity> createQuestSort() async {
    return QuestSortEntity(id: await _getNextId());
  }

  Future<void> destroyQuestSort(int id) async {
    if (await _isReferencedByQuest(id)) {
      throw StateError('任务排序 $id 仍被任务模板引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefQuestSortEntity>> getBriefQuestSorts({
    int page = 1,
    QuestSortFilterEntity? filter,
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

  Future<QuestSortEntity?> getQuestSort(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
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

  Future<void> saveQuestSort(QuestSortEntity questSort) async {
    if (questSort.id == 0) {
      await storeQuestSort(questSort);
      return;
    }
    var existing = await getQuestSort(questSort.id);
    if (existing != null) {
      await updateQuestSort(questSort);
    } else {
      await laconic.table(_table).insert([questSort.toJson()]);
    }
  }

  Future<void> saveQuestSortLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeQuestSort(QuestSortEntity questSort) async {
    final id = questSort.id > 0 ? questSort.id : await _getNextId();
    final candidate = questSort.copyWith(id: id);
    var json = candidate.toJson();
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateQuestSort(QuestSortEntity questSort) async {
    var json = questSort.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', questSort.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    QuestSortFilterEntity? filter,
  ) {
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

  Future<bool> _isReferencedByQuest(int id) async {
    final count = await laconic
        .table('quest_template')
        .where('QuestSortID', -id)
        .count();
    return count > 0;
  }
}
