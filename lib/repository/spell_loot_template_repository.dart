import 'package:foxy/entity/brief_spell_loot_template_entity.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/entity/spell_loot_template_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellLootTemplateRepository with RepositoryMixin {
  static const _table = 'spell_loot_template';
  static const primaryKeyColumns = {'Entry', 'Item'};

  Future<void> copySpellLootTemplate(SpellLootTemplateKey key) async {
    throw UnsupportedError('法术掉落记录不能自动复制，请新增记录并选择有效物品或引用模板。');
  }

  Future<int> countSpellLootTemplates(int entry) {
    return laconic.table(_table).where('Entry', entry).count();
  }

  Future<SpellLootTemplateEntity> createSpellLootTemplate(int entry) async {
    return SpellLootTemplateEntity(entry: entry);
  }

  Future<void> destroySpellLootTemplate(SpellLootTemplateKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellLootTemplateEntity>> getBriefSpellLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS slt');
    final fields = <String>[
      'slt.Entry',
      'slt.Item',
      'slt.Reference',
      'slt.Chance',
      'slt.QuestRequired',
      'slt.LootMode',
      'slt.GroupId',
      'slt.MinCount',
      'slt.MaxCount',
      'slt.Comment',
      'it.name',
      if (localeEnabled) 'itl.Name as localeName',
      'it.Quality',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('slt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('slt.Entry', entry);
    builder = builder.orderBy('slt.Item');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SpellLootTemplateEntity?> getSpellLootTemplate(
    SpellLootTemplateKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellLootTemplate(SpellLootTemplateEntity data) async {
    try {
      await laconic.table(_table).insert([data.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术掉落模板主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpellLootTemplate(
    SpellLootTemplateKey originalKey,
    SpellLootTemplateEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(data.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术掉落模板主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellLootTemplateKey key) {
    return builder.where('Entry', key.entry).where('Item', key.item);
  }
}
