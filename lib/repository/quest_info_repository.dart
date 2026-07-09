import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_quest_info';

  Future<List<BriefQuestInfoEntity>> getBriefQuestInfos({
    int page = 1,
    QuestInfoFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'InfoName_Lang_zhCN'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefQuestInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestInfoEntity>> getQuestInfos() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => QuestInfoEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countQuestInfos({QuestInfoFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestInfoEntity?> getQuestInfo(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestInfoEntity.fromJson(results.first.toMap());
  }

  Future<QuestInfoEntity> createQuestInfo() async {
    return const QuestInfoEntity();
  }

  Future<int> storeQuestInfo(QuestInfoEntity questInfo) async {
    var json = questInfo.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateQuestInfo(QuestInfoEntity questInfo) async {
    var json = questInfo.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', questInfo.id).update(json);
  }

  Future<void> destroyQuestInfo(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyQuestInfo(int id) async {
    var source = await getQuestInfo(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveQuestInfo(QuestInfoEntity questInfo) async {
    if (questInfo.id == 0) {
      await storeQuestInfo(questInfo);
      return;
    }
    var existing = await getQuestInfo(questInfo.id);
    if (existing != null) {
      await updateQuestInfo(questInfo);
    } else {
      await laconic.table(_table).insert([questInfo.toJson()]);
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
    QuestInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'InfoName_Lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
