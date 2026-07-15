import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/entity/talent_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class TalentRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_talent';

  Future<List<BriefTalentEntity>> getBriefTalents({
    int page = 1,
    TalentFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'TabID',
      'TierID',
      'ColumnIndex',
      'SpellRank0',
    ]);
    builder = _applyFilter(builder, filter);
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows.map((row) => BriefTalentEntity.fromJson(row.toMap())).toList();
  }

  Future<List<TalentEntity>> getTalents() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => TalentEntity.fromJson(row.toMap())).toList();
  }

  Future<int> countTalents({TalentFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<TalentEntity?> getTalent(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : TalentEntity.fromJson(rows.first.toMap());
  }

  Future<TalentEntity> createTalent() async {
    return TalentEntity(id: await _getNextId());
  }

  Future<int> storeTalent(TalentEntity talent) async {
    final id = talent.id > 0 ? talent.id : await _getNextId();
    final stored = talent.copyWith(id: id);
    await _validateReferences(stored, preserveExisting: false);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateTalent(TalentEntity talent) async {
    await _validateReferences(talent, preserveExisting: true);
    final json = talent.toJson()..remove('ID');
    await laconic.table(_table).where('ID', talent.id).update(json);
  }

  Future<void> destroyTalent(int id) async {
    final dependent0 = await laconic
        .table(_table)
        .where('PrereqTalent0', id)
        .count();
    final dependent1 = await laconic
        .table(_table)
        .where('PrereqTalent1', id)
        .count();
    final dependent2 = await laconic
        .table(_table)
        .where('PrereqTalent2', id)
        .count();
    final characterReferences = await _countCharacterReferences(id);
    final references =
        dependent0 + dependent1 + dependent2 + characterReferences;
    if (references > 0) {
      throw StateError('天赋 $id 仍被 $references 条天赋或角色天赋数据引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyTalent(int id) async {
    final source = await getTalent(id);
    if (source == null) return;
    await storeTalent(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveTalent(TalentEntity talent) async {
    final existing = talent.id == 0 ? null : await getTalent(talent.id);
    if (existing == null) {
      await storeTalent(talent);
    } else {
      await updateTalent(talent);
    }
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('Talent ID 已超出 DBC int32 范围');
    }
    return id;
  }

  Future<void> _validateReferences(
    TalentEntity talent, {
    required bool preserveExisting,
  }) async {
    final existing = preserveExisting ? await getTalent(talent.id) : null;
    await _validateReference(
      table: 'foxy.dbc_talent_tab',
      value: talent.tabId,
      existingValue: existing?.tabId,
      field: 'TabID',
      target: '天赋页',
      allowZero: false,
    );
    await _validateSpellReference(
      talent.spellRank0,
      existing?.spellRank0,
      'SpellRank0',
      allowZero: false,
    );
    await _validateSpellReference(
      talent.spellRank1,
      existing?.spellRank1,
      'SpellRank1',
    );
    await _validateSpellReference(
      talent.spellRank2,
      existing?.spellRank2,
      'SpellRank2',
    );
    await _validateSpellReference(
      talent.spellRank3,
      existing?.spellRank3,
      'SpellRank3',
    );
    await _validateSpellReference(
      talent.spellRank4,
      existing?.spellRank4,
      'SpellRank4',
    );
    await _validateSpellReference(
      talent.spellRank5,
      existing?.spellRank5,
      'SpellRank5',
    );
    await _validateSpellReference(
      talent.spellRank6,
      existing?.spellRank6,
      'SpellRank6',
    );
    await _validateSpellReference(
      talent.spellRank7,
      existing?.spellRank7,
      'SpellRank7',
    );
    await _validateSpellReference(
      talent.spellRank8,
      existing?.spellRank8,
      'SpellRank8',
    );
    await _validateSpellReference(
      talent.requiredSpellId,
      existing?.requiredSpellId,
      'RequiredSpellID',
    );
    await _validatePrerequisite(
      talentId: talent.id,
      value: talent.prereqTalent0,
      rank: talent.prereqRank0,
      existingValue: existing?.prereqTalent0,
      existingRank: existing?.prereqRank0,
      field: 'PrereqTalent0',
    );
    await _validatePrerequisite(
      talentId: talent.id,
      value: talent.prereqTalent1,
      rank: talent.prereqRank1,
      existingValue: existing?.prereqTalent1,
      existingRank: existing?.prereqRank1,
      field: 'PrereqTalent1',
    );
    await _validatePrerequisite(
      talentId: talent.id,
      value: talent.prereqTalent2,
      rank: talent.prereqRank2,
      existingValue: existing?.prereqTalent2,
      existingRank: existing?.prereqRank2,
      field: 'PrereqTalent2',
    );
  }

  Future<void> _validateSpellReference(
    int value,
    int? existingValue,
    String field, {
    bool allowZero = true,
  }) {
    return _validateReference(
      table: 'foxy.dbc_spell',
      value: value,
      existingValue: existingValue,
      field: field,
      target: '法术',
      allowZero: allowZero,
    );
  }

  Future<void> _validateReference({
    required String table,
    required int value,
    required int? existingValue,
    required String field,
    required String target,
    required bool allowZero,
  }) async {
    if (value == 0) {
      if (allowZero || existingValue == 0) return;
      throw StateError('$field 必须引用存在的$target');
    }
    final references = await laconic.table(table).where('ID', value).count();
    if (references > 0 || existingValue == value) return;
    throw StateError('$field 引用的$target $value 不存在');
  }

  Future<void> _validatePrerequisite({
    required int talentId,
    required int value,
    required int rank,
    required int? existingValue,
    required int? existingRank,
    required String field,
  }) async {
    final unchanged = existingValue == value && existingRank == rank;
    if (value == 0) {
      if (rank == 0 || unchanged) return;
      throw StateError('$field 为 0 时对应的前置等级也必须为 0');
    }
    if (value == talentId) {
      throw StateError('$field 不能引用当前天赋自身');
    }
    final prerequisite = await getTalent(value);
    if (prerequisite == null) {
      if (unchanged) return;
      throw StateError('$field 引用的前置天赋 $value 不存在');
    }
    if (!_hasRank(prerequisite, rank)) {
      if (unchanged) return;
      throw StateError('$field 引用的前置天赋 $value 不存在第 ${rank + 1} 级法术');
    }
  }

  bool _hasRank(TalentEntity talent, int rank) {
    return switch (rank) {
      0 => talent.spellRank0 != 0,
      1 => talent.spellRank1 != 0,
      2 => talent.spellRank2 != 0,
      3 => talent.spellRank3 != 0,
      4 => talent.spellRank4 != 0,
      5 => talent.spellRank5 != 0,
      6 => talent.spellRank6 != 0,
      7 => talent.spellRank7 != 0,
      8 => talent.spellRank8 != 0,
      _ => false,
    };
  }

  Future<int> _countCharacterReferences(int id) async {
    final talent = await getTalent(id);
    if (talent == null) return 0;
    final schemas = await laconic.select('''
SELECT DISTINCT TABLE_SCHEMA
FROM information_schema.COLUMNS
WHERE TABLE_NAME = 'character_talent'
  AND COLUMN_NAME IN ('guid', 'spell', 'specMask')
GROUP BY TABLE_SCHEMA
HAVING COUNT(DISTINCT COLUMN_NAME) = 3
''');
    var references = 0;
    for (final row in schemas) {
      final schema = row['TABLE_SCHEMA'] as String;
      if (!RegExp(r'^[0-9A-Za-z_$]+$').hasMatch(schema)) continue;
      references += await laconic.table('$schema.character_talent').whereNested(
        (query) {
          query.where('spell', talent.spellRank0);
          if (talent.spellRank1 != 0) {
            query.orWhere('spell', talent.spellRank1);
          }
          if (talent.spellRank2 != 0) {
            query.orWhere('spell', talent.spellRank2);
          }
          if (talent.spellRank3 != 0) {
            query.orWhere('spell', talent.spellRank3);
          }
          if (talent.spellRank4 != 0) {
            query.orWhere('spell', talent.spellRank4);
          }
        },
      ).count();
    }
    return references;
  }

  QueryBuilder _applyFilter(QueryBuilder builder, TalentFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.spell.isNotEmpty) {
      builder = builder.whereNested(
        (query) => query
            .where('SpellRank0', filter.spell)
            .orWhere('SpellRank1', filter.spell)
            .orWhere('SpellRank2', filter.spell)
            .orWhere('SpellRank3', filter.spell)
            .orWhere('SpellRank4', filter.spell)
            .orWhere('SpellRank5', filter.spell)
            .orWhere('SpellRank6', filter.spell)
            .orWhere('SpellRank7', filter.spell)
            .orWhere('SpellRank8', filter.spell),
      );
    }
    return builder;
  }
}
