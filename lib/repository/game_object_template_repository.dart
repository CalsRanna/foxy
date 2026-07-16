import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/entity/game_object_template_filter_entity.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GameObjectTemplateRepository with RepositoryMixin {
  static const _table = 'gameobject_template';
  static const _localeTable = 'gameobject_template_locale';

  Future<void> copyGameObjectTemplate(int entry) async {
    var template = await getGameObjectTemplate(entry);
    if (template == null) return;
    var json = template.toJson();
    var newEntry = await _getNextEntry();
    json['entry'] = newEntry;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countGameObjectTemplates({
    GameObjectTemplateFilterEntity? filter,
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
    return GameObjectTemplateEntity(entry: await _getNextEntry());
  }

  Future<void> destroyGameObjectTemplate(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<List<BriefGameObjectTemplateEntity>> getBriefGameObjectTemplates({
    int page = 1,
    GameObjectTemplateFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS gt');
    final fields = <String>[
      'gt.entry',
      'gt.name',
      'gt.type',
      'gt.size',
      if (localeEnabled) 'gtl.name AS Name',
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
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGameObjectTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectTemplateEntity?> getGameObjectTemplate(int entry) async {
    var results = await laconic
        .table(_table)
        .where('entry', entry)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return GameObjectTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<GameObjectTemplateLocaleEntity>> getGameObjectTemplateLocales(
    int entry,
  ) async {
    var results = await laconic.table(_localeTable).where('entry', entry).get();
    return results
        .map((e) => GameObjectTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GameObjectTemplateEntity>> getGameObjectTemplates() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => GameObjectTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveGameObjectTemplate(GameObjectTemplateEntity template) async {
    if (template.entry == 0) {
      await storeGameObjectTemplate(template);
      return;
    }
    var existing = await getGameObjectTemplate(template.entry);
    if (existing != null) {
      await updateGameObjectTemplate(template);
    } else {
      await laconic.table(_table).insert([template.toJson()]);
    }
  }

  Future<void> saveGameObjectTemplateLocales(
    int entry,
    List<GameObjectTemplateLocaleEntity> locales,
  ) async {
    await laconic.transaction(() async {
      await laconic.table(_localeTable).where('entry', entry).delete();
      if (locales.isEmpty) return;
      var jsons = locales.map((e) {
        var json = e.toJson();
        json['entry'] = entry;
        return json;
      }).toList();
      await laconic.table(_localeTable).insert(jsons);
    });
  }

  Future<int> storeGameObjectTemplate(GameObjectTemplateEntity template) async {
    var json = template.toJson();
    final newEntry = template.entry > 0
        ? template.entry
        : await _getNextEntry();
    json['entry'] = newEntry;
    await laconic.table(_table).insert([json]);
    return newEntry;
  }

  Future<void> updateGameObjectTemplate(
    GameObjectTemplateEntity template,
  ) async {
    var json = template.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', template.entry).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GameObjectTemplateFilterEntity? filter,
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

  Future<int> _getNextEntry() async {
    return nextMaxPlusOne(_table, 'entry');
  }
}
