import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'npc_text_locale_repository.g.dart';

@FoxyRepository()
class NpcTextLocaleRepository
    with RepositoryMixin, _NpcTextLocaleRepositoryMixin {
  static const _table = 'npc_text_locale';
  static const primaryKeyColumns = {'ID', 'Locale'};

  /// Applies locale-editor changes atomically: deletions, then updates, then
  /// creations (deletion must run before store, since an update may change
  /// the locale back to a deleted one).
  Future<void> applyNpcTextLocaleChanges({
    required List<NpcTextLocaleEntity> creations,
    required List<NpcTextLocaleKey> deletions,
    required Map<NpcTextLocaleKey, NpcTextLocaleEntity> updates,
  }) async {
    await const DatabaseTransaction().execute(() async {
      for (final key in deletions) {
        await destroyNpcTextLocale(key);
      }
      for (final update in updates.entries) {
        await updateNpcTextLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeNpcTextLocale(locale);
      }
    });
  }

  Future<int> countNpcTextLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<NpcTextLocaleEntity> createNpcTextLocale(
    int id, {
    String locale = '',
  }) async {
    return NpcTextLocaleEntity(id: id, locale: locale);
  }

  Future<List<BriefNpcTextLocaleEntity>> getBriefNpcTextLocales({
    required int id,
    int page = 1,
  }) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'Locale'])
        .where('ID', id)
        .orderBy('Locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefNpcTextLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<NpcTextLocaleEntity>> getNpcTextLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results.map((e) => NpcTextLocaleEntity.fromJson(e.toMap())).toList();
  }
}
