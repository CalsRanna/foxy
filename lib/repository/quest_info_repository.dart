import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_info_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestInfoRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_quest_info';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefQuestInfoEntity>> getBriefQuestInfos({
    int page = 1,
    QuestInfoFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'InfoName_lang_zhCN'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
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
    return QuestInfoEntity(id: await _getNextId());
  }

  Future<int> storeQuestInfo(QuestInfoEntity questInfo) async {
    var json = questInfo.toJson();
    final nextId = questInfo.id > 0 ? questInfo.id : await _getNextId();
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

  Future<List<DbcLocaleFieldValue>> getQuestInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveQuestInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);
  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
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
        'InfoName_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
