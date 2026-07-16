import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy/entity/creature_spell_data_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureSpellDataRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_creature_spell_data';
  static const _spellTable = 'foxy.dbc_spell';

  Future<void> copyCreatureSpellData(int id) async {
    var source = await getCreatureSpellData(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countCreatureSpellDatas({
    CreatureSpellDataFilterEntity? filter,
  }) async {
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
    return CreatureSpellDataEntity(id: await _getNextId());
  }

  Future<void> destroyCreatureSpellData(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefCreatureSpellDataEntity>> getBriefCreatureSpellDatas({
    int page = 1,
    CreatureSpellDataFilterEntity? filter,
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
      'ds_1.Name_lang_zhCN AS SpellName1',
      'ds_2.Name_lang_zhCN AS SpellName2',
      'ds_3.Name_lang_zhCN AS SpellName3',
      'ds_4.Name_lang_zhCN AS SpellName4',
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

  Future<CreatureSpellDataEntity?> getCreatureSpellData(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureSpellDataEntity.fromJson(results.first.toMap());
  }

  Future<List<CreatureSpellDataEntity>> getCreatureSpellDatas() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureSpellDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveCreatureSpellData(CreatureSpellDataEntity data) async {
    if (data.id == 0) {
      await storeCreatureSpellData(data);
      return;
    }
    var existing = await getCreatureSpellData(data.id);
    if (existing != null) {
      await updateCreatureSpellData(data);
    } else {
      await laconic.table(_table).insert([data.toJson()]);
    }
  }

  Future<int> storeCreatureSpellData(CreatureSpellDataEntity data) async {
    var json = data.toJson();
    final nextId = data.id > 0 ? data.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCreatureSpellData(CreatureSpellDataEntity data) async {
    var json = data.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', data.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureSpellDataFilterEntity? filter,
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

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
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
