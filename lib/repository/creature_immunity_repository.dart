import 'package:foxy/entity/creature_immunity_entity.dart';
import 'package:foxy/entity/creature_immunity_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureImmunityRepository with RepositoryMixin {
  static const _table = 'creature_immunities';

  Future<int> copyCreatureImmunity(int key) async {
    final source = await getCreatureImmunity(key);
    if (source == null) {
      throw StateError('原生物免疫配置不存在，可能已被其他操作修改或删除');
    }
    final copied = CreatureImmunityEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeCreatureImmunity(copied);
    return copied.id;
  }

  Future<int> countCreatureImmunities({
    CreatureImmunityFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureImmunityEntity> createCreatureImmunity() async {
    return CreatureImmunityEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyCreatureImmunity(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原生物免疫配置不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureImmunityEntity>> getBriefCreatureImmunities({
    int page = 1,
    CreatureImmunityFilterEntity? filter,
  }) async {
    final offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'SchoolMask',
      'MechanicsMask',
      'ImmuneAoE',
      'ImmuneChain',
      'Comment',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((row) => BriefCreatureImmunityEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<CreatureImmunityEntity>> getCreatureImmunities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => CreatureImmunityEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<CreatureImmunityEntity?> getCreatureImmunity(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureImmunityEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureImmunity(CreatureImmunityEntity immunity) async {
    if (immunity.id <= 0) {
      throw StateError('生物免疫配置 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([immunity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物免疫配置 ${immunity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureImmunity(
    int originalKey,
    CreatureImmunityEntity immunity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(immunity.toJson());
      if (matchedRows == 0) {
        throw StateError('原生物免疫配置不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物免疫配置 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureImmunityFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.comment.isNotEmpty) {
      builder = builder.where(
        'Comment',
        '%${filter.comment}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
