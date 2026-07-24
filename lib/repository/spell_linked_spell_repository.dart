import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellLinkedSpellRepository with RepositoryMixin {
  static const _table = 'spell_linked_spell';

  Future<SpellLinkedSpellKey> copySpellLinkedSpell(
    SpellLinkedSpellKey key,
  ) async {
    final source = await getSpellLinkedSpell(key);
    if (source == null) {
      throw StateError('原链接法术不存在，可能已被其他操作修改或删除');
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
      throw StateError('该触发法术与效果法术已使用全部链接类型');
    }
    final copied = source.copyWith(type: availableTypes.first);
    await storeSpellLinkedSpell(copied);
    return SpellLinkedSpellKey.fromEntity(copied);
  }

  Future<int> countSpellLinkedSpells(int spellTrigger) {
    return _whereParent(laconic.table(_table), spellTrigger).count();
  }

  Future<SpellLinkedSpellEntity> createSpellLinkedSpell(
    int spellTrigger,
  ) async {
    return SpellLinkedSpellEntity(spellTrigger: spellTrigger);
  }

  Future<void> destroySpellLinkedSpell(SpellLinkedSpellKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原链接法术不存在，可能已被其他操作修改或删除');
    }
  }

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

  Future<SpellLinkedSpellEntity?> getSpellLinkedSpell(
    SpellLinkedSpellKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellLinkedSpellEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellLinkedSpell(SpellLinkedSpellEntity data) async {
    try {
      await laconic.table(_table).insert([data.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同触发法术、效果法术和类型的链接记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellLinkedSpell(
    SpellLinkedSpellKey originalKey,
    SpellLinkedSpellEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(data.toJson());
      if (matchedRows == 0) {
        throw StateError('原链接法术不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的触发法术、效果法术和类型组合已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellLinkedSpellKey key) {
    return builder
        .where('spell_trigger', key.spellTrigger)
        .where('spell_effect', key.spellEffect)
        .where('type', key.type);
  }

  QueryBuilder _whereParent(QueryBuilder builder, int spellTrigger) {
    return builder
        .where('spell_trigger', spellTrigger)
        .orWhere('spell_trigger', -spellTrigger);
  }
}
