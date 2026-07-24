import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_set_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'ItemSetFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'name',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class ItemSetRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_item_set';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyItemSet(int key) async {
    final source = await getItemSet(key);
    if (source == null) {
      throw StateError('原套装不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeItemSet(copied);
    return copied.id;
  }

  Future<int> countItemSets({ItemSetFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemSetEntity> createItemSet() async {
    return ItemSetEntity(id: await _getNextId());
  }

  Future<void> destroyItemSet(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原套装不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefItemSetEntity>> getBriefItemSets({
    int page = 1,
    ItemSetFilter? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'Name_lang_zhCN',
      'RequiredSkill',
      'RequiredSkillRank',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results.map((e) => BriefItemSetEntity.fromJson(e.toMap())).toList();
  }

  Future<ItemSetEntity?> getItemSet(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemSetEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getItemSetLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<ItemSetEntity>> getItemSets() async {
    final results = await laconic.table(_table).orderBy('ID').get();
    return results.map((e) => ItemSetEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveItemSetLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeItemSet(ItemSetEntity itemSet) async {
    if (itemSet.id <= 0) {
      throw StateError('套装 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([itemSet.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('套装 ${itemSet.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemSet(int originalKey, ItemSetEntity itemSet) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(itemSet.toJson());
      if (matchedRows == 0) {
        throw StateError('原套装不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的套装 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, ItemSetFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7FFFFFFF) throw StateError('ItemSet.dbc 已无可用 int32 ID');
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
