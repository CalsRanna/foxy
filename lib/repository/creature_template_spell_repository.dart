import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateSpellRepository with RepositoryMixin {
  static const _table = 'creature_template_spell';

  Future<List<CreatureTemplateSpellEntity>> getBriefCreatureTemplateSpells(
    int creatureID,
  ) async {
    var builder = laconic.table('$_table AS cts');
    const fields = [
      'cts.*',
      'ds.Name_lang_zhCN as spellName',
      'ds.NameSubtext_lang_zhCN as spellSubtext',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell AS ds',
      (join) => join.on('cts.Spell', 'ds.ID'),
    );
    builder = builder.where('cts.CreatureID', creatureID);
    builder = builder.orderBy('cts.`Index`');
    var results = await builder.get();
    return results
        .map((e) => CreatureTemplateSpellEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureTemplateSpellEntity?> getCreatureTemplateSpell(
    int creatureID,
    int index,
  ) async {
    var results = await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('`Index`', index)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureTemplateSpellEntity.fromJson(results.first.toMap());
  }

  Future<CreatureTemplateSpellEntity> createCreatureTemplateSpell(
    int creatureID,
  ) async {
    var nextIndex = await getNextIndex(creatureID);
    return CreatureTemplateSpellEntity(
      creatureID: creatureID,
      index: nextIndex,
    );
  }

  Future<void> storeCreatureTemplateSpell(
    CreatureTemplateSpellEntity spell,
  ) async {
    var json = spell.toJson();
    json['`Index`'] = json.remove('Index');
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateCreatureTemplateSpell(
    CreatureTemplateSpellEntity spell,
  ) async {
    var json = spell.toJson();
    json.remove('CreatureID');
    json['`Index`'] = json.remove('Index');
    await laconic
        .table(_table)
        .where('CreatureID', spell.creatureID)
        .where('`Index`', spell.index)
        .update(json);
  }

  Future<void> destroyCreatureTemplateSpell(int creatureID, int index) async {
    await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('`Index`', index)
        .delete();
  }

  Future<void> copyCreatureTemplateSpell(int creatureID, int index) async {
    var source = await getCreatureTemplateSpell(creatureID, index);
    if (source == null) return;
    var nextIndex = await getNextIndex(creatureID);
    var json = source.toJson();
    json['Index'] = nextIndex;
    json['`Index`'] = json.remove('Index');
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureTemplateSpell(
    CreatureTemplateSpellEntity spell,
  ) async {
    var existing = await getCreatureTemplateSpell(
      spell.creatureID,
      spell.index,
    );
    if (existing != null) {
      await updateCreatureTemplateSpell(spell);
    } else {
      await storeCreatureTemplateSpell(spell);
    }
  }

  Future<int> getNextIndex(int creatureID) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(`Index`) AS maxIndex'])
        .where('CreatureID', creatureID)
        .first();
    var maxIndex = (maxResult.toMap()['maxIndex'] ?? 0) as int;
    return maxIndex + 1;
  }
}