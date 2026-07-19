import 'package:foxy/entity/brief_gem_property_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/entity/gem_property_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GemPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_gem_properties';

  Future<int> copyGemProperty(int key) async {
    final source = await getGemProperty(key);
    if (source == null) {
      throw StateError('原宝石属性不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeGemProperty(copied);
    return copied.id;
  }

  Future<int> countGemProperties({GemPropertyFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GemPropertyEntity> createGemProperty() async {
    return GemPropertyEntity(id: await _getNextId());
  }

  Future<void> destroyGemProperty(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原宝石属性不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGemPropertyEntity>> getBriefGemProperties({
    int page = 1,
    GemPropertyFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Enchant_ID',
      'Maxcount_inv',
      'Maxcount_item',
      'Type',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGemPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GemPropertyEntity>> getGemProperties() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => GemPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<GemPropertyEntity?> getGemProperty(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GemPropertyEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGemProperty(GemPropertyEntity gemProperty) async {
    if (gemProperty.id <= 0) {
      throw StateError('宝石属性 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([gemProperty.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('宝石属性 ${gemProperty.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGemProperty(
    int originalKey,
    GemPropertyEntity gemProperty,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(gemProperty.toJson());
      if (matchedRows == 0) {
        throw StateError('原宝石属性不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的宝石属性 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GemPropertyFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('GemProperties ID 已超出 DBC int32 范围');
    }
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
