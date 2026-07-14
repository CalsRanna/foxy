import 'package:foxy/entity/sound_ambience_entity.dart';
import 'package:foxy/entity/sound_ambience_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SoundAmbienceRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_sound_ambience';

  Future<List<BriefSoundAmbienceEntity>> getBriefSoundAmbiences({
    int page = 1,
    SoundAmbienceFilterEntity? filter,
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

  Future<int> countSoundAmbiences({SoundAmbienceFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<SoundAmbienceEntity?> getSoundAmbience(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : SoundAmbienceEntity.fromJson(rows.first.toMap());
  }

  Future<SoundAmbienceEntity> createSoundAmbience() async =>
      SoundAmbienceEntity(id: await _getNextId());

  Future<int> storeSoundAmbience(SoundAmbienceEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateSoundAmbience(SoundAmbienceEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  Future<void> destroySoundAmbience(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copySoundAmbience(int id) async {
    final source = await getSoundAmbience(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSoundAmbience(SoundAmbienceEntity entity) async {
    if (await getSoundAmbience(entity.id) == null) {
      await storeSoundAmbience(entity);
    } else {
      await updateSoundAmbience(entity);
    }
  }

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SoundAmbienceFilterEntity? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
