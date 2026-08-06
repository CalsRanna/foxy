import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_group_repository.g.dart';

@FoxyRepository(SpellGroupEntity, linkKey: ['spellId'])
class SpellGroupRepository with RepositoryMixin, _SpellGroupRepositoryMixin {
  static const _table = 'spell_group';

  @override
  Future<SpellGroupKey> copySpellGroup(SpellGroupKey key) async {
    final source = await getSpellGroup(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'id'));
    await storeSpellGroup(copied);
    return SpellGroupKey.fromEntity(copied);
  }

  @override
  Future<int> countSpellGroups(int spellId) {
    return laconic.table(_table).where('spell_id', spellId).count();
  }

  @override
  Future<SpellGroupEntity> createSpellGroup(int spellId) async {
    return SpellGroupEntity(
      id: await nextMaxPlusOne(_table, 'id'),
      spellId: spellId,
    );
  }

  @override
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
