import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellGroupRepository with RepositoryMixin {
  static const _table = 'spell_group';

  Future<List<SpellGroupEntity>> getSpellGroups(int spellId) async {
    try {
      var builder = laconic.table('$_table AS sg');
      const fields = [
        'sg.*',
        'sgsr.stack_rule as stack_rule',
        'sgsr.description as description',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'spell_group_stack_rules AS sgsr',
        (join) => join.on('sg.id', 'sgsr.group_id'),
      );
      builder = builder.where('sg.spell_id', spellId);
      var results = await builder.get();
      return results.map((e) => SpellGroupEntity.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<SpellGroupEntity?> getSpellGroup(int id, int spellId) async {
    try {
      var result = await laconic
          .table(_table)
          .where('id', id)
          .where('spell_id', spellId)
          .first();
      return SpellGroupEntity.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeSpellGroup(SpellGroupEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellGroup(
    SpellGroupEntity oldData,
    SpellGroupEntity newData,
  ) async {
    var json = newData.toJson();
    json.remove('id');
    json.remove('spell_id');
    await laconic
        .table(_table)
        .where('id', oldData.id)
        .where('spell_id', oldData.spellId)
        .update(json);
  }

  Future<void> destroySpellGroup(int id, int spellId) async {
    await laconic
        .table(_table)
        .where('id', id)
        .where('spell_id', spellId)
        .delete();
  }

  Future<SpellGroupEntity> copySpellGroup(SpellGroupEntity data) async {
    var json = data.toJson();
    var maxIdResult = await laconic.table(_table).select([
      'MAX(id) AS maxId',
    ]).first();
    var maxId = (maxIdResult.toMap()['maxId'] ?? 0) as int;
    json['id'] = maxId + 1;
    await laconic.table(_table).insert([json]);
    return SpellGroupEntity.fromJson(json);
  }

  Future<int> getNextId() async {
    var maxResult = await laconic.table(_table).select([
      'MAX(id) AS maxId',
    ]).first();
    var maxId = (maxResult.toMap()['maxId'] ?? 0) as int;
    return maxId + 1;
  }
}
