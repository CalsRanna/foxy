import 'package:foxy/entity/quest_template_locale_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:laconic/laconic.dart';

part 'quest_template_locale_repository.g.dart';

@FoxyRepository()
class QuestTemplateLocaleRepository
    with RepositoryMixin, _QuestTemplateLocaleRepositoryMixin {
  static const primaryKeyColumns = {'ID', 'locale'};

  Future<int> countQuestTemplateLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<QuestTemplateLocaleEntity> createQuestTemplateLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return QuestTemplateLocaleEntity(id: id, locale: locale);
  }

  Future<List<BriefQuestTemplateLocaleEntity>> getBriefQuestTemplateLocales({
    required int id,
    int page = 1,
  }) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'Title'])
        .where('ID', id)
        .orderBy('locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefQuestTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestTemplateLocaleEntity>>
  getQuestTemplateLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => QuestTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }
}
