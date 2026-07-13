import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GossipMenuOptionLocaleRepository with RepositoryMixin {
  static const _table = 'gossip_menu_option_locale';

  Future<List<BriefGossipMenuOptionLocaleEntity>>
  getBriefGossipMenuOptionLocales({int page = 1}) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['MenuID', 'OptionID', 'Locale', 'OptionText'])
        .orderBy('MenuID')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefGossipMenuOptionLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GossipMenuOptionLocaleEntity>>
  getGossipMenuOptionLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => GossipMenuOptionLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countGossipMenuOptionLocales() async {
    return laconic.table(_table).count();
  }

  Future<GossipMenuOptionLocaleEntity?> getGossipMenuOptionLocale(
    int menuId,
    int optionId,
    String locale,
  ) async {
    var results = await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('OptionID', optionId)
        .where('Locale', locale)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return GossipMenuOptionLocaleEntity.fromJson(results.first.toMap());
  }

  Future<GossipMenuOptionLocaleEntity> createGossipMenuOptionLocale({
    int menuId = 0,
    int optionId = 0,
    String locale = 'zhCN',
  }) async {
    return GossipMenuOptionLocaleEntity(
      menuId: menuId,
      optionId: optionId,
      locale: locale,
    );
  }

  Future<void> storeGossipMenuOptionLocale(
    GossipMenuOptionLocaleEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateGossipMenuOptionLocale(
    int menuId,
    int optionId,
    String locale,
    GossipMenuOptionLocaleEntity model,
  ) async {
    final json = model.toJson();
    json.remove('MenuID');
    json.remove('OptionID');
    json.remove('Locale');
    await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('OptionID', optionId)
        .where('Locale', locale)
        .update(json);
  }

  Future<void> destroyGossipMenuOptionLocale(
    int menuId,
    int optionId,
    String locale,
  ) async {
    await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('OptionID', optionId)
        .where('Locale', locale)
        .delete();
  }

  Future<void> copyGossipMenuOptionLocale(
    int menuId,
    int optionId,
    String locale,
  ) async {
    // Locales are keyed by locale string; shallow copy is a no-op without a new locale.
    final source = await getGossipMenuOptionLocale(menuId, optionId, locale);
    if (source == null) return;
  }

  Future<void> saveGossipMenuOptionLocale(
    GossipMenuOptionLocaleEntity model,
  ) async {
    final existing = await getGossipMenuOptionLocale(
      model.menuId,
      model.optionId,
      model.locale,
    );
    if (existing == null) {
      await storeGossipMenuOptionLocale(model);
    } else {
      await updateGossipMenuOptionLocale(
        model.menuId,
        model.optionId,
        model.locale,
        model,
      );
    }
  }

  Future<List<GossipMenuOptionLocaleEntity>> getGossipMenuOptionLocales(
    int menuId,
  ) async {
    final results = await laconic.table(_table).where('MenuID', menuId).get();
    return results
        .map((e) => GossipMenuOptionLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveGossipMenuOptionLocales(
    int menuId,
    int optionId,
    List<GossipMenuOptionLocaleEntity> locales,
  ) async {
    await laconic.transaction(() async {
      await laconic
          .table(_table)
          .where('MenuID', menuId)
          .where('OptionID', optionId)
          .delete();
      if (locales.isEmpty) return;
      final jsons = locales.map((e) {
        final json = e.toJson();
        json['MenuID'] = menuId;
        json['OptionID'] = optionId;
        return json;
      }).toList();
      await laconic.table(_table).insert(jsons);
    });
  }

  Future<void> destroyGossipMenuOptionLocales(int menuId, int optionId) async {
    await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('OptionID', optionId)
        .delete();
  }

  Future<void> copyGossipMenuOptionLocales(
    int menuId,
    int sourceOptionId,
    int targetOptionId,
  ) async {
    final results = await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('OptionID', sourceOptionId)
        .get();
    if (results.isEmpty) return;
    final jsons = results.map((row) {
      final json = row.toMap();
      json['OptionID'] = targetOptionId;
      return json;
    }).toList();
    await laconic.table(_table).insert(jsons);
  }
}
