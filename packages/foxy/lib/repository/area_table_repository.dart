import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'area_table_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'AreaName_lang_zhCN')
class AreaTableRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _AreaTableRepositoryMixin {

  @override
  String get dbcLocaleTableName => _table;

  @override
  Future<int> copyAreaTable(int key) async {
    final source = await getAreaTable(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(
      id: await nextMaxPlusOne(_table, 'ID'),
      areaBit: await nextMaxPlusOne(_table, 'AreaBit'),
    );
    await storeAreaTable(copied);
    return copied.id;
  }

  @override
  Future<AreaTableEntity> createAreaTable() async {
    return AreaTableEntity(
      id: await nextMaxPlusOne(_table, 'ID'),
      areaBit: await nextMaxPlusOne(_table, 'AreaBit'),
    );
  }

  Future<bool> isAreaBitAvailable(int areaBit, {int? excludingKey}) async {
    var builder = laconic.table(_table).where('AreaBit', areaBit);
    if (excludingKey != null) {
      builder = builder.where('ID', excludingKey, comparator: '!=');
    }
    final count = await builder.count();
    return count == 0;
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, AreaTableFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'AreaName_lang_zhCN',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
