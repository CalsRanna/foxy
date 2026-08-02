// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_spell_repository.dart';

mixin _CreatureTemplateSpellRepositoryMixin on RepositoryMixin {
  Future<CreatureTemplateSpellKey> copyCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    final source = await getCreatureTemplateSpell(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureTemplateSpell(source.creatureID);
    final copied = source.copyWith(
      creatureID: blank.creatureID,
      index: blank.index,
    );
    await storeCreatureTemplateSpell(copied);
    return CreatureTemplateSpellKey.fromEntity(copied);
  }

  Future<int> countCreatureTemplateSpells(int creatureID) async {
    return laconic
        .table('creature_template_spell')
        .where('`CreatureID`', creatureID)
        .count();
  }

  Future<CreatureTemplateSpellEntity> createCreatureTemplateSpell(
    int creatureID,
  ) async {
    return CreatureTemplateSpellEntity(
      creatureID: creatureID,
      index: await nextMaxPlusOne(
        'creature_template_spell',
        '`Index`',
        where: {'CreatureID': creatureID},
      ),
    );
  }

  Future<void> destroyCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_template_spell'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureTemplateSpellEntity?> getCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_template_spell'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateSpellEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefCreatureTemplateSpellEntity>> getBriefCreatureTemplateSpells(
    int creatureID, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('creature_template_spell').select([
      '`CreatureID`',
      '`Index`',
      '`Spell`',
      '`VerifiedBuild`',
    ]);
    builder = builder.where('`CreatureID`', creatureID);
    builder = builder.orderBy('`CreatureID`').orderBy('`Index`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureTemplateSpellEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureTemplateSpell(
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {
    await _beforeStore(creatureTemplateSpell);
    final json = prepareWriteJson(creatureTemplateSpell.toJson());
    try {
      await laconic.table('creature_template_spell').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplateSpell(
    CreatureTemplateSpellKey originalKey,
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplateSpell);
    final json = prepareWriteJson(creatureTemplateSpell.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_template_spell'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<void> _beforeDestroy(CreatureTemplateSpellKey key) async {}

  Future<void> _beforeStore(
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureTemplateSpellKey originalKey,
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureTemplateSpellKey key) {
    var query = builder;
    query = query.where('`CreatureID`', key.creatureID);
    query = query.where('`Index`', key.index);
    return query;
  }
}
