import 'package:foxy/entity/brief_page_text_locale_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/entity/page_text_locale_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PageTextLocaleRepository with RepositoryMixin {
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

  Future<void> destroyPageTextLocale(PageTextLocaleKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原本地化记录不存在，可能已被其他操作修改或删除');
    }
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

  Future<PageTextLocaleEntity?> getPageTextLocale(PageTextLocaleKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PageTextLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storePageTextLocale(PageTextLocaleEntity locale) async {
    try {
      await laconic.table(_table).insert([locale.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('页面文本本地化主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updatePageTextLocale(
    PageTextLocaleKey originalKey,
    PageTextLocaleEntity locale,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(locale.toJson());
      if (matchedRows == 0) {
        throw StateError('原本地化记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的页面文本本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, PageTextLocaleKey key) {
    return builder.where('ID', key.id).where('locale', key.locale);
  }
}
