import 'package:foxy/entity/quest_request_items_locale_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_request_items_locale_repository.g.dart';

@FoxyRepository(QuestRequestItemsLocaleEntity)
class QuestRequestItemsLocaleRepository
    with RepositoryMixin, _QuestRequestItemsLocaleRepositoryMixin {
  static const _table = 'quest_request_items_locale';
  static const primaryKeyColumns = {'ID', 'locale'};

  Future<void> applyQuestRequestItemsLocaleChanges({
    required List<QuestRequestItemsLocaleEntity> creations,
    required List<QuestRequestItemsLocaleKey> deletions,
    required Map<QuestRequestItemsLocaleKey, QuestRequestItemsLocaleEntity>
    updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyQuestRequestItemsLocale(key);
      }
      for (final update in updates.entries) {
        await updateQuestRequestItemsLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeQuestRequestItemsLocale(locale);
      }
    });
  }

  Future<int> countQuestRequestItemsLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<QuestRequestItemsLocaleEntity> createQuestRequestItemsLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return QuestRequestItemsLocaleEntity(id: id, locale: locale);
  }

  Future<List<BriefQuestRequestItemsLocaleEntity>>
  getBriefQuestRequestItemsLocales({required int id, int page = 1}) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'CompletionText'])
        .where('ID', id)
        .orderBy('locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefQuestRequestItemsLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestRequestItemsLocaleEntity>>
  getQuestRequestItemsLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => QuestRequestItemsLocaleEntity.fromJson(e.toMap()))
        .toList();
  }
}
