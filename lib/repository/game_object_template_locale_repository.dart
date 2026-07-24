import 'package:foxy/entity/game_object_template_locale_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GameObjectTemplateLocaleRepository with RepositoryMixin {
  static const _table = 'gameobject_template_locale';
  static const primaryKeyColumns = {'entry', 'locale'};

  Future<void> applyGameObjectTemplateLocaleChanges({
    required List<GameObjectTemplateLocaleEntity> creations,
    required List<GameObjectTemplateLocaleKey> deletions,
    required Map<GameObjectTemplateLocaleKey, GameObjectTemplateLocaleEntity>
    updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyGameObjectTemplateLocale(key);
      }
      for (final update in updates.entries) {
        await updateGameObjectTemplateLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeGameObjectTemplateLocale(locale);
      }
    });
  }

  Future<int> countGameObjectTemplateLocales({required int entry}) {
    return laconic.table(_table).where('entry', entry).count();
  }

  Future<GameObjectTemplateLocaleEntity> createGameObjectTemplateLocale({
    required int entry,
    String locale = 'zhCN',
  }) async {
    return GameObjectTemplateLocaleEntity(entry: entry, locale: locale);
  }

  Future<void> destroyGameObjectTemplateLocale(
    GameObjectTemplateLocaleKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原游戏对象模板本地化记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGameObjectTemplateLocaleEntity>>
  getBriefGameObjectTemplateLocales({required int entry, int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['entry', 'locale', 'name', 'castBarCaption'])
        .where('entry', entry)
        .orderBy('locale')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefGameObjectTemplateLocaleEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<GameObjectTemplateLocaleEntity?> getGameObjectTemplateLocale(
    GameObjectTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectTemplateLocale(
    GameObjectTemplateLocaleEntity locale,
  ) async {
    try {
      await laconic.table(_table).insert([locale.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('游戏对象模板本地化主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectTemplateLocale(
    GameObjectTemplateLocaleKey originalKey,
    GameObjectTemplateLocaleEntity locale,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(locale.toJson());
      if (matchedRows == 0) {
        throw StateError('原游戏对象模板本地化记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的游戏对象模板本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(
    QueryBuilder builder,
    GameObjectTemplateLocaleKey key,
  ) {
    return builder.where('entry', key.entry).where('locale', key.locale);
  }
}
