import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/entity/item_random_suffix_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemRandomSuffixRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_item_random_suffix';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copyItemRandomSuffix(int id) async {
    var source = await getItemRandomSuffix(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
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

  Future<void> destroyItemRandomSuffix(int id) async {
    await laconic.table(_table).where('ID', id).delete();
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

  Future<ItemRandomSuffixEntity?> getItemRandomSuffix(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
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

  Future<void> saveItemRandomSuffix(ItemRandomSuffixEntity suffix) async {
    if (suffix.id == 0) {
      await storeItemRandomSuffix(suffix);
      return;
    }
    var existing = await getItemRandomSuffix(suffix.id);
    if (existing != null) {
      await updateItemRandomSuffix(suffix);
    } else {
      await laconic.table(_table).insert([suffix.toJson()]);
    }
  }

  Future<void> saveItemRandomSuffixLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeItemRandomSuffix(ItemRandomSuffixEntity suffix) async {
    var json = suffix.toJson();
    final nextId = suffix.id > 0
        ? suffix.id
        : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateItemRandomSuffix(ItemRandomSuffixEntity suffix) async {
    var json = suffix.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', suffix.id).update(json);
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
}
