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
    final results = await laconic
        .table(_table)
        .select(['race', 'class', 'itemid', 'amount', 'Note'])
        .whereRaw('(`race` = 0 OR `race` = ?)', [race])
        .whereRaw('(`class` = 0 OR `class` = ?)', [class_])
        .orderBy('race')
        .orderBy('`class`')
        .orderBy('itemid')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefPlayerCreateInfoItemEntity.fromJson(row.toMap()))
        .toList();
  }
}
