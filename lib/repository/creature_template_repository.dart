import 'package:foxy/entity/brief_creature_template_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/entity/creature_template_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureTemplateRepository with RepositoryMixin {
  static const _table = 'creature_template';

  Future<CreatureTemplateKey> copyCreatureTemplate(
    CreatureTemplateKey key,
  ) async {
    final source = await getCreatureTemplate(key);
    if (source == null) {
      throw StateError('原生物模板不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(
      entry: await nextMaxPlusOne(_table, 'entry'),
    );
    await storeCreatureTemplate(copied);
    return CreatureTemplateKey.fromEntity(copied);
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

  Future<CreatureTemplateEntity> createCreatureTemplate() async {
    return CreatureTemplateEntity(entry: await nextMaxPlusOne(_table, 'entry'));
  }

  Future<void> destroyCreatureTemplate(CreatureTemplateKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原生物模板不存在，可能已被其他操作修改或删除');
    }
  }

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

  Future<CreatureTemplateEntity?> getCreatureTemplate(
    CreatureTemplateKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<CreatureTemplateEntity>> getCreatureTemplates() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureTemplate(CreatureTemplateEntity template) async {
    if (template.entry <= 0) {
      throw StateError('生物模板 entry 必须在新建表单打开时显式分配');
    }
    final json = template.toJson();
    _handleReservedWords(json);
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物模板 ${template.entry} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplate(
    CreatureTemplateKey originalKey,
    CreatureTemplateEntity template,
  ) async {
    final json = template.toJson();
    _handleReservedWords(json);
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原生物模板不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物模板 entry 已存在，无法保存');
      }
      rethrow;
    }
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

  QueryBuilder _whereKey(QueryBuilder builder, CreatureTemplateKey key) {
    return builder.where('entry', key.entry);
  }
}
