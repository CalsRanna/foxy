import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_template_locale_repository.g.dart';

@FoxyRepository(CreatureTemplateLocaleEntity)
class CreatureTemplateLocaleRepository
    with RepositoryMixin, _CreatureTemplateLocaleRepositoryMixin {
  static const _table = 'creature_template_locale';
  static const primaryKeyColumns = {'entry', 'locale'};

  Future<void> applyCreatureTemplateLocaleChanges({
    required List<CreatureTemplateLocaleEntity> creations,
    required List<CreatureTemplateLocaleKey> deletions,
    required Map<CreatureTemplateLocaleKey, CreatureTemplateLocaleEntity>
    updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyCreatureTemplateLocale(key);
      }
      for (final update in updates.entries) {
        await updateCreatureTemplateLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeCreatureTemplateLocale(locale);
      }
    });
  }

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
