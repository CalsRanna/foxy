import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'achievement_repository.g.dart';

@FoxyRepository(AchievementEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('title')
class AchievementRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _AchievementRepositoryMixin {
  static const _table = 'foxy.dbc_achievement';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyAchievement(int key) async {
    final source = await getAchievement(key);
    if (source == null) {
      throw StateError('原成就不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeAchievement(copied);
    return copied.id;
  }

  Future<int> countAchievements({AchievementFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<AchievementEntity> createAchievement() async {
    return AchievementEntity(id: await _getNextId());
  }

  Future<List<DbcLocaleFieldValue>> getAchievementLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<AchievementEntity>> getAchievements() async {
    final results = await laconic.table(_table).orderBy('ID').get();
    return results.map((e) => AchievementEntity.fromJson(e.toMap())).toList();
  }

  Future<List<BriefAchievementEntity>> getBriefAchievements({
    int page = 1,
    AchievementFilter? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'Title_lang_zhCN',
      'Description_lang_zhCN',
      'Reward_lang_zhCN',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((e) => BriefAchievementEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveAchievementLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  QueryBuilder _applyFilter(QueryBuilder builder, AchievementFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
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
}
