import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'page_text_locale_repository.g.dart';

@FoxyRepository(PageTextLocaleEntity)
class PageTextLocaleRepository
    with RepositoryMixin, _PageTextLocaleRepositoryMixin {
  static const _table = 'page_text_locale';
  static const primaryKeyColumns = {'ID', 'locale'};

  Future<void> applyPageTextLocaleChanges({
    required List<PageTextLocaleEntity> creations,
    required List<PageTextLocaleKey> deletions,
    required Map<PageTextLocaleKey, PageTextLocaleEntity> updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyPageTextLocale(key);
      }
      for (final update in updates.entries) {
        await updatePageTextLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storePageTextLocale(locale);
      }
    });
  }

  Future<int> countPageTextLocales(int id) {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<PageTextLocaleEntity> createPageTextLocale({
    required int id,
    required String locale,
  }) async {
    return PageTextLocaleEntity(id: id, locale: locale);
  }

  Future<List<BriefPageTextLocaleEntity>> getBriefPageTextLocales({
    required int id,
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'Text', 'VerifiedBuild'])
        .where('ID', id)
        .orderBy('locale')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((result) => BriefPageTextLocaleEntity.fromJson(result.toMap()))
        .toList();
  }
}
