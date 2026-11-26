import 'package:foxy/entity/game_object_template_locale_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:laconic/laconic.dart';

part 'game_object_template_locale_repository.g.dart';

@FoxyRepository()
class GameObjectTemplateLocaleRepository
    with RepositoryMixin, _GameObjectTemplateLocaleRepositoryMixin {
  static const primaryKeyColumns = {'entry', 'locale'};

  Future<int> countGameObjectTemplateLocales({required int entry}) {
    return laconic.table(_table).where('entry', entry).count();
  }

  Future<GameObjectTemplateLocaleEntity> createGameObjectTemplateLocale({
    required int entry,
    String locale = 'zhCN',
  }) async {
    return GameObjectTemplateLocaleEntity(entry: entry, locale: locale);
  }

  Future<List<BriefGameObjectTemplateLocaleEntity>>
  getBriefGameObjectTemplateLocales({required int entry, int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['entry', 'locale', 'name', 'castBarCaption'])
        .where('entry', entry)
        .orderBy('locale')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefGameObjectTemplateLocaleEntity.fromJson(row.toMap()))
        .toList();
  }
}
