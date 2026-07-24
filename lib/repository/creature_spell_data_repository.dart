import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_spell_data_repository.g.dart';

@FoxyRepository(CreatureSpellDataEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('spell')
class CreatureSpellDataRepository
    with RepositoryMixin, _CreatureSpellDataRepositoryMixin {
  static const _table = 'foxy.dbc_creature_spell_data';
  static const _spellTable = 'foxy.dbc_spell';

  Future<int> copyCreatureSpellData(int key) async {
    final source = await getCreatureSpellData(key);
    if (source == null) {
      throw StateError('原生物技能数据不存在，可能已被其他操作修改或删除');
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
        builder = builder.where('ID', filter.id);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS dcsd');
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
      'ds_1.Name_lang_zhCN AS spellName1',
      'ds_2.Name_lang_zhCN AS spellName2',
      'ds_3.Name_lang_zhCN AS spellName3',
      'ds_4.Name_lang_zhCN AS spellName4',
    ];
    var builder = laconic.table('$_table AS dcsd');
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

  Future<void> storeCreatureSpellData(CreatureSpellDataEntity data) async {
    if (data.id <= 0) {
      throw StateError('生物技能数据 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([data.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物技能数据 ${data.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureSpellDataFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('dcsd.ID', filter.id);
    }
    if (filter.spell.isNotEmpty) {
      builder = builder.whereAny(
        [
          'ds_1.Name_lang_zhCN',
          'ds_2.Name_lang_zhCN',
          'ds_3.Name_lang_zhCN',
          'ds_4.Name_lang_zhCN',
        ],
        '%${filter.spell}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _joinSpells(QueryBuilder builder) {
    builder = builder.leftJoin(
      '$_spellTable AS ds_1',
      (join) => join.on('dcsd.Spells0', 'ds_1.ID'),
    );
    builder = builder.leftJoin(
      '$_spellTable AS ds_2',
      (join) => join.on('dcsd.Spells1', 'ds_2.ID'),
    );
    builder = builder.leftJoin(
      '$_spellTable AS ds_3',
      (join) => join.on('dcsd.Spells2', 'ds_3.ID'),
    );
    builder = builder.leftJoin(
      '$_spellTable AS ds_4',
      (join) => join.on('dcsd.Spells3', 'ds_4.ID'),
    );
    return builder;
  }
}
