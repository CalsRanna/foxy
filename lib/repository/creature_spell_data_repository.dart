import 'package:foxy/model/creature_spell_data.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureSpellDataRepository with RepositoryMixin {
  // DBC 表在 foxy 数据库中
  final String _table = 'foxy.dbc_creature_spell_data';
  final String _spellTable = 'foxy.dbc_spell';

  Future<int> count({String? id, String? spell}) async {
    try {
      var builder = laconic.table('$_table AS dcsd');
      builder = builder.leftJoin(
        '$_spellTable AS ds_1',
        (join) => join.on('dcsd.Spells_1', 'ds_1.ID'),
      );
      builder = builder.leftJoin(
        '$_spellTable AS ds_2',
        (join) => join.on('dcsd.Spells_2', 'ds_2.ID'),
      );
      builder = builder.leftJoin(
        '$_spellTable AS ds_3',
        (join) => join.on('dcsd.Spells_3', 'ds_3.ID'),
      );
      builder = builder.leftJoin(
        '$_spellTable AS ds_4',
        (join) => join.on('dcsd.Spells_4', 'ds_4.ID'),
      );
      if (id != null && id.isNotEmpty) {
        builder = builder.where('dcsd.ID', id);
      }
      if (spell != null && spell.isNotEmpty) {
        builder = builder.whereAny(
          [
            'ds_1.Name_Lang_zhCN',
            'ds_2.Name_Lang_zhCN',
            'ds_3.Name_Lang_zhCN',
            'ds_4.Name_Lang_zhCN',
          ],
          '%$spell%',
          operator: 'like',
        );
      }
      return await builder.count();
    } catch (e) {
      // 表可能不存在
      return 0;
    }
  }

  Future<List<CreatureSpellData>> search({
    String? id,
    String? spell,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      const fields = [
        'dcsd.ID',
        'dcsd.Spells_1',
        'dcsd.Spells_2',
        'dcsd.Spells_3',
        'dcsd.Spells_4',
        'ds_1.Name_Lang_zhCN AS SpellName1',
        'ds_2.Name_Lang_zhCN AS SpellName2',
        'ds_3.Name_Lang_zhCN AS SpellName3',
        'ds_4.Name_Lang_zhCN AS SpellName4',
      ];
      var builder = laconic.table('$_table AS dcsd');
      builder = builder.select(fields);
      builder = builder.leftJoin(
        '$_spellTable AS ds_1',
        (join) => join.on('dcsd.Spells_1', 'ds_1.ID'),
      );
      builder = builder.leftJoin(
        '$_spellTable AS ds_2',
        (join) => join.on('dcsd.Spells_2', 'ds_2.ID'),
      );
      builder = builder.leftJoin(
        '$_spellTable AS ds_3',
        (join) => join.on('dcsd.Spells_3', 'ds_3.ID'),
      );
      builder = builder.leftJoin(
        '$_spellTable AS ds_4',
        (join) => join.on('dcsd.Spells_4', 'ds_4.ID'),
      );
      if (id != null && id.isNotEmpty) {
        builder = builder.where('dcsd.ID', id);
      }
      if (spell != null && spell.isNotEmpty) {
        builder = builder.whereAny(
          [
            'ds_1.Name_Lang_zhCN',
            'ds_2.Name_Lang_zhCN',
            'ds_3.Name_Lang_zhCN',
            'ds_4.Name_Lang_zhCN',
          ],
          '%$spell%',
          operator: 'like',
        );
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => CreatureSpellData.fromJson(e.toMap())).toList();
    } catch (e) {
      // 表可能不存在
      return [];
    }
  }

  Future<CreatureSpellData?> getById(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return CreatureSpellData.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }
}
