import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_quest_item_repository.g.dart';

@FoxyRepository(CreatureQuestItemEntity, linkKey: ['creatureEntry'])
class CreatureQuestItemRepository
    with RepositoryMixin, _CreatureQuestItemRepositoryMixin {
  static const _table = 'creature_questitem';
  static const primaryKeyColumns = {'CreatureEntry', 'Idx'};

  @override
  Future<CreatureQuestItemKey> copyCreatureQuestItem(
    CreatureQuestItemKey key,
  ) async {
    final source = await getCreatureQuestItem(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final blank = await createCreatureQuestItem(source.creatureEntry);
    final candidate = source.copyWith(idx: blank.idx);
    await storeCreatureQuestItem(candidate);
    return CreatureQuestItemKey.fromEntity(candidate);
  }

  @override
  Future<int> countCreatureQuestItems(int creatureEntry) {
    return laconic.table(_table).where('CreatureEntry', creatureEntry).count();
  }

  @override
  Future<CreatureQuestItemEntity> createCreatureQuestItem(
    int creatureEntry,
  ) async {
    return CreatureQuestItemEntity(
      creatureEntry: creatureEntry,
      idx: await getNextIdx(creatureEntry),
    );
  }

  @override
  Future<List<BriefCreatureQuestItemEntity>> getBriefCreatureQuestItems(
    int creatureEntry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table as cq');
    final fields = <String>[
      'cq.CreatureEntry',
      'cq.Idx',
      'cq.ItemId',
      'cq.VerifiedBuild',
      'it.name as itemName',
      if (localeEnabled) 'itl.Name as itemLocaleName',
      'it.Quality as itemQuality',
      'didi.InventoryIcon0 as itemIcon',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template as it',
      (join) => join.on('cq.ItemId', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('cq.ItemId', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    final results = await builder
        .where('cq.CreatureEntry', creatureEntry)
        .orderBy('cq.CreatureEntry')
        .orderBy('cq.Idx')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((result) => BriefCreatureQuestItemEntity.fromJson(result.toMap()))
        .toList();
  }

  Future<int> getNextIdx(int creatureEntry) {
    return nextMaxPlusOne(
      _table,
      'Idx',
      where: {'CreatureEntry': creatureEntry},
    );
  }
}
