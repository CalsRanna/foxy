// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_criteria_repository.dart';

mixin _AchievementCriteriaRepositoryMixin on RepositoryMixin {
  Future<void> destroyAchievementCriteria(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_achievement_criteria'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<AchievementCriteriaEntity?> getAchievementCriteria(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_achievement_criteria'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return AchievementCriteriaEntity.fromJson(results.first.toMap());
  }

  Future<void> storeAchievementCriteria(
    AchievementCriteriaEntity achievementCriteria,
  ) async {
    if (achievementCriteria.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(achievementCriteria);
    final json = _prepareWriteJson(achievementCriteria.toJson());
    try {
      await laconic.table('foxy.dbc_achievement_criteria').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateAchievementCriteria(
    int originalKey,
    AchievementCriteriaEntity achievementCriteria,
  ) async {
    await _beforeUpdate(originalKey, achievementCriteria);
    final json = _prepareWriteJson(achievementCriteria.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_achievement_criteria'),
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
    AchievementCriteriaEntity achievementCriteria,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    AchievementCriteriaEntity achievementCriteria,
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

final class AchievementCriteriaFilter {
  final String id;
  final String achievementId;
  final String type;
  final String description;

  const AchievementCriteriaFilter({
    this.id = '',
    this.achievementId = '',
    this.type = '',
    this.description = '',
  });

  factory AchievementCriteriaFilter.fromJson(Map<String, dynamic> json) {
    return AchievementCriteriaFilter(
      id: json['id']?.toString() ?? '',
      achievementId: json['achievementId']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  AchievementCriteriaFilter copyWith({
    String? id,
    String? achievementId,
    String? type,
    String? description,
  }) {
    return AchievementCriteriaFilter(
      id: id ?? this.id,
      achievementId: achievementId ?? this.achievementId,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'achievementId': achievementId,
      'type': type,
      'description': description,
    };
  }
}
