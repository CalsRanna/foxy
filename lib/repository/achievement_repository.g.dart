// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_repository.dart';

final class AchievementFilter {
  final String id;
  final String title;

  const AchievementFilter({this.id = '', this.title = ''});

  factory AchievementFilter.fromJson(Map<String, dynamic> json) {
    return AchievementFilter(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
    );
  }

  AchievementFilter copyWith({String? id, String? title}) {
    return AchievementFilter(id: id ?? this.id, title: title ?? this.title);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}

mixin _AchievementRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<int> copyAchievement(int key) async {
    final source = await getAchievement(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createAchievement();
    final copied = source.copyWith(id: blank.id);
    await storeAchievement(copied);
    return copied.id;
  }

  Future<int> countAchievements({AchievementFilter? filter}) async {
    return _applyFilter(laconic.table('foxy.dbc_achievement'), filter).count();
  }

  Future<AchievementEntity> createAchievement() async {
    return AchievementEntity(
      id: await nextMaxPlusOne('foxy.dbc_achievement', '`ID`'),
    );
  }

  Future<void> destroyAchievement(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_achievement'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<AchievementEntity?> getAchievement(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_achievement'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return AchievementEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefAchievementEntity>> getBriefAchievements({
    int page = 1,
    AchievementFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_achievement').select([
      '`ID`',
      '`Title_lang_zhCN`',
      '`Description_lang_zhCN`',
      '`Reward_lang_zhCN`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefAchievementEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<AchievementEntity>> getAchievements() async {
    var builder = laconic.table('foxy.dbc_achievement').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => AchievementEntity.fromJson(e.toMap())).toList();
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

  Future<void> storeAchievement(AchievementEntity achievement) async {
    if (achievement.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(achievement);
    final json = prepareWriteJson(achievement.toJson());
    try {
      await laconic.table('foxy.dbc_achievement').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateAchievement(
    int originalKey,
    AchievementEntity achievement,
  ) async {
    await _beforeUpdate(originalKey, achievement);
    final json = prepareWriteJson(achievement.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_achievement'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, AchievementFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.title.isNotEmpty) {
      builder = builder.where('`Title_lang_zhCN`', filter.title);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(AchievementEntity achievement) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    AchievementEntity achievement,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
