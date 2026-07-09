import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GossipMenuOptionLocaleRepository with RepositoryMixin {
  static const _table = 'gossip_menu_option_locale';

  Future<List<GossipMenuOptionLocaleEntity>> getGossipMenuOptionLocales(
    int menuId,
  ) async {
    final results = await laconic.table(_table).where('MenuID', menuId).get();
    return results
        .map((e) => GossipMenuOptionLocaleEntity.fromJson(e.toMap()))
        .toList();
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

  Future<void> storeGossipMenuOptionLocale(
    GossipMenuOptionLocaleEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
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
}
