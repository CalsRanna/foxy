import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_template_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'GameObjectTemplateFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'entry',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'name',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class GameObjectTemplateRepository with RepositoryMixin {
  static const _table = 'gameobject_template';

  Future<int> copyGameObjectTemplate(int key) async {
    final source = await getGameObjectTemplate(key);
    if (source == null) {
      throw StateError('原游戏对象模板不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(
      entry: await nextMaxPlusOne(_table, 'entry'),
    );
    await storeGameObjectTemplate(copied);
    return copied.entry;
  }

  Future<int> countGameObjectTemplates({
    GameObjectTemplateFilter? filter,
  }) async {
    final needsLocaleJoin =
        localeEnabled && filter != null && filter.name.isNotEmpty;
    if (!needsLocaleJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.entry.isNotEmpty) {
        builder = builder.where('entry', filter.entry);
      }
      if (filter != null && filter.name.isNotEmpty) {
        builder = builder.where('name', '%${filter.name}%', comparator: 'like');
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS gt');
    builder = builder.leftJoin(
      'gameobject_template_locale AS gtl',
      (join) => join.on('gt.entry', 'gtl.entry').where('gtl.locale', 'zhCN'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GameObjectTemplateEntity> createGameObjectTemplate() async {
    return GameObjectTemplateEntity(
      entry: await nextMaxPlusOne(_table, 'entry'),
    );
  }

  Future<void> destroyGameObjectTemplate(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原游戏对象模板不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGameObjectTemplateEntity>> getBriefGameObjectTemplates({
    int page = 1,
    GameObjectTemplateFilter? filter,
  }) async {
    var builder = laconic.table('$_table AS gt');
    final fields = <String>[
      'gt.entry',
      'gt.name',
      'gt.type',
      'gt.size',
      if (localeEnabled) 'gtl.name AS localeName',
    ];
    builder = builder.select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        'gameobject_template_locale AS gtl',
        (join) => join.on('gt.entry', 'gtl.entry').where('gtl.locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('gt.entry');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectTemplateEntity?> getGameObjectTemplate(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<GameObjectTemplateEntity>> getGameObjectTemplates() async {
    final results = await laconic.table(_table).orderBy('entry').get();
    return results
        .map((e) => GameObjectTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeGameObjectTemplate(
    GameObjectTemplateEntity template,
  ) async {
    if (template.entry <= 0) {
      throw StateError('游戏对象模板 entry 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([template.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('游戏对象模板 ${template.entry} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectTemplate(
    int originalKey,
    GameObjectTemplateEntity template,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(template.toJson());
      if (matchedRows == 0) {
        throw StateError('原游戏对象模板不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的游戏对象模板 entry 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GameObjectTemplateFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('gt.entry', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['gt.name', 'gtl.name'],
          '%${filter.name}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'gt.name',
          '%${filter.name}%',
          comparator: 'like',
        );
      }
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('entry', key);
  }
}
