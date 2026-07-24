import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureTemplateAddonRepository with RepositoryMixin {
  static const _table = 'creature_template_addon';

  Future<int> copyCreatureTemplateAddon(int key) async {
    final source = await getCreatureTemplateAddon(key);
    if (source == null) {
      throw StateError('原生物模板附加数据不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(
      entry: await nextMaxPlusOne(_table, 'entry'),
    );
    await storeCreatureTemplateAddon(copied);
    return copied.entry;
  }

  Future<int> countCreatureTemplateAddons() {
    return laconic.table(_table).count();
  }

  Future<CreatureTemplateAddonEntity> createCreatureTemplateAddon([
    int? entry,
  ]) async {
    return CreatureTemplateAddonEntity(
      entry: entry ?? await nextMaxPlusOne(_table, 'entry'),
    );
  }

  Future<void> destroyCreatureTemplateAddon(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原生物模板附加数据不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureTemplateAddonEntity>>
  getBriefCreatureTemplateAddons({int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['entry', 'path_id', 'mount', 'emote', 'auras'])
        .orderBy('entry')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefCreatureTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<CreatureTemplateAddonEntity?> getCreatureTemplateAddon(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<List<CreatureTemplateAddonEntity>> getCreatureTemplateAddons() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => CreatureTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeCreatureTemplateAddon(
    CreatureTemplateAddonEntity addon,
  ) async {
    if (addon.entry <= 0) {
      throw StateError('生物模板附加数据 entry 必须显式指定');
    }
    try {
      await laconic.table(_table).insert([addon.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物模板附加数据 ${addon.entry} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplateAddon(
    int originalKey,
    CreatureTemplateAddonEntity addon,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(addon.toJson());
      if (matchedRows == 0) {
        throw StateError('原生物模板附加数据不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物模板附加数据 entry 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('entry', key);
  }
}
