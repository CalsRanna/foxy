import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellLinkedSpellRepository with RepositoryMixin {
  static const _table = 'spell_linked_spell';

  Future<List<SpellLinkedSpellEntity>> getBriefSpellLinkedSpells(
    int spellTrigger,
  ) async {
    var results = await laconic
        .table(_table)
        .where('spell_trigger', spellTrigger)
        .orWhere('spell_trigger', -spellTrigger)
        .get();
    return results
        .map((e) => SpellLinkedSpellEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SpellLinkedSpellEntity?> getSpellLinkedSpell(
    int spellTrigger,
    int spellEffect,
  ) async {
    var results = await laconic
        .table(_table)
        .where('spell_trigger', spellTrigger)
        .where('spell_effect', spellEffect)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SpellLinkedSpellEntity.fromJson(results.first.toMap());
  }

  Future<SpellLinkedSpellEntity> createSpellLinkedSpell(
    int spellTrigger,
  ) async {
    return SpellLinkedSpellEntity(spellTrigger: spellTrigger);
  }

  Future<void> storeSpellLinkedSpell(SpellLinkedSpellEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellLinkedSpell(
    int spellTrigger,
    int spellEffect,
    SpellLinkedSpellEntity data,
  ) async {
    var json = data.toJson();
    json.remove('spell_trigger');
    json.remove('spell_effect');
    await laconic
        .table(_table)
        .where('spell_trigger', spellTrigger)
        .where('spell_effect', spellEffect)
        .update(json);
  }

  Future<void> destroySpellLinkedSpell(
    int spellTrigger,
    int spellEffect,
  ) async {
    await laconic
        .table(_table)
        .where('spell_trigger', spellTrigger)
        .where('spell_effect', spellEffect)
        .delete();
  }

  Future<void> copySpellLinkedSpell(int spellTrigger, int spellEffect) async {
    var source = await getSpellLinkedSpell(spellTrigger, spellEffect);
    if (source == null) return;
    var json = source.toJson();
    var maxEffectResult = await laconic.table(_table).select([
      'MAX(spell_effect) AS maxEffect',
    ]).first();
    var maxEffect = (maxEffectResult.toMap()['maxEffect'] ?? 0) as int;
    json['spell_effect'] = maxEffect + 1;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellLinkedSpell(SpellLinkedSpellEntity data) async {
    var existing = await getSpellLinkedSpell(
      data.spellTrigger,
      data.spellEffect,
    );
    if (existing != null) {
      await updateSpellLinkedSpell(data.spellTrigger, data.spellEffect, data);
    } else {
      await storeSpellLinkedSpell(data);
    }
  }
}
