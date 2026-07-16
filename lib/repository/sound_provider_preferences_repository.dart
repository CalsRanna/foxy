import 'package:foxy/entity/sound_provider_preferences_entity.dart';
import 'package:foxy/entity/sound_provider_preferences_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SoundProviderPreferencesRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_sound_provider_preferences';

  Future<void> copySoundProviderPreference(int id) async {
    final source = await getSoundProviderPreference(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countSoundProviderPreferences({
    SoundProviderPreferencesFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<SoundProviderPreferencesEntity>
  createSoundProviderPreference() async =>
      SoundProviderPreferencesEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroySoundProviderPreference(int id) async {
    await laconic.table(_table).where('ID', id).delete();
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
    int id,
  ) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
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

  Future<void> saveSoundProviderPreference(
    SoundProviderPreferencesEntity entity,
  ) async {
    if (await getSoundProviderPreference(entity.id) == null) {
      await storeSoundProviderPreference(entity);
    } else {
      await updateSoundProviderPreference(entity);
    }
  }

  Future<int> storeSoundProviderPreference(
    SoundProviderPreferencesEntity entity,
  ) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateSoundProviderPreference(
    SoundProviderPreferencesEntity entity,
  ) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
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
}
