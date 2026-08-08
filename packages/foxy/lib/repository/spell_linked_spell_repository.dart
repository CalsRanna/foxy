import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_linked_spell_repository.g.dart';

@FoxyRepository(linkKey: ['spellTrigger'])
class SpellLinkedSpellRepository
    with RepositoryMixin, _SpellLinkedSpellRepositoryMixin {

  @override
  Future<SpellLinkedSpellKey> copySpellLinkedSpell(
    SpellLinkedSpellKey key,
  ) async {
    final source = await getSpellLinkedSpell(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final availableTypes = {0, 1, 2}..remove(key.type);
    for (final type in List<int>.from(availableTypes)) {
      final candidateKey = SpellLinkedSpellKey(
        spellTrigger: key.spellTrigger,
        spellEffect: key.spellEffect,
        type: type,
      );
      if (await getSpellLinkedSpell(candidateKey) != null) {
        availableTypes.remove(type);
      }
    }
    if (availableTypes.isEmpty) {
      throw ValidationException(
        'all link types are already used between the trigger and effect spells',
      );
    }
    final copied = source.copyWith(type: availableTypes.first);
    await storeSpellLinkedSpell(copied);
    return SpellLinkedSpellKey.fromEntity(copied);
  }

  @override
  Future<int> countSpellLinkedSpells(int spellTrigger) {
    return _whereParent(laconic.table(_table), spellTrigger).count();
  }

  @override
  Future<SpellLinkedSpellEntity> createSpellLinkedSpell(
    int spellTrigger,
  ) async {
    return SpellLinkedSpellEntity(spellTrigger: spellTrigger);
  }

  @override
  Future<List<BriefSpellLinkedSpellEntity>> getBriefSpellLinkedSpells(
    int spellTrigger, {
    int page = 1,
  }) async {
    final results = await _whereParent(laconic.table(_table), spellTrigger)
        .select(['spell_trigger', 'spell_effect', 'type', 'comment'])
        .orderBy('spell_trigger')
        .orderBy('spell_effect')
        .orderBy('type')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellLinkedSpellEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _whereParent(QueryBuilder builder, int spellTrigger) {
    return builder
        .where('spell_trigger', spellTrigger)
        .orWhere('spell_trigger', -spellTrigger);
  }
}
