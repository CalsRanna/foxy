import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'emote_text_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'EmoteTextFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'name',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class EmoteTextRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_emotes_text';

  Future<int> copyEmoteText(int key) async {
    final source = await getEmoteText(key);
    if (source == null) {
      throw StateError('原表情文本不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeEmoteText(copied);
    return copied.id;
  }

  Future<int> countEmoteTexts({EmoteTextFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<EmoteTextEntity> createEmoteText() async {
    return EmoteTextEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyEmoteText(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原表情文本不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefEmoteTextEntity>> getBriefEmoteTexts({
    int page = 1,
    EmoteTextFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'Name', 'EmoteID'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefEmoteTextEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<EmoteTextEntity?> getEmoteText(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return EmoteTextEntity.fromJson(results.first.toMap());
  }

  Future<List<EmoteTextEntity>> getEmoteTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => EmoteTextEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeEmoteText(EmoteTextEntity emoteText) async {
    if (emoteText.id <= 0) {
      throw StateError('表情文本 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([emoteText.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('表情文本 ${emoteText.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateEmoteText(
    int originalKey,
    EmoteTextEntity emoteText,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(emoteText.toJson());
      if (matchedRows == 0) {
        throw StateError('原表情文本不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的表情文本 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, EmoteTextFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name', '%${filter.name}%', comparator: 'like');
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
