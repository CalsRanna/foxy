import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'talent_repository.g.dart';

@FoxyRepository(TalentEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('spell')
class TalentRepository with RepositoryMixin, _TalentRepositoryMixin {
  static const _table = 'foxy.dbc_talent';

  Future<int> copyTalent(int key) async {
    final source = await getTalent(key);
    if (source == null) {
      throw StateError('原天赋不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeTalent(copied);
    return copied.id;
  }

  Future<int> countTalents({TalentFilter? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<TalentEntity> createTalent() async {
    return TalentEntity(id: await _getNextId());
  }

  Future<List<BriefTalentEntity>> getBriefTalents({
    int page = 1,
    TalentFilter? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'TabID',
      'TierID',
      'ColumnIndex',
      'SpellRank0',
    ]);
    builder = _applyFilter(builder, filter);
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows.map((row) => BriefTalentEntity.fromJson(row.toMap())).toList();
  }

  Future<List<TalentEntity>> getTalents() async {
    final rows = await laconic.table(_table).orderBy('ID').get();
    return rows.map((row) => TalentEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeTalent(TalentEntity talent) async {
    if (talent.id <= 0) {
      throw StateError('天赋 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([talent.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('天赋 ${talent.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, TalentFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.spell.isNotEmpty) {
      builder = builder.whereNested(
        (query) => query
            .where('SpellRank0', filter.spell)
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
      throw StateError('Talent ID 已超出 DBC int32 范围');
    }
    return id;
  }
}
