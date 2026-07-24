import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemTemplateLocaleRepository with RepositoryMixin {
  static const _table = 'item_template_locale';
  static const primaryKeyColumns = {'ID', 'locale'};

  Future<void> applyItemTemplateLocaleChanges({
    required List<ItemTemplateLocaleEntity> creations,
    required List<ItemTemplateLocaleKey> deletions,
    required Map<ItemTemplateLocaleKey, ItemTemplateLocaleEntity> updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyItemTemplateLocale(key);
      }
      for (final update in updates.entries) {
        await updateItemTemplateLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeItemTemplateLocale(locale);
      }
    });
  }

  Future<int> countItemTemplateLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<ItemTemplateLocaleEntity> createItemTemplateLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return ItemTemplateLocaleEntity(id: id, locale: locale);
  }

  Future<void> destroyItemTemplateLocale(ItemTemplateLocaleKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原物品本地化记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefItemTemplateLocaleEntity>> getBriefItemTemplateLocales({
    required int id,
    int page = 1,
  }) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'Name'])
        .where('ID', id)
        .orderBy('locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefItemTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<ItemTemplateLocaleEntity?> getItemTemplateLocale(
    ItemTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<List<ItemTemplateLocaleEntity>> getItemTemplateLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => ItemTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeItemTemplateLocale(ItemTemplateLocaleEntity model) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('物品本地化主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemTemplateLocale(
    ItemTemplateLocaleKey originalKey,
    ItemTemplateLocaleEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原物品本地化记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的物品本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, ItemTemplateLocaleKey key) {
    return builder.where('ID', key.id).where('locale', key.locale);
  }
}
