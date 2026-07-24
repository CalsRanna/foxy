import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/game_object_loot_template_entity.dart';
import 'package:foxy/entity/brief_game_object_loot_template_entry_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_loot_template_repository.g.dart';

@FoxyRepository(GameObjectLootTemplateEntity)
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class GameObjectLootTemplateRepository
    with RepositoryMixin, _GameObjectLootTemplateRepositoryMixin {
  static const _table = 'gameobject_loot_template';
  static const primaryKeyColumns = {'Entry', 'Item'};

  Future<void> copyLootTemplate(GameObjectLootTemplateKey key) async {
    final source = await getLootTemplate(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(item: await getNextItemId(source.entry));
    await storeLootTemplate(copied);
  }

  Future<int> countLootTemplateRows({
    GameObjectLootTemplateFilter? filter,
  }) async {
    final needsNameJoin = filter != null && filter.name.isNotEmpty;
    if (!needsNameJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.entry.isNotEmpty) {
        builder = builder.where('Entry', filter.entry);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS lt');
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('lt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = _applyRowFilter(builder, filter);
    return builder.count();
  }

  Future<int> countLootTemplates({GameObjectLootTemplateFilter? filter}) async {
    var builder = laconic.table(_table);
    if (filter != null && filter.entry.isNotEmpty) {
      builder = builder.where('Entry', filter.entry);
    }
    builder = builder.groupBy('Entry');
    return builder.count();
  }

  Future<int> countLootTemplatesForEntry(int entry) {
    return laconic.table(_table).where('Entry', entry).count();
  }

  Future<GameObjectLootTemplateEntity> createLootTemplate(int entry) async {
    return GameObjectLootTemplateEntity(entry: entry);
  }

  Future<void> destroyLootTemplate(GameObjectLootTemplateKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGameObjectLootTemplateEntryEntity>>
  getBriefLootTemplateEntries({
    GameObjectLootTemplateFilter? filter,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['Entry', 'COUNT(*) as ItemCount']);
    if (filter != null && filter.entry.isNotEmpty) {
      builder = builder.where('Entry', filter.entry);
    }
    builder = builder.groupBy('Entry');
    builder = builder.orderBy('Entry');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGameObjectLootTemplateEntryEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<BriefGameObjectLootTemplateEntity>> getBriefLootTemplateRows({
    GameObjectLootTemplateFilter? filter,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS lt');
    final fields = <String>[
      ..._briefFields('lt'),
      'it.name AS itemName',
      if (localeEnabled) 'itl.Name AS itemLocaleName',
      'it.Quality AS itemQuality',
      'didi.InventoryIcon0 AS itemIcon',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('lt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = _applyRowFilter(builder, filter);
    builder = builder.orderBy('lt.Entry').orderBy('lt.Item');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGameObjectLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<BriefGameObjectLootTemplateEntity>> getBriefLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS lt');
    final fields = <String>[
      ..._briefFields('lt'),
      'it.name AS itemName',
      if (localeEnabled) 'itl.Name AS itemLocaleName',
      'it.Quality AS itemQuality',
      'didi.InventoryIcon0 AS itemIcon',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('lt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('lt.Entry', entry);
    builder = builder.orderBy('lt.Item');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    var results = await builder.get();
    return results
        .map((e) => BriefGameObjectLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectLootTemplateEntity?> getLootTemplate(
    GameObjectLootTemplateKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<int> getNextItemId(int entry) =>
      nextMaxPlusOne(_table, 'Item', where: {'Entry': entry});

  Future<void> storeLootTemplate(GameObjectLootTemplateEntity loot) async {
    try {
      await laconic.table(_table).insert([loot.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('掉落模板主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateLootTemplate(
    GameObjectLootTemplateKey originalKey,
    GameObjectLootTemplateEntity loot,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(loot.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在，无法保存');
      }
      rethrow;
    }
  }

  List<String> _briefFields(String alias) => [
    '$alias.Entry',
    '$alias.Item',
    '$alias.Reference',
    '$alias.Chance',
    '$alias.QuestRequired',
    '$alias.GroupId',
    '$alias.MinCount',
    '$alias.MaxCount',
  ];

  QueryBuilder _applyRowFilter(
    QueryBuilder builder,
    GameObjectLootTemplateFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('lt.Entry', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['it.name', 'itl.Name'],
          '%${filter.name}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'it.name',
          '%${filter.name}%',
          comparator: 'like',
        );
      }
    }
    return builder;
  }
}
