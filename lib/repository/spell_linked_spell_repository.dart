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
    int type,
  ) async {
    var results = await laconic
        .table(_table)
        .where('spell_trigger', spellTrigger)
        .where('spell_effect', spellEffect)
        .where('type', type)
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
    data.validate();
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellLinkedSpell(
    int spellTrigger,
    int spellEffect,
    int type,
    SpellLinkedSpellEntity data,
  ) async {
    data.validate();
    await laconic
        .table(_table)
        .where('spell_trigger', spellTrigger)
        .where('spell_effect', spellEffect)
        .where('type', type)
        .update(data.toJson());
  }

  Future<void> destroySpellLinkedSpell(
    int spellTrigger,
    int spellEffect,
    int type,
  ) async {
    await laconic
        .table(_table)
        .where('spell_trigger', spellTrigger)
        .where('spell_effect', spellEffect)
        .where('type', type)
        .delete();
  }

  Future<void> copySpellLinkedSpell(
    int spellTrigger,
    int spellEffect,
    int type,
  ) async {
    var source = await getSpellLinkedSpell(spellTrigger, spellEffect, type);
    if (source == null) return;
    final availableTypes = {0, 1, 2}..remove(type);
    for (final candidate in List<int>.from(availableTypes)) {
      if (await getSpellLinkedSpell(spellTrigger, spellEffect, candidate) !=
          null) {
        availableTypes.remove(candidate);
      }
    }
    if (availableTypes.isEmpty) {
      throw StateError('该触发法术与效果法术已使用全部链接类型');
    }
    var json = source.toJson();
    json['type'] = availableTypes.first;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellLinkedSpell(SpellLinkedSpellEntity data) async {
    var existing = await getSpellLinkedSpell(
      data.spellTrigger,
      data.spellEffect,
      data.type,
    );
    if (existing != null) {
      await updateSpellLinkedSpell(
        data.spellTrigger,
        data.spellEffect,
        data.type,
        data,
      );
    } else {
      await storeSpellLinkedSpell(data);
    }
  }
}
