import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class NpcTextLocaleRepository with RepositoryMixin {
  static const _table = 'npc_text_locale';

  Future<List<NpcTextLocaleEntity>> getNpcTextLocales(int id) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results.map((e) => NpcTextLocaleEntity.fromJson(e.toMap())).toList();
  }

  Future<NpcTextLocaleEntity?> getNpcTextLocale(int id, String locale) async {
    var results = await laconic
        .table(_table)
        .where('ID', id)
        .where('Locale', locale)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return NpcTextLocaleEntity.fromJson(results.first.toMap());
  }

  Future<NpcTextLocaleEntity> createNpcTextLocale(
    int id, {
    String locale = '',
  }) async {
    return NpcTextLocaleEntity(id: id, locale: locale);
  }

  Future<void> storeNpcTextLocale(NpcTextLocaleEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateNpcTextLocale(
    int id,
    String locale,
    NpcTextLocaleEntity model,
  ) async {
    final json = model.toJson();
    json.remove('ID');
    json.remove('Locale');
    await laconic
        .table(_table)
        .where('ID', id)
        .where('Locale', locale)
        .update(json);
  }

  Future<void> destroyNpcTextLocale(int id, String locale) async {
    await laconic
        .table(_table)
        .where('ID', id)
        .where('Locale', locale)
        .delete();
  }

  Future<void> copyNpcTextLocale(int id, String locale) async {
    // Locales are keyed by locale string; shallow copy is a no-op without a new locale.
    final source = await getNpcTextLocale(id, locale);
    if (source == null) return;
  }

  Future<void> saveNpcTextLocale(NpcTextLocaleEntity model) async {
    final existing = await getNpcTextLocale(model.id, model.locale);
    if (existing == null) {
      await storeNpcTextLocale(model);
    } else {
      await updateNpcTextLocale(model.id, model.locale, model);
    }
  }

  Future<void> saveNpcTextLocales(
    int id,
    List<NpcTextLocaleEntity> locales,
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
