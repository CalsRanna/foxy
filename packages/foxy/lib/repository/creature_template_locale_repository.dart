import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:laconic/laconic.dart';

part 'creature_template_locale_repository.g.dart';

@FoxyRepository()
class CreatureTemplateLocaleRepository
    with RepositoryMixin, _CreatureTemplateLocaleRepositoryMixin {
  static const primaryKeyColumns = {'entry', 'locale'};

  Future<int> countCreatureTemplateLocales({required int entry}) {
    return laconic.table(_table).where('entry', entry).count();
  }

  Future<CreatureTemplateLocaleEntity> createCreatureTemplateLocale({
    required int entry,
    String locale = 'zhCN',
  }) async {
    return CreatureTemplateLocaleEntity(entry: entry, locale: locale);
  }

  Future<List<BriefCreatureTemplateLocaleEntity>>
  getBriefCreatureTemplateLocales({required int entry, int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['entry', 'locale', 'Name', 'Title'])
        .where('entry', entry)
        .orderBy('locale')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefCreatureTemplateLocaleEntity.fromJson(row.toMap()))
        .toList();
  }
}
