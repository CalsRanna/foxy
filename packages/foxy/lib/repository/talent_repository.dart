import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'talent_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('spell', column: 'SpellRank0')
class TalentRepository with RepositoryMixin, _TalentRepositoryMixin {
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
  Future<int> countTalents({TalentFilter? filter}) async {
    var builder = laconic.table('$_table as dt');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  @override
  Future<List<BriefTalentEntity>> getBriefTalents({
    int page = 1,
    TalentFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as dt');
    const fields = [
      'dt.ID',
      'dt.TabID',
      'dt.TierID',
      'dt.ColumnIndex',
      'dt.SpellRank0',
      'dtt.Name_lang_enUS as tabNameEnUS',
      'dtt.Name_lang_zhCN as tabNameZhCN',
      'ds.Name_lang_enUS as spellNameEnUS',
      'ds.Name_lang_zhCN as spellNameZhCN',
      'dsi.TextureFilename as textureFilename',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_talent_tab as dtt',
      (join) => join.on('dt.TabID', 'dtt.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell as ds',
      (join) => join.on('dt.SpellRank0', 'ds.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_icon as dsi',
      (join) => join.on('ds.SpellIconID', 'dsi.ID'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('dt.ID');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results.map((e) => BriefTalentEntity.fromJson(e.toMap())).toList();
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, TalentFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('dt.ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.spell.isNotEmpty) {
      builder = builder.whereNested(
        (query) => query
            .where('dt.SpellRank0', int.tryParse(filter.spell) ?? 0)
            .orWhere('dt.SpellRank1', filter.spell)
            .orWhere('dt.SpellRank2', filter.spell)
            .orWhere('dt.SpellRank3', filter.spell)
            .orWhere('dt.SpellRank4', filter.spell)
            .orWhere('dt.SpellRank5', filter.spell)
            .orWhere('dt.SpellRank6', filter.spell)
            .orWhere('dt.SpellRank7', filter.spell)
            .orWhere('dt.SpellRank8', filter.spell),
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
