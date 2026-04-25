import 'package:foxy/model/gossip_menu_option.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// gossip_menu_option 表的数据访问层
/// 复合主键: (MenuID, OptionID)
class GossipMenuOptionRepository with RepositoryMixin {
  static const _table = 'gossip_menu_option';
  static const _localeTable = 'gossip_menu_option_locale';

  /// 按 MenuID 搜索该菜单下的所有选项（带 locale JOIN）
  Future<List<GossipMenuOption>> search({required int menuId}) async {
    try {
      const fields = [
        'gmo.MenuID',
        'gmo.OptionID',
        'gmo.OptionIcon',
        'gmo.OptionText',
        'gmo.OptionBroadcastTextID',
        'gmo.OptionType',
        'gmo.OptionNpcFlag',
        'gmo.BoxCoded',
        'gmo.BoxMoney',
        'gmo.BoxText',
        'gmo.BoxBroadcastTextID',
        'gmo.ActionMenuID',
        'gmo.ActionPoiID',
        'gmo.VerifiedBuild',
        'gmol.OptionText AS localeOptionText',
      ];
      var builder = laconic.table('$_table AS gmo');
      builder = builder.select(fields);
      builder = builder.leftJoin(
        '$_localeTable AS gmol',
        (join) => join
            .on('gmo.MenuID', 'gmol.MenuID')
            .on('gmo.OptionID', 'gmol.OptionID')
            .on('gmol.Locale', '"zhCN"'),
      );
      builder = builder.where('gmo.MenuID', menuId);
      final results = await builder.get();
      return results
          .map((e) => GossipMenuOption.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 按复合键查找
  Future<GossipMenuOption?> find(Map<String, dynamic> id) async {
    try {
      var builder = laconic.table(_table);
      id.forEach((k, v) {
        builder = builder.where(k, v);
      });
      final result = await builder.first();
      return GossipMenuOption.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 取指定 MenuID 下的下一个 OptionID
  Future<GossipMenuOption> create({required int menuId}) async {
    try {
      final result = await laconic
          .table(_table)
          .where('MenuID', menuId)
          .select(['MAX(OptionID) as max_id'])
          .first();
      final maxId = result.toMap()['max_id'] as int?;
      final model = GossipMenuOption();
      model.menuId = menuId;
      model.optionId = maxId == null ? 0 : maxId + 1;
      return model;
    } catch (e) {
      final model = GossipMenuOption();
      model.menuId = menuId;
      model.optionId = 0;
      return model;
    }
  }

  Future<void> update(
    Map<String, dynamic> id,
    GossipMenuOption model,
  ) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    final json = model.toJson();
    for (final k in id.keys) {
      json.remove(k);
    }
    await builder.update(json);
  }

  Future<void> store(GossipMenuOption model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> destroy(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }

  Future<void> copy(Map<String, dynamic> id) async {
    final original = await find(id);
    if (original == null) return;
    final next = await create(menuId: original.menuId);
    original.optionId = next.optionId;
    await store(original);
  }
}
