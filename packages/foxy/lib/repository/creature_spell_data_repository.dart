import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_spell_data_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('spell')
class CreatureSpellDataRepository
    with RepositoryMixin, _CreatureSpellDataRepositoryMixin {
  static const _spellTable = 'foxy.dbc_spell';

  Future<int> copyCreatureSpellData(int key) async {
    final source = await getCreatureSpellData(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeCreatureSpellData(copied);
    return copied.id;
  }

  Future<int> countCreatureSpellDatas({CreatureSpellDataFilter? filter}) async {
    final needsSpellJoin = filter != null && filter.spell.isNotEmpty;
    if (!needsSpellJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.id.isNotEmpty) {
        builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table as dcsd');
    builder = _joinSpells(builder);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureSpellDataEntity> createCreatureSpellData() async {
    return CreatureSpellDataEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefCreatureSpellDataEntity>> getBriefCreatureSpellDatas({
    int page = 1,
    CreatureSpellDataFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    const fields = [
      'dcsd.ID',
      'dcsd.Spells0',
      'dcsd.Spells1',
      'dcsd.Spells2',
      'dcsd.Spells3',
      'dcsd.Availability0',
      'dcsd.Availability1',
      'dcsd.Availability2',
      'dcsd.Availability3',
      'ds_1.Name_lang_zhCN as spellName1',
      'ds_2.Name_lang_zhCN as spellName2',
      'ds_3.Name_lang_zhCN as spellName3',
      'ds_4.Name_lang_zhCN as spellName4',
    ];
    var builder = laconic.table('$_table as dcsd');
    builder = builder.select(fields);
    builder = _joinSpells(builder);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureSpellDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CreatureSpellDataEntity>> getCreatureSpellDatas() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureSpellDataEntity.fromJson(e.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureSpellDataFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('dcsd.ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.spell.isNotEmpty) {
      builder = builder.whereAny(
        [
          'ds_1.Name_lang_zhCN',
          'ds_2.Name_lang_zhCN',
          'ds_3.Name_lang_zhCN',
          'ds_4.Name_lang_zhCN',
        ],
        '%${ParseUtil.escapeLike(filter.spell)}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _joinSpells(QueryBuilder builder) {
    builder = builder.leftJoin(
      '$_spellTable as ds_1',
      (join) => join.on('dcsd.Spells0', 'ds_1.ID'),
    );
    builder = builder.leftJoin(
      '$_spellTable as ds_2',
      (join) => join.on('dcsd.Spells1', 'ds_2.ID'),
    );
    builder = builder.leftJoin(
      '$_spellTable as ds_3',
      (join) => join.on('dcsd.Spells2', 'ds_3.ID'),
    );
    builder = builder.leftJoin(
      '$_spellTable as ds_4',
      (join) => join.on('dcsd.Spells3', 'ds_4.ID'),
    );
    return builder;
  }
}
