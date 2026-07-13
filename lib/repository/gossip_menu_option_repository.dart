import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GossipMenuOptionRepository with RepositoryMixin {
  static const _table = 'gossip_menu_option';
  static const _localeTable = 'gossip_menu_option_locale';

  Future<List<BriefGossipMenuOptionEntity>> getBriefGossipMenuOptions(
    int menuId,
  ) async {
    final fields = <String>[
      'gmo.MenuID',
      'gmo.OptionID',
      'gmo.OptionIcon',
      'gmo.OptionText',
      'gmo.OptionType',
      'gmo.OptionNpcFlag',
      'gmo.ActionMenuID',
      if (localeEnabled) 'gmol.OptionText AS localeOptionText',
    ];
    var builder = laconic.table('$_table AS gmo');
    builder = builder.select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        '$_localeTable AS gmol',
        (join) => join
            .on('gmo.MenuID', 'gmol.MenuID')
            .on('gmo.OptionID', 'gmol.OptionID')
            .where('gmol.Locale', 'zhCN'),
      );
    }
    builder = builder.where('gmo.MenuID', menuId);
    final results = await builder.get();
    return results
        .map((e) => BriefGossipMenuOptionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GossipMenuOptionEntity>> getGossipMenuOptions() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => GossipMenuOptionEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countGossipMenuOptions(int menuId) async {
    return laconic.table(_table).where('MenuID', menuId).count();
  }

  Future<GossipMenuOptionEntity?> getGossipMenuOption(
    int menuId,
    int optionId,
  ) async {
    var results = await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('OptionID', optionId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return GossipMenuOptionEntity.fromJson(results.first.toMap());
  }

  Future<GossipMenuOptionEntity> createGossipMenuOption(int menuId) async {
    final nextOptionId = await _getNextOptionId(menuId);
    return GossipMenuOptionEntity(menuId: menuId, optionId: nextOptionId);
  }

  Future<void> storeGossipMenuOption(GossipMenuOptionEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateGossipMenuOption(
    int menuId,
    int optionId,
    GossipMenuOptionEntity model,
  ) async {
    final json = model.toJson();
    json.remove('MenuID');
    json.remove('OptionID');
    await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('OptionID', optionId)
        .update(json);
  }

  Future<void> destroyGossipMenuOption(int menuId, int optionId) async {
    await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('OptionID', optionId)
        .delete();
  }

  Future<int?> copyGossipMenuOption(int menuId, int optionId) async {
    final original = await getGossipMenuOption(menuId, optionId);
    if (original == null) return null;
    final next = await createGossipMenuOption(original.menuId);
    final json = original.toJson();
    json['OptionID'] = next.optionId;
    await laconic.table(_table).insert([json]);
    return next.optionId;
  }

  Future<void> saveGossipMenuOption(GossipMenuOptionEntity model) async {
    var existing = await getGossipMenuOption(model.menuId, model.optionId);
    if (existing != null) {
      await updateGossipMenuOption(model.menuId, model.optionId, model);
    } else {
      await storeGossipMenuOption(model);
    }
  }

  Future<int> _getNextOptionId(int menuId) async {
    final rows = await laconic
        .table(_table)
        .select(['OptionID'])
        .where('MenuID', menuId)
        .get();
    final used = rows
        .map((row) => (row.toMap()['OptionID'] as num).toInt())
        .toSet();
    for (var optionId = 0; optionId < 32; optionId++) {
      if (!used.contains(optionId)) return optionId;
    }
    throw StateError('每个对话菜单最多支持 32 个选项');
  }
}
