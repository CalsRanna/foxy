import 'package:foxy/entity/quest_template_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestTemplateLocaleRepository with RepositoryMixin {
  static const _table = 'quest_template_locale';

  Future<List<QuestTemplateLocaleEntity>> getQuestTemplateLocales(
    int id,
  ) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results
        .map((e) => QuestTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveQuestTemplateLocales(
    int id,
    List<QuestTemplateLocaleEntity> locales,
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
