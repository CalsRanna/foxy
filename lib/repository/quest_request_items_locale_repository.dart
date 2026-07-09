import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestRequestItemsLocaleRepository with RepositoryMixin {
  static const _table = 'quest_request_items_locale';

  Future<List<QuestRequestItemsLocaleEntity>> getQuestRequestItemsLocales(
    int id,
  ) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results
        .map((e) => QuestRequestItemsLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveQuestRequestItemsLocales(
    int id,
    List<QuestRequestItemsLocaleEntity> locales,
  ) async {
    await laconic.transaction(() async {
      await laconic.table(_table).where('ID', id).delete();
      if (locales.isEmpty) return;
      final jsons = locales.map((e) {
        final json = e.toJson();
        json['ID'] = id;
        return json;
      }).toList();
      await laconic.table(_table).insert(jsons);
    });
  }
}
