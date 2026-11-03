import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/database/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_info_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'InfoName_lang_zhCN')
class QuestInfoRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _QuestInfoRepositoryMixin {
  @override
  String get dbcLocaleTableName => _table;

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, QuestInfoFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'InfoName_lang_zhCN',
        '%${ParseUtil.escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  @override
  Future<int> nextMaxPlusOne(
    String table,
    String column, {
    Map<String, Object?> where = const {},
    int firstValue = 1,
  }) async {
    final id = await super.nextMaxPlusOne(
      table,
      column,
      where: where,
      firstValue: firstValue,
    );
    if (id > 65535) {
      throw IdExhaustedException(
        'quest info ID exceeds the QuestInfoID referenceable range',
      );
    }
    return id;
  }
}
