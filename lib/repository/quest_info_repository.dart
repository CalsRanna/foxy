import 'package:foxy/model/quest_info.dart';
import 'package:foxy/model/quest_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_quest_info';

  Future<List<QuestInfo>> getQuestInfos({
    int page = 1,
    QuestInfoFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => QuestInfo.fromJson(e.toMap())).toList();
  }

  Future<int> countQuestInfos({QuestInfoFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestInfo?> getQuestInfo(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return QuestInfo.fromJson(result.toMap());
  }

  Future<void> storeQuestInfo(QuestInfo data) async {
    var json = data.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateQuestInfo(QuestInfo data) async {
    var json = data.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', data.id).update(json);
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

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, QuestInfoFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'InfoName_Lang_zhCN',
        '%${filter.name}%',
        operator: 'like',
      );
    }
    return builder;
  }
}
