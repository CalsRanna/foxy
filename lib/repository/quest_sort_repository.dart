import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_sort_repository.g.dart';

@FoxyRepository(QuestSortEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'SortName_lang_zhCN')
class QuestSortRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _QuestSortRepositoryMixin {
  static const _table = 'foxy.dbc_quest_sort';

  @override
  String get dbcLocaleTableName => _table;

  @override
  Future<int> copyQuestSort(int key) async {
    final source = await getQuestSort(key);
    if (source == null) {
      throw StateError('原任务排序不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeQuestSort(copied);
    return copied.id;
  }

  @override
  Future<QuestSortEntity> createQuestSort() async {
    return QuestSortEntity(id: await _getNextId());
  }

  Future<List<DbcLocaleFieldValue>> getQuestSortLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveQuestSortLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  @override
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
}
