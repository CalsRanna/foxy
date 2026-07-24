import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/entity/char_title_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CharTitleRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_char_titles';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyCharTitle(int key) async {
    final source = await getCharTitle(key);
    if (source == null) {
      throw StateError('原角色称号不存在，可能已被其他操作修改或删除');
    }
    final copied = CharTitleEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeCharTitle(copied);
    return copied.id;
  }

  Future<int> countCharTitles({CharTitleFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CharTitleEntity> createCharTitle() async {
    return CharTitleEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyCharTitle(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原角色称号不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCharTitleEntity>> getBriefCharTitles({
    int page = 1,
    CharTitleFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Name_lang_zhCN']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCharTitleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CharTitleEntity?> getCharTitle(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CharTitleEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getCharTitleLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<CharTitleEntity>> getCharTitles() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => CharTitleEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveCharTitleLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeCharTitle(CharTitleEntity title) async {
    if (title.id <= 0) {
      throw StateError('角色称号 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([title.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('角色称号 ${title.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCharTitle(int originalKey, CharTitleEntity title) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(title.toJson());
      if (matchedRows == 0) {
        throw StateError('原角色称号不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的角色称号 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CharTitleFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
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
