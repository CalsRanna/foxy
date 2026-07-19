import 'package:foxy/entity/brief_spell_custom_attr_entity.dart';
import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellCustomAttrRepository with RepositoryMixin {
  static const _table = 'spell_custom_attr';

  Future<void> copySpellCustomAttr(int key) async {
    throw UnsupportedError('法术自定义属性记录不能自动复制，请为有效法术新增记录。');
  }

  Future<int> countSpellCustomAttrs() {
    return laconic.table(_table).count();
  }

  Future<SpellCustomAttrEntity> createSpellCustomAttr([int? spellId]) async {
    return SpellCustomAttrEntity(
      spellId: spellId ?? await nextMaxPlusOne(_table, 'spell_id'),
    );
  }

  Future<void> destroySpellCustomAttr(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术自定义属性不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellCustomAttrEntity>> getBriefSpellCustomAttrs({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select(['spell_id', 'attributes'])
        .orderBy('spell_id')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellCustomAttrEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<SpellCustomAttrEntity?> getSpellCustomAttr(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellCustomAttrEntity.fromJson(results.first.toMap());
  }

  Future<List<SpellCustomAttrEntity>> getSpellCustomAttrs() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => SpellCustomAttrEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeSpellCustomAttr(SpellCustomAttrEntity data) async {
    if (data.spellId <= 0) {
      throw StateError('法术自定义属性 spell_id 必须显式指定');
    }
    try {
      await laconic.table(_table).insert([data.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术自定义属性 ${data.spellId} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpellCustomAttr(
    int originalKey,
    SpellCustomAttrEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(data.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术自定义属性不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术自定义属性 spell_id 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('spell_id', key);
  }
}
