import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_random_properties_repository.g.dart';

@FoxyRepository(ItemRandomPropertiesEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class ItemRandomPropertiesRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _ItemRandomPropertiesRepositoryMixin {
  static const _table = 'foxy.dbc_item_random_properties';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyItemRandomProperty(int key) async {
    final source = await getItemRandomProperties(key);
    if (source == null) {
      throw StateError('原随机属性不存在，可能已被其他操作修改或删除');
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

  Future<List<DbcLocaleFieldValue>> getItemRandomPropertiesLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<ItemRandomPropertiesEntity>> getAllItemRandomProperties() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => ItemRandomPropertiesEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveItemRandomPropertiesLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemRandomPropertiesFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
