import 'package:foxy/entity/brief_item_random_suffix_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/entity/item_random_suffix_filter_entity.dart';
import 'package:foxy/entity/item_random_suffix_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemRandomSuffixRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_item_random_suffix';

  @override
  String get dbcLocaleTableName => _table;

  Future<ItemRandomSuffixKey> copyItemRandomSuffix(
    ItemRandomSuffixKey key,
  ) async {
    final source = await getItemRandomSuffix(key);
    if (source == null) {
      throw StateError('原随机后缀不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeItemRandomSuffix(copied);
    return ItemRandomSuffixKey.fromEntity(copied);
  }

  Future<int> countItemRandomSuffixes({
    ItemRandomSuffixFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemRandomSuffixEntity> createItemRandomSuffix() async {
    return ItemRandomSuffixEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyItemRandomSuffix(ItemRandomSuffixKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原随机后缀不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefItemRandomSuffixEntity>> getBriefItemRandomSuffixes({
    int page = 1,
    ItemRandomSuffixFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Name_lang_zhCN', 'InternalName']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemRandomSuffixEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<ItemRandomSuffixEntity?> getItemRandomSuffix(
    ItemRandomSuffixKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemRandomSuffixEntity.fromJson(results.first.toMap());
  }

  Future<List<ItemRandomSuffixEntity>> getItemRandomSuffixes() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemRandomSuffixEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getItemRandomSuffixLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemRandomSuffixLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeItemRandomSuffix(ItemRandomSuffixEntity suffix) async {
    if (suffix.id <= 0) {
      throw StateError('随机后缀 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([suffix.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('随机后缀 ${suffix.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemRandomSuffix(
    ItemRandomSuffixKey originalKey,
    ItemRandomSuffixEntity suffix,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(suffix.toJson());
      if (matchedRows == 0) {
        throw StateError('原随机后缀不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的随机后缀 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemRandomSuffixFilterEntity? filter,
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

  QueryBuilder _whereKey(QueryBuilder builder, ItemRandomSuffixKey key) {
    return builder.where('ID', key.id);
  }
}
