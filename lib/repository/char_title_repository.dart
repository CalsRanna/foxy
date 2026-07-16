import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/entity/char_title_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CharTitleRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_char_titles';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copyCharTitle(int id) async {
    var source = await getCharTitle(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countCharTitles({CharTitleFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CharTitleEntity> createCharTitle() async {
    return CharTitleEntity(id: await _getNextId());
  }

  Future<void> destroyCharTitle(int id) async {
    await laconic.table(_table).where('ID', id).delete();
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

  Future<CharTitleEntity?> getCharTitle(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
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

  Future<void> saveCharTitle(CharTitleEntity title) async {
    if (title.id == 0) {
      await storeCharTitle(title);
      return;
    }
    var existing = await getCharTitle(title.id);
    if (existing != null) {
      await updateCharTitle(title);
    } else {
      await laconic.table(_table).insert([title.toJson()]);
    }
  }

  Future<void> saveCharTitleLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeCharTitle(CharTitleEntity title) async {
    var json = title.toJson();
    final nextId = title.id > 0 ? title.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCharTitle(CharTitleEntity title) async {
    var json = title.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', title.id).update(json);
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

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }
}
