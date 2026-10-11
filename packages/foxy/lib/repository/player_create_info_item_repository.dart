import 'package:foxy/entity/player_create_info_item_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_item_repository.g.dart';

@FoxyRepository(linkKey: ['race', 'class_'])
class PlayerCreateInfoItemRepository
    with RepositoryMixin, _PlayerCreateInfoItemRepositoryMixin {
  @override
  Future<PlayerCreateInfoItemKey> copyPlayerCreateInfoItem(
    PlayerCreateInfoItemKey key,
  ) async {
    throw CopyNotSupportedException(
      'item ID is part of a composite primary key; add a new record and select a valid item',
    );
  }

  @override
  Future<int> countPlayerCreateInfoItems(int race, int class_) {
    return laconic
        .table(_table)
        .whereRaw('(`race` = 0 OR `race` = ?)', [race])
        .whereRaw('(`class` = 0 OR `class` = ?)', [class_])
        .count();
  }

  @override
  Future<PlayerCreateInfoItemEntity> createPlayerCreateInfoItem(
    int race,
    int class_,
  ) async => PlayerCreateInfoItemEntity(race: race, class_: class_);

  @override
  Future<List<BriefPlayerCreateInfoItemEntity>> getBriefPlayerCreateInfoItems(
    int race,
    int class_, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table as pci');
    builder = builder.select([
      'pci.race',
      'pci.`class`',
      'pci.itemid',
      'pci.amount',
      'pci.Note',
      'it.name as itemName',
      if (localeEnabled) 'itl.Name as itemLocaleName',
      'it.Quality as itemQuality',
      'didi.InventoryIcon0 as itemIcon',
    ]);
    builder = builder.leftJoin(
      'item_template as it',
      (join) => join.on('pci.itemid', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.whereRaw('(`pci`.`race` = 0 OR `pci`.`race` = ?)', [
      race,
    ]);
    builder = builder.whereRaw('(`pci`.`class` = 0 OR `pci`.`class` = ?)', [
      class_,
    ]);
    final results = await builder
        .orderBy('pci.race')
        .orderBy('pci.`class`')
        .orderBy('pci.itemid')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefPlayerCreateInfoItemEntity.fromJson(row.toMap()))
        .toList();
  }
}
