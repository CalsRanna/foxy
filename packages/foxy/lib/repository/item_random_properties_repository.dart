import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_random_properties_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class ItemRandomPropertiesRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _ItemRandomPropertiesRepositoryMixin {

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyItemRandomProperty(int key) async {
    final source = await getItemRandomProperties(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeItemRandomProperties(copied);
    return copied.id;
  }

  Future<int> countItemRandomProperties({
    ItemRandomPropertiesFilter? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemRandomPropertiesEntity> createItemRandomProperty() async {
    return ItemRandomPropertiesEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<ItemRandomPropertiesEntity>> getAllItemRandomProperties() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => ItemRandomPropertiesEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<BriefItemRandomPropertiesEntity>> getBriefItemRandomProperties({
    int page = 1,
    ItemRandomPropertiesFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Name', 'Name_lang_zhCN']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemRandomPropertiesEntity.fromJson(e.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemRandomPropertiesFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
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
