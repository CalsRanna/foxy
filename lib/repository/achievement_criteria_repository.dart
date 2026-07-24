import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'achievement_criteria_repository.g.dart';

@FoxyRepository(AchievementCriteriaEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('achievementId')
@FoxyFilter.text('type')
@FoxyFilter.text('description')
class AchievementCriteriaRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _AchievementCriteriaRepositoryMixin {
  static const _table = 'foxy.dbc_achievement_criteria';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyAchievementCriterion(int key) async {
    final source = await getAchievementCriteria(key);
    if (source == null) {
      throw StateError('原成就条件不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeAchievementCriteria(copied);
    return copied.id;
  }

  Future<int> countAchievementCriteria({AchievementCriteriaFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<AchievementCriteriaEntity> createAchievementCriterion() async {
    return AchievementCriteriaEntity(id: await _getNextId());
  }

  Future<List<DbcLocaleFieldValue>> getAchievementCriteriaLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<AchievementCriteriaEntity>> getAllAchievementCriteria() async {
    final rows = await laconic.table(_table).orderBy('ID').get();
    return rows
        .map((row) => AchievementCriteriaEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<BriefAchievementCriteriaEntity>> getBriefAchievementCriteria({
    int page = 1,
    AchievementCriteriaFilter? filter,
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    AchievementCriteriaFilter? filter,
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
}
