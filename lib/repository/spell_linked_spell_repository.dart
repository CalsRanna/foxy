import 'package:foxy/model/spell_linked_spell.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellLinkedSpellRepository with RepositoryMixin {
  static const _table = 'spell_linked_spell';

  Future<List<SpellLinkedSpell>> getSpellLinkedSpells(int spellTrigger) async {
    try {
      var results = await laconic
          .table(_table)
          .where('spell_trigger', spellTrigger)
          .orWhere('spell_trigger', -spellTrigger)
          .get();
      return results.map((e) => SpellLinkedSpell.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<SpellLinkedSpell?> getSpellLinkedSpell(int spellTrigger, int spellEffect) async {
    try {
      var result = await laconic
          .table(_table)
          .where('spell_trigger', spellTrigger)
          .where('spell_effect', spellEffect)
          .first();
      return SpellLinkedSpell.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeSpellLinkedSpell(SpellLinkedSpell data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellLinkedSpell(
    SpellLinkedSpell oldData,
    SpellLinkedSpell newData,
  ) async {
    var json = newData.toJson();
    json.remove('spell_trigger');
    json.remove('spell_effect');
    await laconic
        .table(_table)
        .where('spell_trigger', oldData.spellTrigger)
        .where('spell_effect', oldData.spellEffect)
        .update(json);
  }

  Future<void> destroySpellLinkedSpell(int spellTrigger, int spellEffect) async {
    await laconic
        .table(_table)
        .where('spell_trigger', spellTrigger)
        .where('spell_effect', spellEffect)
        .delete();
  }

  Future<SpellLinkedSpell> copySpellLinkedSpell(SpellLinkedSpell data) async {
    var json = data.toJson();
    var maxEffectResult = await laconic.table(_table).select([
      'MAX(spell_effect) AS maxEffect',
    ]).first();
    var maxEffect = (maxEffectResult.toMap()['maxEffect'] ?? 0) as int;
    json['spell_effect'] = maxEffect + 1;
    await laconic.table(_table).insert([json]);
    return SpellLinkedSpell.fromJson(json);
  }
}
