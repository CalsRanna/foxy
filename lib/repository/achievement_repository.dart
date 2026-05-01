import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/achievement_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class AchievementRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_achievement';

  Future<List<AchievementEntity>> getAchievements({
    int page = 1,
    AchievementFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
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
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefAchievementEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countAchievements({AchievementFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<AchievementEntity?> getAchievement(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return AchievementEntity.fromJson(result.toMap());
  }

  Future<void> storeAchievement(AchievementEntity achievement) async {
    var json = achievement.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
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

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select(['MAX(ID) as max_id']).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, AchievementFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.title.isNotEmpty) {
      builder = builder.where('Title_lang_zhCN', '%${filter.title}%');
    }
    return builder;
  }
}
