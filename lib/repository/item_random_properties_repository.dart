import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/entity/item_random_properties_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemRandomPropertiesRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_item_random_properties';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefItemRandomPropertiesEntity>> getBriefItemRandomProperties({
    int page = 1,
    ItemRandomPropertiesFilterEntity? filter,
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

  Future<List<ItemRandomPropertiesEntity>> getItemRandomProperties() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemRandomPropertiesEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countItemRandomProperties({
    ItemRandomPropertiesFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemRandomPropertiesEntity?> getItemRandomProperty(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ItemRandomPropertiesEntity.fromJson(results.first.toMap());
  }

  Future<ItemRandomPropertiesEntity> createItemRandomProperty() async {
    return const ItemRandomPropertiesEntity();
  }

  Future<int> storeItemRandomProperty(
    ItemRandomPropertiesEntity property,
  ) async {
    var json = property.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateItemRandomProperty(
    ItemRandomPropertiesEntity property,
  ) async {
    var json = property.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', property.id).update(json);
  }

  Future<void> destroyItemRandomProperty(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemRandomProperty(int id) async {
    var source = await getItemRandomProperty(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveItemRandomProperty(
    ItemRandomPropertiesEntity property,
  ) async {
    if (property.id == 0) {
      await storeItemRandomProperty(property);
      return;
    }
    var existing = await getItemRandomProperty(property.id);
    if (existing != null) {
      await updateItemRandomProperty(property);
    } else {
      await laconic.table(_table).insert([property.toJson()]);
    }
  }

  Future<List<DbcLocaleFieldValue>> getItemRandomPropertiesLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemRandomPropertiesLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);
  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemRandomPropertiesFilterEntity? filter,
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
