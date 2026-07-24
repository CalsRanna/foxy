import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_info_repository.g.dart';

@FoxyRepository(QuestInfoEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class QuestInfoRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _QuestInfoRepositoryMixin {
  static const _table = 'foxy.dbc_quest_info';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyQuestInfo(int key) async {
    final source = await getQuestInfo(key);
    if (source == null) {
      throw StateError('原任务信息不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeQuestInfo(copied);
    return copied.id;
  }

  Future<int> countQuestInfos({QuestInfoFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestInfoEntity> createQuestInfo() async {
    return QuestInfoEntity(id: await _getNextId());
  }

  Future<List<BriefQuestInfoEntity>> getBriefQuestInfos({
    int page = 1,
    QuestInfoFilter? filter,
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

  Future<List<DbcLocaleFieldValue>> getQuestInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<QuestInfoEntity>> getQuestInfos() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => QuestInfoEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveQuestInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  QueryBuilder _applyFilter(QueryBuilder builder, QuestInfoFilter? filter) {
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
}
