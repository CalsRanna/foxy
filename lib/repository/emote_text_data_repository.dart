import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/emote_text_data_entity.dart';
import 'package:foxy/entity/emote_text_data_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class EmoteTextDataRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_emotes_text_data';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copyEmoteTextData(int id) async {
    final source = await getEmoteTextData(id);
    if (source == null) return;
    final json = source.toJson();
    json['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countEmoteTextDatas({EmoteTextDataFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<EmoteTextDataEntity> createEmoteTextData() async {
    return EmoteTextDataEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyEmoteTextData(int id) async {
    await laconic.table(_table).where('ID', id).delete();
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

  Future<EmoteTextDataEntity?> getEmoteTextData(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
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

  Future<void> saveEmoteTextData(EmoteTextDataEntity data) async {
    if (await getEmoteTextData(data.id) == null) {
      await storeEmoteTextData(data);
    } else {
      await updateEmoteTextData(data);
    }
  }

  Future<void> saveEmoteTextDataLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeEmoteTextData(EmoteTextDataEntity data) async {
    final json = data.toJson();
    final id = data.id > 0 ? data.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateEmoteTextData(EmoteTextDataEntity data) async {
    final json = data.toJson()..remove('ID');
    await laconic.table(_table).where('ID', data.id).update(json);
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
}
