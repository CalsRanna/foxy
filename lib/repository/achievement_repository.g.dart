// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_repository.dart';

mixin _AchievementRepositoryMixin on RepositoryMixin {
  Future<void> destroyAchievement(int key) async {
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

  Future<void> storeAchievement(AchievementEntity achievement) async {
    if (achievement.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(achievement);
    final json = _prepareWriteJson(achievement.toJson());
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
    final json = _prepareWriteJson(achievement.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_achievement'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(AchievementEntity achievement) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    AchievementEntity achievement,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
