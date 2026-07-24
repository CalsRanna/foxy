import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureQuestItemRepository with RepositoryMixin {
  static const _table = 'creature_questitem';
  static const primaryKeyColumns = {'CreatureEntry', 'Idx'};

  Future<CreatureQuestItemKey> copyCreatureQuestItem(
    CreatureQuestItemKey sourceKey,
  ) async {
    final source = await getCreatureQuestItem(sourceKey);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureQuestItem(source.creatureEntry);
    final candidate = source.copyWith(idx: blank.idx);
    await storeCreatureQuestItem(candidate);
    return CreatureQuestItemKey.fromEntity(candidate);
  }

  Future<int> countCreatureQuestItems(int creatureEntry) {
    return laconic.table(_table).where('CreatureEntry', creatureEntry).count();
  }

  Future<CreatureQuestItemEntity> createCreatureQuestItem(
    int creatureEntry,
  ) async {
    return CreatureQuestItemEntity(
      creatureEntry: creatureEntry,
      idx: await getNextIdx(creatureEntry),
    );
  }

  Future<void> destroyCreatureQuestItem(CreatureQuestItemKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureQuestItemEntity>> getBriefCreatureQuestItems(
    int creatureEntry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS cq');
    final fields = <String>[
      'cq.CreatureEntry',
      'cq.Idx',
      'cq.ItemId',
      'cq.VerifiedBuild',
      'it.name AS itemName',
      if (localeEnabled) 'itl.Name AS itemLocaleName',
      'it.Quality AS itemQuality',
      'didi.InventoryIcon0 AS itemIcon',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('cq.ItemId', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('cq.ItemId', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
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

  Future<CreatureQuestItemEntity?> getCreatureQuestItem(
    CreatureQuestItemKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureQuestItemEntity.fromJson(results.first.toMap());
  }

  Future<int> getNextIdx(int creatureEntry) {
    return nextMaxPlusOne(
      _table,
      'Idx',
      where: {'CreatureEntry': creatureEntry},
    );
  }

  Future<void> storeCreatureQuestItem(CreatureQuestItemEntity questItem) async {
    try {
      await laconic.table(_table).insert([questItem.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物任务物品主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureQuestItem(
    CreatureQuestItemKey originalKey,
    CreatureQuestItemEntity questItem,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(questItem.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物任务物品主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestItemKey key) {
    return builder
        .where('CreatureEntry', key.creatureEntry)
        .where('Idx', key.idx);
  }
}
