import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_template_repository.g.dart';

@FoxyRepository(GameObjectTemplateEntity)
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class GameObjectTemplateRepository
    with RepositoryMixin, _GameObjectTemplateRepositoryMixin {
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

  Future<List<GameObjectTemplateEntity>> getGameObjectTemplates() async {
    final results = await laconic.table(_table).orderBy('entry').get();
    return results
        .map((e) => GameObjectTemplateEntity.fromJson(e.toMap()))
        .toList();
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
}
