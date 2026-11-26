import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:laconic/laconic.dart';

part 'item_template_locale_repository.g.dart';

@FoxyRepository()
class ItemTemplateLocaleRepository
    with RepositoryMixin, _ItemTemplateLocaleRepositoryMixin {
  static const primaryKeyColumns = {'ID', 'locale'};

  Future<int> countItemTemplateLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<ItemTemplateLocaleEntity> createItemTemplateLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return ItemTemplateLocaleEntity(id: id, locale: locale);
  }

  Future<List<BriefItemTemplateLocaleEntity>> getBriefItemTemplateLocales({
    required int id,
    int page = 1,
  }) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'Name'])
        .where('ID', id)
        .orderBy('locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefItemTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ItemTemplateLocaleEntity>> getItemTemplateLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => ItemTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }
}
