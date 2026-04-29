import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellLinkedSpellRepository with RepositoryMixin {
  static const _table = 'spell_linked_spell';

  Future<List<SpellLinkedSpellEntity>> getSpellLinkedSpells(
    int spellTrigger,
  ) async {
    try {
      var results = await laconic
          .table(_table)
          .where('spell_trigger', spellTrigger)
          .orWhere('spell_trigger', -spellTrigger)
          .get();
      return results
          .map((e) => SpellLinkedSpellEntity.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<SpellLinkedSpellEntity?> getSpellLinkedSpell(
    int spellTrigger,
    int spellEffect,
  ) async {
    try {
      var result = await laconic
          .table(_table)
          .where('spell_trigger', spellTrigger)
          .where('spell_effect', spellEffect)
          .first();
      return SpellLinkedSpellEntity.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeSpellLinkedSpell(SpellLinkedSpellEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellLinkedSpell(
    SpellLinkedSpellEntity oldData,
    SpellLinkedSpellEntity newData,
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

  Future<SpellLinkedSpellEntity> copySpellLinkedSpell(
    SpellLinkedSpellEntity data,
  ) async {
    var json = data.toJson();
    var maxEffectResult = await laconic.table(_table).select([
      'MAX(spell_effect) AS maxEffect',
    ]).first();
    var maxEffect = (maxEffectResult.toMap()['maxEffect'] ?? 0) as int;
    json['spell_effect'] = maxEffect + 1;
    await laconic.table(_table).insert([json]);
    return SpellLinkedSpellEntity.fromJson(json);
  }
}
