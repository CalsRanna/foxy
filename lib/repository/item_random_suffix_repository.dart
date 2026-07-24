import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_random_suffix_repository.g.dart';

@FoxyRepository(ItemRandomSuffixEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class ItemRandomSuffixRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _ItemRandomSuffixRepositoryMixin {
  static const _table = 'foxy.dbc_item_random_suffix';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyItemRandomSuffix(int key) async {
    final source = await getItemRandomSuffix(key);
    if (source == null) {
      throw StateError('原随机后缀不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeItemRandomSuffix(copied);
    return copied.id;
  }

  Future<int> countItemRandomSuffixes({ItemRandomSuffixFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemRandomSuffixEntity> createItemRandomSuffix() async {
    return ItemRandomSuffixEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefItemRandomSuffixEntity>> getBriefItemRandomSuffixes({
    int page = 1,
    ItemRandomSuffixFilter? filter,
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemRandomSuffixFilter? filter,
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
