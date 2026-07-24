import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'gossip_menu_option_repository.g.dart';

@FoxyRepository(GossipMenuOptionEntity)
class GossipMenuOptionRepository
    with RepositoryMixin, _GossipMenuOptionRepositoryMixin {
  static const _table = 'gossip_menu_option';
  static const _localeTable = 'gossip_menu_option_locale';
  static const primaryKeyColumns = {'MenuID', 'OptionID'};

  Future<GossipMenuOptionKey> copyGossipMenuOption(
    GossipMenuOptionKey sourceKey,
  ) async {
    final original = await getGossipMenuOption(sourceKey);
    if (original == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createGossipMenuOption(original.menuId);
    final candidate = original.copyWith(optionId: blank.optionId);
    await storeGossipMenuOption(candidate);
    return GossipMenuOptionKey.fromEntity(candidate);
  }

  Future<int> countGossipMenuOptions(int menuId) {
    return laconic.table(_table).where('MenuID', menuId).count();
  }

  Future<GossipMenuOptionEntity> createGossipMenuOption(int menuId) async {
    final nextOptionId = await _getNextOptionId(menuId);
    return GossipMenuOptionEntity(menuId: menuId, optionId: nextOptionId);
  }

  Future<List<BriefGossipMenuOptionEntity>> getBriefGossipMenuOptions(
    int menuId, {
    int page = 1,
  }) async {
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
    var builder = laconic.table('$_table AS gmo').select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        '$_localeTable AS gmol',
        (join) => join
            .on('gmo.MenuID', 'gmol.MenuID')
            .on('gmo.OptionID', 'gmol.OptionID')
            .where('gmol.Locale', 'zhCN'),
      );
    }
    final results = await builder
        .where('gmo.MenuID', menuId)
        .orderBy('gmo.MenuID')
        .orderBy('gmo.OptionID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((result) => BriefGossipMenuOptionEntity.fromJson(result.toMap()))
        .toList();
  }

  Future<List<GossipMenuOptionEntity>> getGossipMenuOptions() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => GossipMenuOptionEntity.fromJson(row.toMap()))
        .toList();
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
