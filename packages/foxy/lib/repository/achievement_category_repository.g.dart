// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_category_repository.dart';

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

mixin _AchievementCategoryRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  String get _table => 'foxy.dbc_achievement_category';

  Future<void> destroyAchievementCategory(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_achievement_category record not found',
      );
    }
  }

  Future<AchievementCategoryEntity?> getAchievementCategory(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return AchievementCategoryEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getAchievementCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveAchievementCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeAchievementCategory(
    AchievementCategoryEntity achievementCategory,
  ) async {
    if (achievementCategory.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(achievementCategory);
    final json = prepareWriteJson(achievementCategory.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = achievementCategory.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_achievement_category',
          );
        }
        rethrow;
      }
    }
    return achievementCategory.id;
  }

  Future<void> updateAchievementCategory(
    int originalKey,
    AchievementCategoryEntity achievementCategory,
  ) async {
    await _beforeUpdate(originalKey, achievementCategory);
    final json = prepareWriteJson(achievementCategory.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_achievement_category',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_achievement_category record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    AchievementCategoryEntity achievementCategory,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    AchievementCategoryEntity achievementCategory,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
