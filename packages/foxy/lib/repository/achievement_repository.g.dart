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
  String get _table => 'foxy.dbc_achievement';

  Future<int> copyAchievement(int key) async {
    final source = await getAchievement(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_achievement record not found');
    }
    final blank = await createAchievement();
    final copied = source.copyWith(id: blank.id);
    await storeAchievement(copied);
    return copied.id;
  }

  Future<int> countAchievements({AchievementFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<AchievementEntity> createAchievement() async {
    return AchievementEntity(id: await nextMaxPlusOne(_table, '`ID`'));
  }

  Future<void> destroyAchievement(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_achievement record not found');
    }
  }

  Future<AchievementEntity?> getAchievement(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return AchievementEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefAchievementEntity>> getBriefAchievements({
    int page = 1,
    AchievementFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
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
    var builder = laconic.table(_table).orderBy('`ID`');
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

  Future<int> storeAchievement(AchievementEntity achievement) async {
    if (achievement.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(achievement);
    final json = prepareWriteJson(achievement.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = achievement.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_achievement');
        }
        rethrow;
      }
    }
    return achievement.id;
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
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_achievement');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_achievement record not found');
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
