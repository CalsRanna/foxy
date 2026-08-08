import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'gossip_menu_option_locale_repository.g.dart';

@FoxyRepository()
class GossipMenuOptionLocaleRepository
    with RepositoryMixin, _GossipMenuOptionLocaleRepositoryMixin {
  static const _table = 'gossip_menu_option_locale';
  static const primaryKeyColumns = {'MenuID', 'OptionID', 'Locale'};

  /// Applies locale-editor changes atomically: deletions, then updates, then
  /// creations (deletion must run before store, since an update may change
  /// the locale back to a deleted one).
  Future<void> applyGossipMenuOptionLocaleChanges({
    required List<GossipMenuOptionLocaleEntity> creations,
    required List<GossipMenuOptionLocaleKey> deletions,
    required Map<GossipMenuOptionLocaleKey, GossipMenuOptionLocaleEntity>
    updates,
  }) async {
    await const DatabaseTransaction().execute(() async {
      for (final key in deletions) {
        await destroyGossipMenuOptionLocale(key);
      }
      for (final update in updates.entries) {
        await updateGossipMenuOptionLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeGossipMenuOptionLocale(locale);
      }
    });
  }

  Future<void> copyGossipMenuOptionLocales(
    GossipMenuOptionKey sourceKey,
    GossipMenuOptionKey targetKey,
  ) async {
    final results = await laconic
        .table(_table)
        .where('MenuID', sourceKey.menuId)
        .where('OptionID', sourceKey.optionId)
        .get();
    if (results.isEmpty) return;
    final jsons = results.map((row) {
      final json = row.toMap();
      json['MenuID'] = targetKey.menuId;
      json['OptionID'] = targetKey.optionId;
      return json;
    }).toList();
    try {
      await laconic.table(_table).insert(jsons);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'the copied locale primary key already exists',
        );
      }
      rethrow;
    }
  }

  Future<int> countGossipMenuOptionLocales({int menuId = 0}) {
    final query = menuId == 0
        ? laconic.table(_table)
        : laconic.table(_table).where('MenuID', menuId);
    return query.count();
  }

  Future<GossipMenuOptionLocaleEntity> createGossipMenuOptionLocale({
    int menuId = 0,
    int optionId = 0,
    String locale = 'zhCN',
  }) async {
    return GossipMenuOptionLocaleEntity(
      menuId: menuId,
      optionId: optionId,
      locale: locale,
    );
  }

  Future<List<BriefGossipMenuOptionLocaleEntity>>
  getBriefGossipMenuOptionLocales({int menuId = 0, int page = 1}) async {
    final query = menuId == 0
        ? laconic.table(_table).select([
            'MenuID',
            'OptionID',
            'Locale',
            'OptionText',
          ])
        : laconic
              .table(_table)
              .select(['MenuID', 'OptionID', 'Locale', 'OptionText'])
              .where('MenuID', menuId);
    final results = await query
        .orderBy('MenuID')
        .orderBy('OptionID')
        .orderBy('Locale')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (result) =>
              BriefGossipMenuOptionLocaleEntity.fromJson(result.toMap()),
        )
        .toList();
  }

  Future<List<GossipMenuOptionLocaleEntity>>
  getGossipMenuOptionLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((result) => GossipMenuOptionLocaleEntity.fromJson(result.toMap()))
        .toList();
  }

  Future<List<GossipMenuOptionLocaleEntity>> getGossipMenuOptionLocales(
    int menuId,
  ) async {
    final results = await laconic.table(_table).where('MenuID', menuId).get();
    return results
        .map((result) => GossipMenuOptionLocaleEntity.fromJson(result.toMap()))
        .toList();
  }

  Future<List<GossipMenuOptionLocaleEntity>>
  getGossipMenuOptionLocalesForOption(GossipMenuOptionKey key) async {
    final results = await laconic
        .table(_table)
        .where('MenuID', key.menuId)
        .where('OptionID', key.optionId)
        .get();
    return results
        .map((result) => GossipMenuOptionLocaleEntity.fromJson(result.toMap()))
        .toList();
  }
}
