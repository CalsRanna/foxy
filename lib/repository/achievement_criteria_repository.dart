import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'package:foxy/entity/achievement_criteria_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class AchievementCriteriaRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_achievement_criteria';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copyAchievementCriterion(int id) async {
    final source = await getAchievementCriterion(id);
    if (source == null) return;
    await storeAchievementCriterion(source.copyWith(id: await _getNextId()));
  }

  Future<int> countAchievementCriteria({
    AchievementCriteriaFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<AchievementCriteriaEntity> createAchievementCriterion() async {
    return AchievementCriteriaEntity(id: await _getNextId());
  }

  Future<void> destroyAchievementCriterion(int id) async {
    final progressCount = await laconic
        .table('acore_characters.character_achievement_progress')
        .where('criteria', id)
        .count();
    if (progressCount > 0) {
      throw StateError('成就条件 $id 仍有 $progressCount 条角色进度，不能删除');
    }
    final dataCount = await laconic
        .table('achievement_criteria_data')
        .where('criteria_id', id)
        .count();
    if (dataCount > 0) {
      throw StateError('成就条件 $id 仍有 $dataCount 条附加条件，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<AchievementCriteriaEntity>> getAchievementCriteria() async {
    final rows = await laconic.table(_table).orderBy('ID').get();
    return rows
        .map((row) => AchievementCriteriaEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getAchievementCriteriaLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<AchievementCriteriaEntity?> getAchievementCriterion(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    if (rows.isEmpty) return null;
    return AchievementCriteriaEntity.fromJson(rows.first.toMap());
  }

  Future<List<BriefAchievementCriteriaEntity>> getBriefAchievementCriteria({
    int page = 1,
    AchievementCriteriaFilterEntity? filter,
  }) async {
    var builder = _applyFilter(laconic.table(_table), filter);
    builder = builder
        .select(['ID', 'Achievement_ID', 'Type', 'Description_lang_zhCN'])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize);
    final rows = await builder.get();
    return rows
        .map((row) => BriefAchievementCriteriaEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveAchievementCriteriaLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> saveAchievementCriterion(
    AchievementCriteriaEntity criterion,
  ) async {
    if (criterion.id == 0 ||
        await getAchievementCriterion(criterion.id) == null) {
      await storeAchievementCriterion(criterion);
      return;
    }
    await updateAchievementCriterion(criterion);
  }

  Future<int> storeAchievementCriterion(
    AchievementCriteriaEntity criterion,
  ) async {
    final stored = criterion.id > 0
        ? criterion
        : criterion.copyWith(id: await _getNextId());
    await _validateAchievement(stored.achievementId, null);
    await laconic.table(_table).insert([stored.toJson()]);
    return stored.id;
  }

  Future<void> updateAchievementCriterion(
    AchievementCriteriaEntity criterion,
  ) async {
    final existing = await getAchievementCriterion(criterion.id);
    if (existing == null) {
      throw StateError('成就条件 ${criterion.id} 不存在');
    }
    await _validateAchievement(criterion.achievementId, existing.achievementId);
    final json = criterion.toJson()..remove('ID');
    await laconic.table(_table).where('ID', criterion.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    AchievementCriteriaFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.achievementId.isNotEmpty) {
      builder = builder.where('Achievement_ID', filter.achievementId);
    }
    if (filter.type.isNotEmpty) builder = builder.where('Type', filter.type);
    if (filter.description.isNotEmpty) {
      builder = builder.where(
        'Description_lang_zhCN',
        '%${filter.description}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0xffff) {
      throw StateError('Achievement_Criteria.dbc 已无可用 smallint unsigned ID');
    }
    return id;
  }

  Future<void> _validateAchievement(int id, int? existingId) async {
    if (id == existingId) return;
    final count = await laconic
        .table('foxy.dbc_achievement')
        .where('ID', id)
        .count();
    if (count == 0) {
      throw ArgumentError.value(id, 'Achievement_ID', '引用的成就不存在');
    }
  }
}
