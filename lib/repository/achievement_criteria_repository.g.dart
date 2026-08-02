// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_criteria_repository.dart';

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

mixin _AchievementCriteriaRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroyAchievementCriteria(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_achievement_criteria'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_achievement_criteria record not found',
      );
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

  Future<List<DbcLocaleFieldValue>> getAchievementCriteriaLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveAchievementCriteriaLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeAchievementCriteria(
    AchievementCriteriaEntity achievementCriteria,
  ) async {
    if (achievementCriteria.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(achievementCriteria);
    final json = prepareWriteJson(achievementCriteria.toJson());
    try {
      await laconic.table('foxy.dbc_achievement_criteria').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_achievement_criteria',
        );
      }
      rethrow;
    }
  }

  Future<void> updateAchievementCriteria(
    int originalKey,
    AchievementCriteriaEntity achievementCriteria,
  ) async {
    await _beforeUpdate(originalKey, achievementCriteria);
    final json = prepareWriteJson(achievementCriteria.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_achievement_criteria'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_achievement_criteria',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_achievement_criteria record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    AchievementCriteriaEntity achievementCriteria,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    AchievementCriteriaEntity achievementCriteria,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
