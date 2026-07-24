import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GossipMenuOptionRepository with RepositoryMixin {
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

  Future<void> destroyGossipMenuOption(GossipMenuOptionKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
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

  Future<GossipMenuOptionEntity?> getGossipMenuOption(
    GossipMenuOptionKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GossipMenuOptionEntity.fromJson(results.first.toMap());
  }

  Future<List<GossipMenuOptionEntity>> getGossipMenuOptions() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => GossipMenuOptionEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeGossipMenuOption(GossipMenuOptionEntity model) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('对话菜单选项主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGossipMenuOption(
    GossipMenuOptionKey originalKey,
    GossipMenuOptionEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的对话菜单选项主键已存在，无法保存');
      }
      rethrow;
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

  QueryBuilder _whereKey(QueryBuilder builder, GossipMenuOptionKey key) {
    return builder.where('MenuID', key.menuId).where('OptionID', key.optionId);
  }
}
