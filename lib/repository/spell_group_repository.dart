import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_group_repository.g.dart';

@FoxyRepository(SpellGroupEntity)
class SpellGroupRepository with RepositoryMixin, _SpellGroupRepositoryMixin {
  static const _table = 'spell_group';

  Future<SpellGroupKey> copySpellGroup(SpellGroupKey key) async {
    final source = await getSpellGroup(key);
    if (source == null) {
      throw StateError('原法术组记录不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'id'));
    await storeSpellGroup(copied);
    return SpellGroupKey.fromEntity(copied);
  }

  Future<int> countSpellGroups(int spellId) {
    return laconic.table(_table).where('spell_id', spellId).count();
  }

  Future<SpellGroupEntity> createSpellGroup(int spellId) async {
    return SpellGroupEntity(
      id: await nextMaxPlusOne(_table, 'id'),
      spellId: spellId,
    );
  }

  Future<List<BriefSpellGroupEntity>> getBriefSpellGroups(
    int spellId, {
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select(['id', 'spell_id'])
        .where('spell_id', spellId)
        .orderBy('id')
        .orderBy('spell_id')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellGroupEntity.fromJson(row.toMap()))
        .toList();
  }
}
