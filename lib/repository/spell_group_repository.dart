import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellGroupRepository with RepositoryMixin {
  static const _table = 'spell_group';

  Future<List<SpellGroupEntity>> getBriefSpellGroups(int spellId) async {
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
  }

  Future<SpellGroupEntity?> getSpellGroup(int id, int spellId) async {
    var results = await laconic
        .table(_table)
        .where('id', id)
        .where('spell_id', spellId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SpellGroupEntity.fromJson(results.first.toMap());
  }

  Future<SpellGroupEntity> createSpellGroup(int spellId) async {
    var nextId = await getNextId();
    return SpellGroupEntity(id: nextId, spellId: spellId);
  }

  Future<void> storeSpellGroup(SpellGroupEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellGroup(
    int id,
    int spellId,
    SpellGroupEntity data,
  ) async {
    var json = data.toJson();
    json.remove('id');
    json.remove('spell_id');
    await laconic
        .table(_table)
        .where('id', id)
        .where('spell_id', spellId)
        .update(json);
  }

  Future<void> destroySpellGroup(int id, int spellId) async {
    await laconic
        .table(_table)
        .where('id', id)
        .where('spell_id', spellId)
        .delete();
  }

  Future<void> copySpellGroup(int id, int spellId) async {
    var source = await getSpellGroup(id, spellId);
    if (source == null) return;
    var json = source.toJson();
    json['id'] = await getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellGroup(SpellGroupEntity data) async {
    var existing = await getSpellGroup(data.id, data.spellId);
    if (existing != null) {
      await updateSpellGroup(data.id, data.spellId, data);
    } else {
      await storeSpellGroup(data);
    }
  }

  Future<int> getNextId() async {
    var maxResult = await laconic.table(_table).select([
      'MAX(id) AS maxId',
    ]).first();
    var maxId = (maxResult.toMap()['maxId'] ?? 0) as int;
    return maxId + 1;
  }
}