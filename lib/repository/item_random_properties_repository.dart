import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
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
    final source = await getItemRandomProperty(key);
    if (source == null) {
      throw StateError('原随机属性不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeItemRandomProperty(copied);
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

  Future<void> destroyItemRandomProperty(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原随机属性不存在，可能已被其他操作修改或删除');
    }
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

  Future<List<ItemRandomPropertiesEntity>> getItemRandomProperties() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemRandomPropertiesEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getItemRandomPropertiesLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<ItemRandomPropertiesEntity?> getItemRandomProperty(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemRandomPropertiesEntity.fromJson(results.first.toMap());
  }

  Future<void> saveItemRandomPropertiesLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeItemRandomProperty(
    ItemRandomPropertiesEntity property,
  ) async {
    if (property.id <= 0) {
      throw StateError('随机属性 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([property.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('随机属性 ${property.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemRandomProperty(
    int originalKey,
    ItemRandomPropertiesEntity property,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(property.toJson());
      if (matchedRows == 0) {
        throw StateError('原随机属性不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的随机属性 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

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
