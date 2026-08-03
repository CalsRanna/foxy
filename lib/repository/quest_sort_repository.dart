import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
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
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeQuestSort(copied);
    return copied.id;
  }

  @override
  Future<QuestSortEntity> createQuestSort() async {
    return QuestSortEntity(id: await _getNextId());
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, QuestSortFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'SortName_lang_zhCN',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 32768) {
      throw IdExhaustedException(
        'quest sort ID exceeds the QuestSortID referenceable range',
      );
    }
    return id;
  }
}
