import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'talent_repository.g.dart';

@FoxyRepository(TalentEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('spell', column: 'SpellRank0')
class TalentRepository with RepositoryMixin, _TalentRepositoryMixin {
  static const _table = 'foxy.dbc_talent';

  @override
  Future<int> copyTalent(int key) async {
    final source = await getTalent(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeTalent(copied);
    return copied.id;
  }

  @override
  Future<TalentEntity> createTalent() async {
    return TalentEntity(id: await _getNextId());
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, TalentFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    if (filter.spell.isNotEmpty) {
      builder = builder.whereNested(
        (query) => query
            .where('SpellRank0', int.tryParse(filter.spell) ?? 0)
            .orWhere('SpellRank1', filter.spell)
            .orWhere('SpellRank2', filter.spell)
            .orWhere('SpellRank3', filter.spell)
            .orWhere('SpellRank4', filter.spell)
            .orWhere('SpellRank5', filter.spell)
            .orWhere('SpellRank6', filter.spell)
            .orWhere('SpellRank7', filter.spell)
            .orWhere('SpellRank8', filter.spell),
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw IdExhaustedException('Talent ID exceeds DBC int32 range');
    }
    return id;
  }
}
