import 'package:foxy/entity/brief_achievement_criteria_entity.dart';
import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'package:foxy/entity/achievement_criteria_filter_entity.dart';
import 'package:foxy/entity/achievement_criteria_key.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class AchievementCriteriaRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_achievement_criteria';

  @override
  String get dbcLocaleTableName => _table;

  Future<AchievementCriteriaKey> copyAchievementCriterion(
    AchievementCriteriaKey key,
  ) async {
    final source = await getAchievementCriterion(key);
    if (source == null) {
      throw StateError('原成就条件不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeAchievementCriterion(copied);
    return AchievementCriteriaKey.fromEntity(copied);
  }

  Future<int> countAchievementCriteria({
    AchievementCriteriaFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<AchievementCriteriaEntity> createAchievementCriterion() async {
    return AchievementCriteriaEntity(id: await _getNextId());
  }

  Future<void> destroyAchievementCriterion(AchievementCriteriaKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原成就条件不存在，可能已被其他操作修改或删除');
    }
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

  Future<AchievementCriteriaEntity?> getAchievementCriterion(
    AchievementCriteriaKey key,
  ) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
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

  Future<void> storeAchievementCriterion(
    AchievementCriteriaEntity criterion,
  ) async {
    if (criterion.id <= 0) {
      throw StateError('成就条件 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([criterion.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('成就条件 ${criterion.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateAchievementCriterion(
    AchievementCriteriaKey originalKey,
    AchievementCriteriaEntity criterion,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(criterion.toJson());
      if (matchedRows == 0) {
        throw StateError('原成就条件不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的成就条件 ID 已存在，无法保存');
      }
      rethrow;
    }
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

  QueryBuilder _whereKey(QueryBuilder builder, AchievementCriteriaKey key) {
    return builder.where('ID', key.id);
  }
}
