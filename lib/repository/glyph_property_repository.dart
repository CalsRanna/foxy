import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'glyph_property_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'GlyphPropertyFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class GlyphPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_glyph_properties';

  Future<int> copyGlyphProperty(int key) async {
    final source = await getGlyphProperty(key);
    if (source == null) {
      throw StateError('原雕文属性不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeGlyphProperty(copied);
    return copied.id;
  }

  Future<int> countGlyphProperties({GlyphPropertyFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GlyphPropertyEntity> createGlyphProperty() async {
    return GlyphPropertyEntity(id: await _getNextId());
  }

  Future<void> destroyGlyphProperty(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原雕文属性不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGlyphPropertyEntity>> getBriefGlyphProperties({
    int page = 1,
    GlyphPropertyFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'SpellID', 'GlyphSlotFlags', 'SpellIconID'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGlyphPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GlyphPropertyEntity>> getGlyphProperties() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => GlyphPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<GlyphPropertyEntity?> getGlyphProperty(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GlyphPropertyEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGlyphProperty(GlyphPropertyEntity glyphProperty) async {
    if (glyphProperty.id <= 0) {
      throw StateError('雕文属性 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([glyphProperty.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('雕文属性 ${glyphProperty.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGlyphProperty(
    int originalKey,
    GlyphPropertyEntity glyphProperty,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(glyphProperty.toJson());
      if (matchedRows == 0) {
        throw StateError('原雕文属性不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的雕文属性 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, GlyphPropertyFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0xffff) {
      throw StateError('GlyphProperties ID 已超出角色数据和客户端协议的 uint16 范围');
    }
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
