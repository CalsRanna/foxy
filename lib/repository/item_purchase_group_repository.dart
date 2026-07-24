import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/item_purchase_group_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_purchase_group_repository.g.dart';

@FoxyRepository(ItemPurchaseGroupEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class ItemPurchaseGroupRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _ItemPurchaseGroupRepositoryMixin {
  static const _table = 'foxy.dbc_item_purchase_group';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyItemPurchaseGroup(int key) async {
    final source = await getItemPurchaseGroup(key);
    if (source == null) {
      throw StateError('原物品购买组不存在，可能已被其他操作修改或删除');
    }
    final candidate = source.copyWith(id: await _getNextId());
    await storeItemPurchaseGroup(candidate);
    return candidate.id;
  }

  Future<int> countItemPurchaseGroups({ItemPurchaseGroupFilter? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<ItemPurchaseGroupEntity> createItemPurchaseGroup() async {
    return ItemPurchaseGroupEntity(id: await _getNextId());
  }

  Future<List<BriefItemPurchaseGroupEntity>> getBriefItemPurchaseGroups({
    int page = 1,
    ItemPurchaseGroupFilter? filter,
  }) async {
    var builder = laconic.table(_table).select(['ID', 'Name_lang_zhCN']);
    builder = _applyFilter(builder, filter);
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefItemPurchaseGroupEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getItemPurchaseGroupLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<ItemPurchaseGroupEntity>> getItemPurchaseGroups() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => ItemPurchaseGroupEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveItemPurchaseGroupLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeItemPurchaseGroup(ItemPurchaseGroupEntity group) async {
    if (group.id <= 0) {
      throw StateError('物品购买组 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([group.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('物品购买组 ${group.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemPurchaseGroupFilter? filter,
  ) {
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
    if (id > 2147483647) {
      throw StateError('物品购买组编号已超出 signed int32 范围');
    }
    return id;
  }
}
