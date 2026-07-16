import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_info_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestInfoRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_quest_info';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copyQuestInfo(int id) async {
    var source = await getQuestInfo(id);
    if (source == null) return;
    final nextId = await _getNextId();
    final candidate = source.copyWith(id: nextId);
    var json = candidate.toJson();
    await laconic.table(_table).insert([json]);
  }

  Future<int> countQuestInfos({QuestInfoFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestInfoEntity> createQuestInfo() async {
    return QuestInfoEntity(id: await _getNextId());
  }

  Future<void> destroyQuestInfo(int id) async {
    if (await _isReferencedByQuest(id)) {
      throw StateError('任务信息 $id 仍被任务模板引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

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

  Future<QuestInfoEntity?> getQuestInfo(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestInfoEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getQuestInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<QuestInfoEntity>> getQuestInfos() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => QuestInfoEntity.fromJson(e.toMap())).toList();
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

  Future<void> saveQuestInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeQuestInfo(QuestInfoEntity questInfo) async {
    final id = questInfo.id > 0 ? questInfo.id : await _getNextId();
    final candidate = questInfo.copyWith(id: id);
    var json = candidate.toJson();
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateQuestInfo(QuestInfoEntity questInfo) async {
    var json = questInfo.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', questInfo.id).update(json);
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

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 65535) {
      throw StateError('任务信息编号已超出 QuestInfoID 可引用范围');
    }
    return id;
  }

  Future<bool> _isReferencedByQuest(int id) async {
    final count = await laconic
        .table('quest_template')
        .where('QuestInfoID', id)
        .count();
    return count > 0;
  }
}
