import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'char_title_repository.g.dart';

@FoxyRepository(CharTitleEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class CharTitleRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _CharTitleRepositoryMixin {
  static const _table = 'foxy.dbc_char_titles';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyCharTitle(int key) async {
    final source = await getCharTitle(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = CharTitleEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeCharTitle(copied);
    return copied.id;
  }

  Future<int> countCharTitles({CharTitleFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CharTitleEntity> createCharTitle() async {
    return CharTitleEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefCharTitleEntity>> getBriefCharTitles({
    int page = 1,
    CharTitleFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Name_lang_zhCN']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCharTitleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CharTitleEntity>> getCharTitles() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => CharTitleEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, CharTitleFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
