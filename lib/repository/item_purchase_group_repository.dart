import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_purchase_group_entity.dart';
import 'package:foxy/entity/item_purchase_group_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemPurchaseGroupRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_item_purchase_group';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefItemPurchaseGroupEntity>> getBriefItemPurchaseGroups({
    int page = 1,
    ItemPurchaseGroupFilterEntity? filter,
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

  Future<List<ItemPurchaseGroupEntity>> getItemPurchaseGroups() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => ItemPurchaseGroupEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countItemPurchaseGroups({ItemPurchaseGroupFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<ItemPurchaseGroupEntity?> getItemPurchaseGroup(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : ItemPurchaseGroupEntity.fromJson(rows.first.toMap());
  }

  Future<ItemPurchaseGroupEntity> createItemPurchaseGroup() async {
    return ItemPurchaseGroupEntity(id: await _getNextId());
  }

  Future<int> storeItemPurchaseGroup(ItemPurchaseGroupEntity group) async {
    final id = group.id > 0 ? group.id : await _getNextId();
    final candidate = group.copyWith(id: id);
    await laconic.table(_table).insert([candidate.toJson()]);
    return id;
  }

  Future<void> updateItemPurchaseGroup(ItemPurchaseGroupEntity group) async {
    final json = group.toJson()..remove('ID');
    await laconic.table(_table).where('ID', group.id).update(json);
  }

  Future<void> destroyItemPurchaseGroup(int id) async {
    final referenceCount = await laconic
        .table('foxy.dbc_item_extended_cost')
        .where('ItemPurchaseGroup', id)
        .count();
    if (referenceCount > 0) {
      throw StateError('物品购买组 $id 仍被扩展价格引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemPurchaseGroup(int id) async {
    final source = await getItemPurchaseGroup(id);
    if (source == null) return;
    final candidate = source.copyWith(id: await _getNextId());
    await laconic.table(_table).insert([candidate.toJson()]);
  }

  Future<void> saveItemPurchaseGroup(ItemPurchaseGroupEntity group) async {
    if (group.id == 0) {
      await storeItemPurchaseGroup(group);
      return;
    }
    if (await getItemPurchaseGroup(group.id) == null) {
      await storeItemPurchaseGroup(group);
    } else {
      await updateItemPurchaseGroup(group);
    }
  }

  Future<List<DbcLocaleFieldValue>> getItemPurchaseGroupLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemPurchaseGroupLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 2147483647) {
      throw StateError('物品购买组编号已超出 signed int32 范围');
    }
    return id;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemPurchaseGroupFilterEntity? filter,
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
}
