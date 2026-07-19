import 'package:foxy/entity/brief_creature_template_spell_entity.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/entity/creature_template_spell_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureTemplateSpellRepository with RepositoryMixin {
  static const _table = 'creature_template_spell';
  static const maxIndex = 7;
  static const minIndex = 0;
  static const primaryKeyColumns = {'CreatureID', 'Index'};

  Future<CreatureTemplateSpellKey> copyCreatureTemplateSpell(
    CreatureTemplateSpellKey sourceKey,
  ) async {
    final source = await getCreatureTemplateSpell(sourceKey);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureTemplateSpell(source.creatureID);
    final candidate = source.copyWith(index: blank.index);
    await storeCreatureTemplateSpell(candidate);
    return CreatureTemplateSpellKey.fromEntity(candidate);
  }

  Future<int> countCreatureTemplateSpells(int creatureID) {
    return laconic.table(_table).where('CreatureID', creatureID).count();
  }

  Future<CreatureTemplateSpellEntity> createCreatureTemplateSpell(
    int creatureID,
  ) async {
    return CreatureTemplateSpellEntity(
      creatureID: creatureID,
      index: await getNextIndex(creatureID),
    );
  }

  Future<void> destroyCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureTemplateSpellEntity>> getBriefCreatureTemplateSpells(
    int creatureID, {
    int page = 1,
  }) async {
    final results = await laconic
        .table('$_table AS cts')
        .select([
          'cts.CreatureID',
          'cts.`Index`',
          'cts.Spell',
          'cts.VerifiedBuild',
          'ds.Name_lang_zhCN AS spellName',
          'ds.NameSubtext_lang_zhCN AS spellSubtext',
        ])
        .leftJoin(
          'foxy.dbc_spell AS ds',
          (join) => join.on('cts.Spell', 'ds.ID'),
        )
        .where('cts.CreatureID', creatureID)
        .orderBy('cts.CreatureID')
        .orderBy('cts.`Index`')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (result) => BriefCreatureTemplateSpellEntity.fromJson(result.toMap()),
        )
        .toList();
  }

  Future<CreatureTemplateSpellEntity?> getCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateSpellEntity.fromJson(results.first.toMap());
  }

  Future<int> getNextIndex(int creatureID) async {
    final results = await laconic
        .table(_table)
        .select(['`Index`'])
        .where('CreatureID', creatureID)
        .get();
    return nextAvailableIndex(
      results.map((result) => (result.toMap()['Index'] as num).toInt()),
    );
  }

  Future<void> storeCreatureTemplateSpell(
    CreatureTemplateSpellEntity spell,
  ) async {
    try {
      await laconic.table(_table).insert([_writeJson(spell)]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物技能主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplateSpell(
    CreatureTemplateSpellKey originalKey,
    CreatureTemplateSpellEntity spell,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(_writeJson(spell));
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物技能主键已存在，无法保存');
      }
      rethrow;
    }
  }

  static int nextAvailableIndex(Iterable<int> usedIndexes) {
    final used = usedIndexes.toSet();
    for (var index = minIndex; index <= maxIndex; index++) {
      if (!used.contains(index)) return index;
    }
    throw StateError('生物技能槽已满，只允许 $minIndex-$maxIndex');
  }

  QueryBuilder _whereKey(QueryBuilder builder, CreatureTemplateSpellKey key) {
    return builder
        .where('CreatureID', key.creatureID)
        .where('`Index`', key.index);
  }

  Map<String, dynamic> _writeJson(CreatureTemplateSpellEntity spell) {
    final json = spell.toJson();
    json['`Index`'] = json.remove('Index');
    return json;
  }
}
