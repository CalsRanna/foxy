import 'package:foxy/model/creature_template.dart';
import 'package:foxy/model/creature_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateRepository with RepositoryMixin {
  final String _table = 'creature_template';

  Future<void> copyCreatureTemplate(int entry) async {
    var template = await getCreatureTemplate(entry);
    var json = template.toJson();
    var newEntry = await _getNextEntry();
    json['entry'] = newEntry;
    // 处理 MySQL 保留字
    if (json.containsKey('rank')) {
      json['`rank`'] = json.remove('rank');
    }
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextEntry() async {
    var result = await laconic.table(_table).select([
      'MAX(entry) as max_entry',
    ]).first();
    var maxEntry = result.toMap()['max_entry'] as int?;
    return (maxEntry ?? 0) + 1;
  }

  Future<int> count({CreatureTemplateFilterEntity? filter}) async {
    var builder = laconic.table('$_table AS ct');
    builder.select(['ct.entry']);
    builder = builder.leftJoin(
      'creature_template_locale AS ctl',
      (join) => join.on('ct.entry', 'ctl.entry').on('ctl.locale', '"zhCN"'),
    );
    if (filter?.entry.isNotEmpty == true) {
      builder = builder.where('ct.entry', filter!.entry);
    }
    if (filter?.name.isNotEmpty == true) {
      builder = builder.whereAny(
        ['ct.name', 'ctl.Name'],
        '%${filter!.name}%',
        operator: 'like',
      );
    }
    if (filter?.subName.isNotEmpty == true) {
      builder = builder.whereAny(
        ['ct.subname', 'ctl.Title'],
        '%${filter!.subName}%',
        operator: 'like',
      );
    }
    return builder.count();
  }

  Future<void> destroyCreatureTemplate(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<List<BriefCreatureTemplate>> getBriefCreatureTemplates({
    int page = 1,
    CreatureTemplateFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS ct');
    const fields = [
      'ct.entry',
      'ct.name',
      'ct.subname',
      'ct.minlevel',
      'ct.maxlevel',
      'ctl.Name',
      'ctl.Title',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'creature_template_locale AS ctl',
      (join) => join.on('ct.entry', 'ctl.entry').on('ctl.locale', '"zhCN"'),
    );
    if (filter?.entry.isNotEmpty == true) {
      builder = builder.where('ct.entry', filter!.entry);
    }
    if (filter?.name.isNotEmpty == true) {
      builder = builder.whereAny(
        ['ct.name', 'ctl.Name'],
        '%${filter!.name}%',
        operator: 'like',
      );
    }
    if (filter?.subName.isNotEmpty == true) {
      builder = builder.whereAny(
        ['ct.subname', 'ctl.Title'],
        '%${filter!.subName}%',
        operator: 'like',
      );
    }
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.limit(kPageSize).offset(offset).get();
    return results
        .map((e) => BriefCreatureTemplate.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureTemplate> getCreatureTemplate(int entry) async {
    var result = await laconic.table(_table).where('entry', entry).first();
    return CreatureTemplate.fromJson(result.toMap());
  }

  Future<void> storeCreatureTemplate(CreatureTemplate template) async {
    var json = template.toJson();
    json.remove('entry');
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateCreatureTemplate(CreatureTemplate template) async {
    var json = template.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', template.entry).update(json);
  }
}
