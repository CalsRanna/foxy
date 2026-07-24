import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/sound_ambience_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'sound_ambience_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'SoundAmbienceFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class SoundAmbienceRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_sound_ambience';

  Future<int> copySoundAmbience(int key) async {
    final source = await getSoundAmbience(key);
    if (source == null) {
      throw StateError('原环境声音不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSoundAmbience(copied);
    return copied.id;
  }

  Future<int> countSoundAmbiences({SoundAmbienceFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<SoundAmbienceEntity> createSoundAmbience() async =>
      SoundAmbienceEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroySoundAmbience(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原环境声音不存在，可能已被其他操作修改或删除');
    }
  }

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

  Future<SoundAmbienceEntity?> getSoundAmbience(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : SoundAmbienceEntity.fromJson(rows.first.toMap());
  }

  Future<List<SoundAmbienceEntity>> getSoundAmbiences() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SoundAmbienceEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeSoundAmbience(SoundAmbienceEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('环境声音 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('环境声音 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSoundAmbience(
    int originalKey,
    SoundAmbienceEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原环境声音不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的环境声音 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SoundAmbienceFilter? filter) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
