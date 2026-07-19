import 'package:foxy/entity/brief_sound_provider_preferences_entity.dart';
import 'package:foxy/entity/sound_provider_preferences_entity.dart';
import 'package:foxy/entity/sound_provider_preferences_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SoundProviderPreferencesRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_sound_provider_preferences';

  Future<int> copySoundProviderPreference(int key) async {
    final source = await getSoundProviderPreference(key);
    if (source == null) {
      throw StateError('原声音提供器偏好不存在，可能已被其他操作修改或删除');
    }
    final copied = SoundProviderPreferencesEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeSoundProviderPreference(copied);
    return copied.id;
  }

  Future<int> countSoundProviderPreferences({
    SoundProviderPreferencesFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<SoundProviderPreferencesEntity>
  createSoundProviderPreference() async =>
      SoundProviderPreferencesEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroySoundProviderPreference(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原声音提供器偏好不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSoundProviderPreferencesEntity>>
  getBriefSoundProviderPreferences({
    int page = 1,
    SoundProviderPreferencesFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'Description', 'Flags']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefSoundProviderPreferencesEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<SoundProviderPreferencesEntity?> getSoundProviderPreference(
    int key,
  ) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : SoundProviderPreferencesEntity.fromJson(rows.first.toMap());
  }

  Future<List<SoundProviderPreferencesEntity>>
  getSoundProviderPreferences() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SoundProviderPreferencesEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeSoundProviderPreference(
    SoundProviderPreferencesEntity entity,
  ) async {
    if (entity.id <= 0) {
      throw StateError('声音提供器偏好 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('声音提供器偏好 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSoundProviderPreference(
    int originalKey,
    SoundProviderPreferencesEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原声音提供器偏好不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的声音提供器偏好 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SoundProviderPreferencesFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.description.isNotEmpty) {
      builder = builder.where(
        'Description',
        '%${filter.description}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
