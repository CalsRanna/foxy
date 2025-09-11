import 'package:foxy/model/creature_template.dart';
import 'package:foxy/model/creature_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateRepository with RepositoryMixin {
  final String _table = 'creature_template';

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
    builder = builder.join(
      'creature_template_locale AS ctl',
      (join) => join.on('ct.entry', 'ctl.entry').on('ctl.locale', '"zhCN"'),
    );
    if (filter?.entry.isNotEmpty == true) {
      builder = builder.where('ct.entry', filter!.entry);
    }
    if (filter?.name.isNotEmpty == true) {
      builder = builder.where(
        'ct.name',
        '%${filter!.name}%',
        comparator: 'like',
      );
    }
    if (filter?.subName.isNotEmpty == true) {
      builder = builder.where(
        'ct.subname',
        '%${filter!.subName}%',
        comparator: 'like',
      );
    }
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.limit(kPageSize).offset(offset).get();
    return results
        .map((e) => BriefCreatureTemplate.fromJson(e.toMap()))
        .toList();
  }

  Future<int> count({CreatureTemplateFilterEntity? filter}) async {
    var builder = laconic.table('$_table AS ct');
    builder.select(['ct.entry']);
    builder = builder.join(
      'creature_template_locale AS ctl',
      (join) => join.on('ct.entry', 'ctl.entry').on('ctl.locale', '"zhCN"'),
    );
    if (filter?.entry.isNotEmpty == true) {
      builder = builder.where('ct.entry', filter!.entry);
    }
    if (filter?.name.isNotEmpty == true) {
      builder = builder.where(
        'ct.name',
        '%${filter!.name}%',
        comparator: 'like',
      );
    }
    if (filter?.subName.isNotEmpty == true) {
      builder = builder.where(
        'ct.subname',
        '%${filter!.subName}%',
        comparator: 'like',
      );
    }
    return builder.count();
  }
}
