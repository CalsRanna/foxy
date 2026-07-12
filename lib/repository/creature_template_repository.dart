import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureTemplateRepository with RepositoryMixin {
  static const _table = 'creature_template';
  static const _localeTable = 'creature_template_locale';

  Future<List<BriefCreatureTemplateEntity>> getBriefCreatureTemplates({
    int page = 1,
    CreatureTemplateFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS ct');
    final fields = <String>[
      'ct.entry',
      'ct.name',
      'ct.subname',
      'ct.minlevel',
      'ct.maxlevel',
      if (localeEnabled) ...['ctl.Name', 'ctl.Title'],
    ];
    builder = builder.select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        'creature_template_locale AS ctl',
        (join) => join.on('ct.entry', 'ctl.entry').where('ctl.locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ct.entry');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CreatureTemplateEntity>> getCreatureTemplates() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countCreatureTemplates({
    CreatureTemplateFilterEntity? filter,
  }) async {
    final needsLocaleJoin =
        localeEnabled &&
        filter != null &&
        (filter.name.isNotEmpty || filter.subName.isNotEmpty);
    if (!needsLocaleJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.entry.isNotEmpty) {
        builder = builder.where('entry', filter.entry);
      }
      if (filter != null && filter.name.isNotEmpty) {
        builder = builder.where('name', '%${filter.name}%', comparator: 'like');
      }
      if (filter != null && filter.subName.isNotEmpty) {
        builder = builder.where(
          'subname',
          '%${filter.subName}%',
          comparator: 'like',
        );
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS ct');
    builder = builder.leftJoin(
      'creature_template_locale AS ctl',
      (join) => join.on('ct.entry', 'ctl.entry').where('ctl.locale', 'zhCN'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureTemplateEntity?> getCreatureTemplate(int entry) async {
    var results = await laconic
        .table(_table)
        .where('entry', entry)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureTemplateEntity.fromJson(results.first.toMap());
  }

  Future<CreatureTemplateEntity> createCreatureTemplate() async {
    return CreatureTemplateEntity(entry: await _getNextEntry());
  }

  Future<int> storeCreatureTemplate(CreatureTemplateEntity template) async {
    var json = template.toJson();
    final newEntry = template.entry > 0
        ? template.entry
        : await _getNextEntry();
    json['entry'] = newEntry;
    _handleReservedWords(json);
    await laconic.table(_table).insert([json]);
    return newEntry;
  }

  Future<void> updateCreatureTemplate(CreatureTemplateEntity template) async {
    var json = template.toJson();
    json.remove('entry');
    _handleReservedWords(json);
    await laconic.table(_table).where('entry', template.entry).update(json);
  }

  Future<void> destroyCreatureTemplate(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<void> copyCreatureTemplate(int entry) async {
    var template = await getCreatureTemplate(entry);
    if (template == null) return;
    var json = template.toJson();
    var newEntry = await _getNextEntry();
    json['entry'] = newEntry;
    _handleReservedWords(json);
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureTemplate(CreatureTemplateEntity template) async {
    if (template.entry == 0) {
      await storeCreatureTemplate(template);
      return;
    }
    var existing = await getCreatureTemplate(template.entry);
    if (existing != null) {
      await updateCreatureTemplate(template);
    } else {
      var json = template.toJson();
      _handleReservedWords(json);
      await laconic.table(_table).insert([json]);
    }
  }

  Future<List<CreatureTemplateLocaleEntity>> getCreatureTemplateLocales(
    int entry,
  ) async {
    var results = await laconic.table(_localeTable).where('entry', entry).get();
    return results
        .map((e) => CreatureTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveCreatureTemplateLocales(
    int entry,
    List<CreatureTemplateLocaleEntity> locales,
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

  Future<int> _getNextEntry() async {
    return nextMaxPlusOne(_table, 'entry');
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureTemplateFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('ct.entry', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['ct.name', 'ctl.Name'],
          '%${filter.name}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'ct.name',
          '%${filter.name}%',
          comparator: 'like',
        );
      }
    }
    if (filter.subName.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['ct.subname', 'ctl.Title'],
          '%${filter.subName}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'ct.subname',
          '%${filter.subName}%',
          comparator: 'like',
        );
      }
    }
    return builder;
  }

  void _handleReservedWords(Map<String, dynamic> json) {
    if (json.containsKey('rank')) {
      json['`rank`'] = json.remove('rank');
    }
  }
}
