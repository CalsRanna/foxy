import 'package:foxy/entity/brief_spell_icon_entity.dart';
import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/entity/spell_icon_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellIconRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_icon';

  Future<int> copySpellIcon(int key) async {
    final source = await getSpellIcon(key);
    if (source == null) {
      throw StateError('原法术图标不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSpellIcon(copied);
    return copied.id;
  }

  Future<int> countSpellIcons({SpellIconFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellIconEntity> createSpellIcon() async {
    return SpellIconEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroySpellIcon(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术图标不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellIconEntity>> getBriefSpellIcons({
    int page = 1,
    SpellIconFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'TextureFilename']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellIconEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SpellIconEntity?> getSpellIcon(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellIconEntity.fromJson(results.first.toMap());
  }

  Future<List<SpellIconEntity>> getSpellIcons() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellIconEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeSpellIcon(SpellIconEntity icon) async {
    if (icon.id <= 0) {
      throw StateError('法术图标 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([icon.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术图标 ${icon.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpellIcon(int originalKey, SpellIconEntity icon) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(icon.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术图标不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术图标 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellIconFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'TextureFilename',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
