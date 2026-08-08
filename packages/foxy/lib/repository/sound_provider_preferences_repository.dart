import 'package:foxy/entity/sound_provider_preferences_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'sound_provider_preferences_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('description')
class SoundProviderPreferencesRepository
    with RepositoryMixin, _SoundProviderPreferencesRepositoryMixin {
  static const _table = 'foxy.dbc_sound_provider_preferences';

  Future<int> copySoundProviderPreference(int key) async {
    final source = await getSoundProviderPreferences(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = SoundProviderPreferencesEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeSoundProviderPreferences(copied);
    return copied.id;
  }

  Future<int> countSoundProviderPreferences({
    SoundProviderPreferencesFilter? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<SoundProviderPreferencesEntity>
  createSoundProviderPreference() async =>
      SoundProviderPreferencesEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<SoundProviderPreferencesEntity>>
  getAllSoundProviderPreferences() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SoundProviderPreferencesEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<BriefSoundProviderPreferencesEntity>>
  getBriefSoundProviderPreferences({
    int page = 1,
    SoundProviderPreferencesFilter? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'Description', 'Flags']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefSoundProviderPreferencesEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SoundProviderPreferencesFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.description.isNotEmpty) {
      builder = builder.where(
        'Description',
        '%${escapeLike(filter.description)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
