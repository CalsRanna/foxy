import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'achievement_criteria_repository.g.dart';

@FoxyRepository()
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
      throw RecordNotFoundException('record not found');
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    AchievementCriteriaFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.achievementId.isNotEmpty) {
      builder = builder.where(
        'Achievement_ID',
        int.tryParse(filter.achievementId) ?? 0,
      );
    }
    if (filter.type.isNotEmpty) {
      builder = builder.where('Type', int.tryParse(filter.type) ?? 0);
    }
    if (filter.description.isNotEmpty) {
      builder = builder.where(
        'Description_lang_zhCN',
        '%${escapeLike(filter.description)}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0xffff) {
      throw IdExhaustedException(
        'no free smallint unsigned ID left in Achievement_Criteria.dbc',
      );
    }
    return id;
  }
}
