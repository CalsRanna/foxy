import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/emote_text_data_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'emote_text_data_repository.g.dart';

@FoxyRepository(EmoteTextDataEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('text')
class EmoteTextDataRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _EmoteTextDataRepositoryMixin {
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

  Future<int> countEmoteTextDatas({EmoteTextDataFilter? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<EmoteTextDataEntity> createEmoteTextData() async {
    return EmoteTextDataEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefEmoteTextDataEntity>> getBriefEmoteTextDatas({
    int page = 1,
    EmoteTextDataFilter? filter,
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

  QueryBuilder _applyFilter(QueryBuilder builder, EmoteTextDataFilter? filter) {
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
}
