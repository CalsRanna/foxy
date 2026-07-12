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

  Future<List<AchievementEntity>> getAchievements() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => AchievementEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countAchievements({AchievementFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<AchievementEntity?> getAchievement(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return AchievementEntity.fromJson(results.first.toMap());
  }

  Future<AchievementEntity> createAchievement() async {
    return const AchievementEntity();
  }

  Future<int> storeAchievement(AchievementEntity achievement) async {
    var json = achievement.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateAchievement(AchievementEntity achievement) async {
    var json = achievement.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', achievement.id).update(json);
  }

  Future<void> destroyAchievement(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyAchievement(int id) async {
    var source = await getAchievement(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveAchievement(AchievementEntity achievement) async {
    if (achievement.id == 0) {
      await storeAchievement(achievement);
      return;
    }
    var existing = await getAchievement(achievement.id);
    if (existing != null) {
      await updateAchievement(achievement);
    } else {
      await laconic.table(_table).insert([achievement.toJson()]);
    }
  }

  Future<List<DbcLocaleFieldValue>> getAchievementLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveAchievementLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
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
}