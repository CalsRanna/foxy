import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemTemplateLocaleRepository with RepositoryMixin {
  static const _table = 'item_template_locale';

  Future<List<BriefItemTemplateLocaleEntity>> getBriefItemTemplateLocales({
    int page = 1,
  }) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'Name'])
        .orderBy('ID').limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefItemTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ItemTemplateLocaleEntity>> getItemTemplateLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => ItemTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countItemTemplateLocales() async {
    return laconic.table(_table).count();
  }

  Future<ItemTemplateLocaleEntity?> getItemTemplateLocale(
    int id,
    String locale,
  ) async {
    var results = await laconic
        .table(_table)
        .where('ID', id)
        .where('locale', locale)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return ItemTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<ItemTemplateLocaleEntity> createItemTemplateLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return ItemTemplateLocaleEntity(id: id, locale: locale);
  }

  Future<void> storeItemTemplateLocale(ItemTemplateLocaleEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateItemTemplateLocale(
    int id,
    String locale,
    ItemTemplateLocaleEntity model,
  ) async {
    final json = model.toJson();
    json.remove('ID');
    json.remove('locale');
    await laconic
        .table(_table)
        .where('ID', id)
        .where('locale', locale)
        .update(json);
  }

  Future<void> destroyItemTemplateLocale(int id, String locale) async {
    await laconic
        .table(_table)
        .where('ID', id)
        .where('locale', locale)
        .delete();
  }

  Future<void> copyItemTemplateLocale(int id, String locale) async {
    // Locales are keyed by locale string; shallow copy is a no-op without a new locale.
    final source = await getItemTemplateLocale(id, locale);
    if (source == null) return;
  }

  Future<void> saveItemTemplateLocale(ItemTemplateLocaleEntity model) async {
    final existing = await getItemTemplateLocale(model.id, model.locale);
    if (existing == null) {
      await storeItemTemplateLocale(model);
    } else {
      await updateItemTemplateLocale(model.id, model.locale, model);
    }
  }

  Future<List<ItemTemplateLocaleEntity>> getItemTemplateLocales(int id) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results
        .map((e) => ItemTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveItemTemplateLocales(
    int id,
    List<ItemTemplateLocaleEntity> locales,
  ) async {
    await laconic.transaction(() async {
      await laconic.table(_table).where('ID', id).delete();
      if (locales.isEmpty) return;
      final jsons = locales.map((e) {
        final json = e.toJson();
        json['ID'] = id;
        return json;
      }).toList();
      await laconic.table(_table).insert(jsons);
    });
  }
}