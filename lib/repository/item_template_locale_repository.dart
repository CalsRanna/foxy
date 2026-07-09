import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemTemplateLocaleRepository with RepositoryMixin {
  static const _table = 'item_template_locale';

  Future<List<ItemTemplateLocaleEntity>> getItemTemplateLocales(int id) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results
        .map((e) => ItemTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
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
