import 'package:foxy/entity/brief_emote_text_data_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/emote_text_data_entity.dart';
import 'package:foxy/entity/emote_text_data_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class EmoteTextDataRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_emotes_text_data';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyEmoteTextData(int key) async {
    final source = await getEmoteTextData(key);
    if (source == null) {
      throw StateError('原表情文本内容不存在，可能已被其他操作修改或删除');
    }
    final copied = EmoteTextDataEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeEmoteTextData(copied);
    return copied.id;
  }

  Future<int> countEmoteTextDatas({EmoteTextDataFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<EmoteTextDataEntity> createEmoteTextData() async {
    return EmoteTextDataEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyEmoteTextData(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原表情文本内容不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefEmoteTextDataEntity>> getBriefEmoteTextDatas({
    int page = 1,
    EmoteTextDataFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select(['ID', 'Text_lang_zhCN']);
    builder = _applyFilter(builder, filter);
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefEmoteTextDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<EmoteTextDataEntity?> getEmoteTextData(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : EmoteTextDataEntity.fromJson(rows.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getEmoteTextDataLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<EmoteTextDataEntity>> getEmoteTextDatas() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => EmoteTextDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveEmoteTextDataLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeEmoteTextData(EmoteTextDataEntity data) async {
    if (data.id <= 0) {
      throw StateError('表情文本内容 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([data.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('表情文本内容 ${data.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateEmoteTextData(
    int originalKey,
    EmoteTextDataEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(data.toJson());
      if (matchedRows == 0) {
        throw StateError('原表情文本内容不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的表情文本内容 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    EmoteTextDataFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.text.isNotEmpty) {
      builder = builder.where(
        'Text_lang_zhCN',
        '%${filter.text}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
