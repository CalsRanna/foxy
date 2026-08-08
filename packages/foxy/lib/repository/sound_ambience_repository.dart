import 'package:foxy/entity/sound_ambience_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'sound_ambience_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
class SoundAmbienceRepository
    with RepositoryMixin, _SoundAmbienceRepositoryMixin {

  Future<int> copySoundAmbience(int key) async {
    final source = await getSoundAmbience(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSoundAmbience(copied);
    return copied.id;
  }

  Future<int> countSoundAmbiences({SoundAmbienceFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<SoundAmbienceEntity> createSoundAmbience() async =>
      SoundAmbienceEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefSoundAmbienceEntity>> getBriefSoundAmbiences({
    int page = 1,
    SoundAmbienceFilter? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'AmbienceID0', 'AmbienceID1']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefSoundAmbienceEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<SoundAmbienceEntity>> getSoundAmbiences() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SoundAmbienceEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SoundAmbienceFilter? filter) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    return builder;
  }
}
