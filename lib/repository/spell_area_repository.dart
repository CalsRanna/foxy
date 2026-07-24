import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_area_repository.g.dart';

@FoxyRepository(SpellAreaEntity)
class SpellAreaRepository with RepositoryMixin, _SpellAreaRepositoryMixin {
  static const _table = 'spell_area';

  Future<void> copySpellArea(SpellAreaKey key) async {
    throw UnsupportedError('法术区域记录不能自动复制，请新增记录并选择有效区域。');
  }

  Future<int> countSpellAreas(int spell) {
    return laconic.table(_table).where('spell', spell).count();
  }

  Future<SpellAreaEntity> createSpellArea(int spell) async {
    return SpellAreaEntity(spell: spell);
  }

  Future<List<BriefSpellAreaEntity>> getBriefSpellAreas(
    int spell, {
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select([
          'spell',
          'area',
          'quest_start',
          'quest_end',
          'aura_spell',
          'racemask',
          'gender',
          'quest_start_status',
          'quest_end_status',
        ])
        .where('spell', spell)
        .orderBy('area')
        .orderBy('quest_start')
        .orderBy('aura_spell')
        .orderBy('racemask')
        .orderBy('gender')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellAreaEntity.fromJson(row.toMap()))
        .toList();
  }
}
