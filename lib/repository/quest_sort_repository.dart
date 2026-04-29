import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/entity/quest_sort_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestSortRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_quest_sort';

  Future<List<QuestSortEntity>> getQuestSorts({
    int page = 1,
    QuestSortFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => QuestSortEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countQuestSorts({QuestSortFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestSortEntity?> getQuestSort(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return QuestSortEntity.fromJson(result.toMap());
  }

  Future<void> storeQuestSort(QuestSortEntity data) async {
    var json = data.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateQuestSort(QuestSortEntity data) async {
    var json = data.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', data.id).update(json);
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

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, QuestSortFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'SortName_Lang_zhCN',
        '%${filter.name}%',
        operator: 'like',
      );
    }
    return builder;
  }
}
