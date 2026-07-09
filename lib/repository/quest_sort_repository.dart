import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/entity/quest_sort_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestSortRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_quest_sort';

  Future<List<BriefQuestSortEntity>> getBriefQuestSorts({
    int page = 1,
    QuestSortFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'SortName_Lang_zhCN'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefQuestSortEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestSortEntity>> getQuestSorts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => QuestSortEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countQuestSorts({QuestSortFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestSortEntity?> getQuestSort(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestSortEntity.fromJson(results.first.toMap());
  }

  Future<QuestSortEntity> createQuestSort() async {
    return const QuestSortEntity();
  }

  Future<int> storeQuestSort(QuestSortEntity questSort) async {
    var json = questSort.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateQuestSort(QuestSortEntity questSort) async {
    var json = questSort.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', questSort.id).update(json);
  }

  Future<void> destroyQuestSort(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyQuestSort(int id) async {
    var source = await getQuestSort(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
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

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
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
        'SortName_Lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
