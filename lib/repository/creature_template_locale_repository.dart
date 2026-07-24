import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureTemplateLocaleRepository with RepositoryMixin {
  static const _table = 'creature_template_locale';
  static const primaryKeyColumns = {'entry', 'locale'};

  Future<void> applyCreatureTemplateLocaleChanges({
    required List<CreatureTemplateLocaleEntity> creations,
    required List<CreatureTemplateLocaleKey> deletions,
    required Map<CreatureTemplateLocaleKey, CreatureTemplateLocaleEntity>
    updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyCreatureTemplateLocale(key);
      }
      for (final update in updates.entries) {
        await updateCreatureTemplateLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeCreatureTemplateLocale(locale);
      }
    });
  }

  Future<int> countCreatureTemplateLocales({required int entry}) {
    return laconic.table(_table).where('entry', entry).count();
  }

  Future<CreatureTemplateLocaleEntity> createCreatureTemplateLocale({
    required int entry,
    String locale = 'zhCN',
  }) async {
    return CreatureTemplateLocaleEntity(entry: entry, locale: locale);
  }

  Future<void> destroyCreatureTemplateLocale(
    CreatureTemplateLocaleKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原生物模板本地化记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureTemplateLocaleEntity>>
  getBriefCreatureTemplateLocales({required int entry, int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['entry', 'locale', 'Name', 'Title'])
        .where('entry', entry)
        .orderBy('locale')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefCreatureTemplateLocaleEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<CreatureTemplateLocaleEntity?> getCreatureTemplateLocale(
    CreatureTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureTemplateLocale(
    CreatureTemplateLocaleEntity locale,
  ) async {
    try {
      await laconic.table(_table).insert([locale.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物模板本地化主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplateLocale(
    CreatureTemplateLocaleKey originalKey,
    CreatureTemplateLocaleEntity locale,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(locale.toJson());
      if (matchedRows == 0) {
        throw StateError('原生物模板本地化记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物模板本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, CreatureTemplateLocaleKey key) {
    return builder.where('entry', key.entry).where('locale', key.locale);
  }
}
