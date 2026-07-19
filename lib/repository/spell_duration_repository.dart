import 'package:foxy/entity/brief_spell_duration_entity.dart';
import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/entity/spell_duration_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellDurationRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_duration';

  Future<int> copySpellDuration(int key) async {
    final source = await getSpellDuration(key);
    if (source == null) {
      throw StateError('原法术持续时间不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSpellDuration(copied);
    return copied.id;
  }

  Future<int> countSpellDurations({SpellDurationFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellDurationEntity> createSpellDuration() async {
    return SpellDurationEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroySpellDuration(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术持续时间不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellDurationEntity>> getBriefSpellDurations({
    int page = 1,
    SpellDurationFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'Duration',
      'DurationPerLevel',
      'MaxDuration',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellDurationEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SpellDurationEntity?> getSpellDuration(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellDurationEntity.fromJson(results.first.toMap());
  }

  Future<List<SpellDurationEntity>> getSpellDurations() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellDurationEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeSpellDuration(SpellDurationEntity duration) async {
    if (duration.id <= 0) {
      throw StateError('法术持续时间 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([duration.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术持续时间 ${duration.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpellDuration(
    int originalKey,
    SpellDurationEntity duration,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(duration.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术持续时间不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术持续时间 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellDurationFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
