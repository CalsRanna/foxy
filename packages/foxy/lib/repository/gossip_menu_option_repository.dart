import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'gossip_menu_option_repository.g.dart';

@FoxyRepository(GossipMenuOptionEntity, linkKey: ['menuId'])
class GossipMenuOptionRepository
    with RepositoryMixin, _GossipMenuOptionRepositoryMixin {
  static const _table = 'gossip_menu_option';
  static const _localeTable = 'gossip_menu_option_locale';
  static const primaryKeyColumns = {'MenuID', 'OptionID'};

  @override
  Future<GossipMenuOptionKey> copyGossipMenuOption(
    GossipMenuOptionKey key,
  ) async {
    final original = await getGossipMenuOption(key);
    if (original == null) {
      throw RecordNotFoundException('record not found');
    }
    final blank = await createGossipMenuOption(original.menuId);
    final candidate = original.copyWith(optionId: blank.optionId);
    await storeGossipMenuOption(candidate);
    return GossipMenuOptionKey.fromEntity(candidate);
  }

  @override
  Future<int> countGossipMenuOptions(int menuId) {
    return laconic.table(_table).where('MenuID', menuId).count();
  }

  @override
  Future<GossipMenuOptionEntity> createGossipMenuOption(int menuId) async {
    final nextOptionId = await _getNextOptionId(menuId);
    return GossipMenuOptionEntity(menuId: menuId, optionId: nextOptionId);
  }

  @override
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
      if (localeEnabled) 'gmol.OptionText as localeOptionText',
    ];
    var builder = laconic.table('$_table as gmo').select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        '$_localeTable as gmol',
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
    throw ValidationException('a gossip menu supports at most 32 options');
  }
}
