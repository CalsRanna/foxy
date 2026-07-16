import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/achievement_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class AchievementRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_achievement';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copyAchievement(int id) async {
    var source = await getAchievement(id);
    if (source == null) return;
    await storeAchievement(source.copyWith(id: await _getNextId()));
  }

  Future<int> countAchievements({AchievementFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<AchievementEntity> createAchievement() async {
    return AchievementEntity(id: await _getNextId());
  }

  Future<void> destroyAchievement(int id) async {
    final supercedesCount = await laconic
        .table(_table)
        .where('Supercedes', id)
        .count();
    final sharesCount = await laconic
        .table(_table)
        .where('Shares_criteria', id)
        .count();
    final criteriaCount = await _tableExists('foxy', 'dbc_achievement_criteria')
        ? await laconic
              .table('foxy.dbc_achievement_criteria')
              .where('Achievement_ID', id)
              .count()
        : 0;
    final rewardCount = await laconic
        .table('achievement_reward')
        .where('ID', id)
        .count();
    final completionCount = await laconic
        .table('acore_characters.character_achievement')
        .where('achievement', id)
        .count();
    final references =
        supercedesCount +
        sharesCount +
        criteriaCount +
        rewardCount +
        completionCount;
    if (references > 0) {
      throw StateError(
        '成就 $id 仍被前置成就 $supercedesCount 条、共享条件 $sharesCount 条、'
        '成就条件 $criteriaCount 条、奖励 $rewardCount 条、角色完成记录 '
        '$completionCount 条引用，不能删除',
      );
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<AchievementEntity?> getAchievement(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return AchievementEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getAchievementLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<AchievementEntity>> getAchievements() async {
    var results = await laconic.table(_table).orderBy('ID').get();
    return results.map((e) => AchievementEntity.fromJson(e.toMap())).toList();
  }

  Future<List<BriefAchievementEntity>> getBriefAchievements({
    int page = 1,
    AchievementFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Title_lang_zhCN',
      'Description_lang_zhCN',
      'Reward_lang_zhCN',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefAchievementEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveAchievement(AchievementEntity achievement) async {
    if (achievement.id == 0 || await getAchievement(achievement.id) == null) {
      await storeAchievement(achievement);
      return;
    }
    await updateAchievement(achievement);
  }

  Future<void> saveAchievementLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeAchievement(AchievementEntity achievement) async {
    final stored = achievement.id > 0
        ? achievement
        : achievement.copyWith(id: await _getNextId());
    await _validateReferences(stored, null);
    await laconic.table(_table).insert([stored.toJson()]);
    return stored.id;
  }

  Future<void> updateAchievement(AchievementEntity achievement) async {
    final existing = await getAchievement(achievement.id);
    if (existing == null) throw StateError('成就 ${achievement.id} 不存在');
    await _validateReferences(achievement, existing);
    var json = achievement.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', achievement.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    AchievementFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.title.isNotEmpty) {
      builder = builder.where(
        'Title_lang_zhCN',
        '%${filter.title}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0xffff) {
      throw StateError('Achievement.dbc 已无可用 smallint unsigned ID');
    }
    return id;
  }

  Future<bool> _tableExists(String schema, String table) async {
    final rows = await laconic
        .table('information_schema.TABLES')
        .where('TABLE_SCHEMA', schema)
        .where('TABLE_NAME', table)
        .limit(1)
        .get();
    return rows.isNotEmpty;
  }

  Future<void> _validateNoCycle(String field, int id, int first) async {
    var current = first;
    final visited = <int>{id};
    while (current != 0) {
      if (!visited.add(current)) {
        throw ArgumentError('$field 形成循环引用');
      }
      final rows = await laconic
          .table(_table)
          .select([field])
          .where('ID', current)
          .limit(1)
          .get();
      if (rows.isEmpty) return;
      current = rows.first.toMap()[field] as int? ?? 0;
    }
  }

  Future<void> _validateReference({
    required String table,
    required String schema,
    required String shortTable,
    required String column,
    required int value,
    required int? existingValue,
    required int? sentinel,
    required String field,
    required String target,
    bool requireImportedTable = false,
  }) async {
    if (sentinel != null && value == sentinel) return;
    if (existingValue == value) return;
    if (!await _tableExists(schema, shortTable)) {
      if (requireImportedTable) {
        throw StateError('缺少 $table，请重新导入 required DBC 后再保存');
      }
      return;
    }
    final count = await laconic.table(table).where(column, value).count();
    if (count == 0) {
      throw ArgumentError.value(value, field, '引用的$target不存在');
    }
  }

  Future<void> _validateReferences(
    AchievementEntity changed,
    AchievementEntity? existing,
  ) async {
    await _validateReference(
      table: 'foxy.dbc_map',
      schema: 'foxy',
      shortTable: 'dbc_map',
      column: 'ID',
      value: changed.instanceId,
      existingValue: existing?.instanceId,
      sentinel: -1,
      field: 'Instance_ID',
      target: '地图',
    );
    await _validateReference(
      table: _table,
      schema: 'foxy',
      shortTable: 'dbc_achievement',
      column: 'ID',
      value: changed.supercedes,
      existingValue: existing?.supercedes,
      sentinel: 0,
      field: 'Supercedes',
      target: '前置成就',
    );
    await _validateReference(
      table: 'foxy.dbc_achievement_category',
      schema: 'foxy',
      shortTable: 'dbc_achievement_category',
      column: 'ID',
      value: changed.category,
      existingValue: existing?.category,
      sentinel: null,
      field: 'Category',
      target: '成就分类',
      requireImportedTable: true,
    );
    await _validateReference(
      table: 'foxy.dbc_spell_icon',
      schema: 'foxy',
      shortTable: 'dbc_spell_icon',
      column: 'ID',
      value: changed.iconId,
      existingValue: existing?.iconId,
      sentinel: 0,
      field: 'IconID',
      target: '技能图标',
    );
    await _validateReference(
      table: _table,
      schema: 'foxy',
      shortTable: 'dbc_achievement',
      column: 'ID',
      value: changed.sharesCriteria,
      existingValue: existing?.sharesCriteria,
      sentinel: 0,
      field: 'Shares_criteria',
      target: '共享条件成就',
    );
    await _validateNoCycle('Supercedes', changed.id, changed.supercedes);
    await _validateNoCycle(
      'Shares_criteria',
      changed.id,
      changed.sharesCriteria,
    );
    if (await _tableExists('foxy', 'dbc_achievement_criteria')) {
      final criteriaSource = changed.sharesCriteria == 0
          ? changed.id
          : changed.sharesCriteria;
      final criteriaCount = await laconic
          .table('foxy.dbc_achievement_criteria')
          .where('Achievement_ID', criteriaSource)
          .count();
      if (changed.minimumCriteria > criteriaCount) {
        throw ArgumentError.value(
          changed.minimumCriteria,
          'Minimum_criteria',
          '超过条件来源成就 $criteriaSource 的条件数量 $criteriaCount',
        );
      }
    }
  }
}
