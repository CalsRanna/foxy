import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/item_set_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemSetRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_item_set';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefItemSetEntity>> getBriefItemSets({
    int page = 1,
    ItemSetFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Name_lang_zhCN',
      'RequiredSkill',
      'RequiredSkillRank',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefItemSetEntity.fromJson(e.toMap())).toList();
  }

  Future<List<ItemSetEntity>> getItemSets() async {
    var results = await laconic.table(_table).orderBy('ID').get();
    return results.map((e) => ItemSetEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countItemSets({ItemSetFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemSetEntity?> getItemSet(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ItemSetEntity.fromJson(results.first.toMap());
  }

  Future<ItemSetEntity> createItemSet() async {
    return ItemSetEntity(id: await _getNextId());
  }

  Future<int> storeItemSet(ItemSetEntity itemSet) async {
    final stored = itemSet.id > 0
        ? itemSet
        : itemSet.copyWith(id: await _getNextId());
    await _validateReferences(stored, null);
    await laconic.table(_table).insert([stored.toJson()]);
    return stored.id;
  }

  Future<void> updateItemSet(ItemSetEntity itemSet) async {
    final existing = await getItemSet(itemSet.id);
    if (existing == null) throw StateError('套装 ${itemSet.id} 不存在');
    await _validateReferences(itemSet, existing);
    var json = itemSet.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', itemSet.id).update(json);
  }

  Future<void> destroyItemSet(int id) async {
    final references = await laconic
        .table('item_template')
        .where('itemset', id)
        .count();
    if (references > 0) {
      throw StateError('套装 $id 仍被 $references 个物品模板引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemSet(int id) async {
    var source = await getItemSet(id);
    if (source == null) return;
    await storeItemSet(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveItemSet(ItemSetEntity itemSet) async {
    if (itemSet.id == 0 || await getItemSet(itemSet.id) == null) {
      await storeItemSet(itemSet);
      return;
    }
    await updateItemSet(itemSet);
  }

  Future<List<DbcLocaleFieldValue>> getItemSetLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemSetLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7FFFFFFF) throw StateError('ItemSet.dbc 已无可用 int32 ID');
    return id;
  }

  Future<void> _validateReferences(
    ItemSetEntity changed,
    ItemSetEntity? existing,
  ) async {
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId0,
      existingValue: existing?.itemId0,
      field: 'ItemID0',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId1,
      existingValue: existing?.itemId1,
      field: 'ItemID1',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId2,
      existingValue: existing?.itemId2,
      field: 'ItemID2',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId3,
      existingValue: existing?.itemId3,
      field: 'ItemID3',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId4,
      existingValue: existing?.itemId4,
      field: 'ItemID4',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId5,
      existingValue: existing?.itemId5,
      field: 'ItemID5',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId6,
      existingValue: existing?.itemId6,
      field: 'ItemID6',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId7,
      existingValue: existing?.itemId7,
      field: 'ItemID7',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId8,
      existingValue: existing?.itemId8,
      field: 'ItemID8',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId9,
      existingValue: existing?.itemId9,
      field: 'ItemID9',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId10,
      existingValue: existing?.itemId10,
      field: 'ItemID10',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId11,
      existingValue: existing?.itemId11,
      field: 'ItemID11',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId12,
      existingValue: existing?.itemId12,
      field: 'ItemID12',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId13,
      existingValue: existing?.itemId13,
      field: 'ItemID13',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId14,
      existingValue: existing?.itemId14,
      field: 'ItemID14',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId15,
      existingValue: existing?.itemId15,
      field: 'ItemID15',
      target: '物品模板',
    );
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: changed.itemId16,
      existingValue: existing?.itemId16,
      field: 'ItemID16',
      target: '物品模板',
    );
    await _validateReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
      value: changed.setSpellId0,
      existingValue: existing?.setSpellId0,
      field: 'SetSpellID0',
      target: '法术',
    );
    await _validateReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
      value: changed.setSpellId1,
      existingValue: existing?.setSpellId1,
      field: 'SetSpellID1',
      target: '法术',
    );
    await _validateReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
      value: changed.setSpellId2,
      existingValue: existing?.setSpellId2,
      field: 'SetSpellID2',
      target: '法术',
    );
    await _validateReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
      value: changed.setSpellId3,
      existingValue: existing?.setSpellId3,
      field: 'SetSpellID3',
      target: '法术',
    );
    await _validateReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
      value: changed.setSpellId4,
      existingValue: existing?.setSpellId4,
      field: 'SetSpellID4',
      target: '法术',
    );
    await _validateReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
      value: changed.setSpellId5,
      existingValue: existing?.setSpellId5,
      field: 'SetSpellID5',
      target: '法术',
    );
    await _validateReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
      value: changed.setSpellId6,
      existingValue: existing?.setSpellId6,
      field: 'SetSpellID6',
      target: '法术',
    );
    await _validateReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
      value: changed.setSpellId7,
      existingValue: existing?.setSpellId7,
      field: 'SetSpellID7',
      target: '法术',
    );
    await _validateReference(
      table: 'foxy.dbc_skill_line',
      column: 'ID',
      value: changed.requiredSkill,
      existingValue: existing?.requiredSkill,
      field: 'RequiredSkill',
      target: '技能线',
      requireImportedTable: true,
    );
  }

  Future<void> _validateReference({
    required String table,
    required String column,
    required int value,
    required int? existingValue,
    required String field,
    required String target,
    bool requireImportedTable = false,
  }) async {
    if (value == 0 || value == existingValue) return;
    if (requireImportedTable && !await _tableExists(table)) {
      throw StateError('缺少 $table，请重新导入 required DBC 后再修改 $field');
    }
    final references = await laconic.table(table).where(column, value).count();
    if (references == 0) throw StateError('$field 引用的$target $value 不存在');
  }

  Future<bool> _tableExists(String qualifiedTable) async {
    final parts = qualifiedTable.split('.');
    final schema = parts.length == 2 ? parts[0] : 'acore_world';
    final table = parts.length == 2 ? parts[1] : parts[0];
    final rows = await laconic.select(
      '''
SELECT COUNT(*) AS table_count
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?
''',
      [schema, table],
    );
    return (rows.single['table_count'] as num).toInt() > 0;
  }

  QueryBuilder _applyFilter(QueryBuilder builder, ItemSetFilterEntity? filter) {
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
