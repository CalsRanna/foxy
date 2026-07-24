// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_category_repository.dart';

mixin _AchievementCategoryRepositoryMixin on RepositoryMixin {
  Future<void> destroyAchievementCategory(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_achievement_category'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<AchievementCategoryEntity?> getAchievementCategory(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_achievement_category'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return AchievementCategoryEntity.fromJson(results.first.toMap());
  }

  Future<void> storeAchievementCategory(
    AchievementCategoryEntity achievementCategory,
  ) async {
    if (achievementCategory.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(achievementCategory);
    final json = _prepareWriteJson(achievementCategory.toJson());
    try {
      await laconic.table('foxy.dbc_achievement_category').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateAchievementCategory(
    int originalKey,
    AchievementCategoryEntity achievementCategory,
  ) async {
    await _beforeUpdate(originalKey, achievementCategory);
    final json = _prepareWriteJson(achievementCategory.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_achievement_category'),
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

  Future<void> _beforeStore(
    AchievementCategoryEntity achievementCategory,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    AchievementCategoryEntity achievementCategory,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class AchievementCategoryFilter {
  final String id;
  final String name;

  const AchievementCategoryFilter({this.id = '', this.name = ''});

  factory AchievementCategoryFilter.fromJson(Map<String, dynamic> json) {
    return AchievementCategoryFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  AchievementCategoryFilter copyWith({String? id, String? name}) {
    return AchievementCategoryFilter(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
