import 'package:foxy/entity/brief_zone_intro_music_entity.dart';
import 'package:foxy/entity/zone_intro_music_entity.dart';
import 'package:foxy/entity/zone_intro_music_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ZoneIntroMusicRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_zone_intro_music_table';

  Future<int> copyZoneIntroMusic(int key) async {
    final source = await getZoneIntroMusic(key);
    if (source == null) {
      throw StateError('原区域进入音乐不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeZoneIntroMusic(copied);
    return copied.id;
  }

  Future<int> countZoneIntroMusics({ZoneIntroMusicFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<ZoneIntroMusicEntity> createZoneIntroMusic() async =>
      ZoneIntroMusicEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyZoneIntroMusic(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原区域进入音乐不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefZoneIntroMusicEntity>> getBriefZoneIntroMusics({
    int page = 1,
    ZoneIntroMusicFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'Name', 'SoundID']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefZoneIntroMusicEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<ZoneIntroMusicEntity?> getZoneIntroMusic(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : ZoneIntroMusicEntity.fromJson(rows.first.toMap());
  }

  Future<List<ZoneIntroMusicEntity>> getZoneIntroMusics() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => ZoneIntroMusicEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeZoneIntroMusic(ZoneIntroMusicEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('区域进入音乐 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('区域进入音乐 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateZoneIntroMusic(
    int originalKey,
    ZoneIntroMusicEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原区域进入音乐不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的区域进入音乐 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ZoneIntroMusicFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name', '%${filter.name}%', comparator: 'like');
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
