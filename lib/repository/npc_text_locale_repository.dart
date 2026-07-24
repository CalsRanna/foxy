import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'npc_text_locale_repository.g.dart';

@FoxyRepository(NpcTextLocaleEntity)
class NpcTextLocaleRepository
    with RepositoryMixin, _NpcTextLocaleRepositoryMixin {
  static const _table = 'npc_text_locale';
  static const primaryKeyColumns = {'ID', 'Locale'};

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
