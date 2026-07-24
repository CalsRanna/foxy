import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_bonus_data_repository.g.dart';

@FoxyRepository(SpellBonusDataEntity)
class SpellBonusDataRepository
    with RepositoryMixin, _SpellBonusDataRepositoryMixin {
  static const _table = 'spell_bonus_data';

  Future<void> copySpellBonusData(int key) async {
    throw UnsupportedError('法术加成记录不能自动复制，请为有效法术新增记录。');
  }

  Future<int> countSpellBonusDatas() {
    return laconic.table(_table).count();
  }

  Future<SpellBonusDataEntity> createSpellBonusData([int? entry]) async {
    return SpellBonusDataEntity(
      entry: entry ?? await nextMaxPlusOne(_table, 'entry'),
    );
  }

  Future<List<BriefSpellBonusDataEntity>> getBriefSpellBonusDatas({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select([
          'entry',
          'direct_bonus',
          'dot_bonus',
          'ap_bonus',
          'ap_dot_bonus',
          'comments',
        ])
        .orderBy('entry')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellBonusDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<SpellBonusDataEntity>> getSpellBonusDatas() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => SpellBonusDataEntity.fromJson(row.toMap()))
        .toList();
  }
}
