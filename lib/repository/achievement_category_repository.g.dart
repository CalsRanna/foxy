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

  Future<void> updateAchievementCategory(
    int originalKey,
    AchievementCategoryEntity category,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_achievement_category'),
        originalKey,
      ).update(category.toJson());
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
