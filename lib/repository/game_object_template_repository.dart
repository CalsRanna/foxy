import 'package:foxy/entity/game_object_template.dart';
import 'package:foxy/entity/game_object_template_filter_entity.dart';
import 'package:foxy/entity/game_object_template_locale.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectTemplateRepository with RepositoryMixin {
  static const _table = 'gameobject_template';
  static const _localeTable = 'gameobject_template_locale';

  Future<void> copyGameObjectTemplate(int entry) async {
    var template = await getGameObjectTemplate(entry);
    var json = template.toJson();
    var newEntry = await _getNextEntry();
    json['entry'] = newEntry;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextEntry() async {
    var result = await laconic.table(_table).select([
      'MAX(entry) as max_entry',
    ]).first();
    var maxEntry = result.toMap()['max_entry'] as int?;
    return (maxEntry ?? 0) + 1;
  }

  Future<int> countGameObjectTemplates({
    GameObjectTemplateFilterEntity? filter,
  }) async {
    var builder = laconic.table('$_table AS gt');
    builder.select(['gt.entry']);
    builder = builder.leftJoin(
      'gameobject_template_locale AS gtl',
      (join) => join.on('gt.entry', 'gtl.entry').on('gtl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<void> destroyGameObjectTemplate(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<List<BriefGameObjectTemplate>> getBriefGameObjectTemplates({
    int page = 1,
    GameObjectTemplateFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS gt');
    const fields = [
      'gt.entry',
      'gt.name',
      'gt.type',
      'gt.size',
      'gtl.name AS Name',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'gameobject_template_locale AS gtl',
      (join) => join.on('gt.entry', 'gtl.entry').on('gtl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGameObjectTemplate.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectTemplate> getGameObjectTemplate(int entry) async {
    var result = await laconic.table(_table).where('entry', entry).first();
    return GameObjectTemplate.fromJson(result.toMap());
  }

  Future<void> storeGameObjectTemplate(GameObjectTemplate template) async {
    var json = template.toJson();
    var newEntry = await _getNextEntry();
    json['entry'] = newEntry;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateGameObjectTemplate(GameObjectTemplate template) async {
    var json = template.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', template.entry).update(json);
  }

  Future<List<GameObjectTemplateLocale>> getGameObjectTemplateLocales(
    int entry,
  ) async {
    var results = await laconic.table(_localeTable).where('entry', entry).get();
    return results
        .map((e) => GameObjectTemplateLocale.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveGameObjectTemplateLocales(
    int entry,
    List<GameObjectTemplateLocale> locales,
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

  dynamic _applyFilter(
    dynamic builder,
    GameObjectTemplateFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('gt.entry', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.whereAny(
        ['gt.name', 'gtl.name'],
        '%${filter.name}%',
        operator: 'like',
      );
    }
    return builder;
  }
}
