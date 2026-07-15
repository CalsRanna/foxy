import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellGroupRepository with RepositoryMixin {
  static const _table = 'spell_group';

  Future<List<SpellGroupEntity>> getBriefSpellGroups(int spellId) async {
    var results = await laconic
        .table(_table)
        .where('spell_id', spellId)
        .orderBy('id')
        .get();
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
    var nextId = await _getNextId();
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
    await laconic
        .table(_table)
        .where('id', id)
        .where('spell_id', spellId)
        .update(data.toJson());
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
    json['id'] = await _getNextId();
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

  Future<int> _getNextId() async {
    var maxResult = await laconic.table(_table).select([
      'MAX(id) AS maxId',
    ]).first();
    var maxId = (maxResult.toMap()['maxId'] ?? 0) as int;
    return maxId + 1;
  }
}
