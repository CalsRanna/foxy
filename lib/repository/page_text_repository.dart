import 'package:foxy/model/page_text.dart';
import 'package:foxy/model/page_text_filter_entity.dart';
import 'package:foxy/model/page_text_locale.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PageTextRepository with RepositoryMixin {
  static const _table = 'page_text';
  static const _localeTable = 'page_text_locale';

  Future<List<PageText>> search({
    required PageTextFilterEntity filter,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS pt');
    const fields = ['pt.ID', 'pt.Text', 'ptl.Text AS localeText', 'pt.NextPageID'];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      '$_localeTable AS ptl',
      (join) => join.on('pt.ID', 'ptl.ID').on('ptl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => PageText.fromJson(e.toMap())).toList();
  }

  Future<int> count({required PageTextFilterEntity filter}) async {
    var builder = laconic.table('$_table AS pt');
    builder = builder.leftJoin(
      '$_localeTable AS ptl',
      (join) => join.on('pt.ID', 'ptl.ID').on('ptl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<PageText> find(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return PageText.fromJson(result.toMap());
  }

  Future<void> store(PageText pageText) async {
    await laconic.table(_table).insert([pageText.toJson()]);
  }

  Future<void> update(int id, PageText pageText) async {
    var json = pageText.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }

  Future<void> destroy(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copy(int id) async {
    var text = await find(id);
    var json = text.toJson();
    var newId = await _getNextId();
    json['ID'] = newId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select(['MAX(ID) as max_id']).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  // Locale operations
  Future<List<PageTextLocale>> getLocales(int id) async {
    var results = await laconic.table(_localeTable).where('ID', id).get();
    return results.map((e) => PageTextLocale.fromJson(e.toMap())).toList();
  }

  Future<void> saveLocales(int id, List<PageTextLocale> locales) async {
    await laconic.table(_localeTable).where('ID', id).delete();
    if (locales.isEmpty) return;
    var jsons = locales.map((e) {
      var json = e.toJson();
      json['ID'] = id;
      return json;
    }).toList();
    await laconic.table(_localeTable).insert(jsons);
  }

  dynamic _applyFilter(dynamic builder, PageTextFilterEntity filter) {
    if (filter.id.isNotEmpty) {
      builder = builder.where('pt.ID', filter.id);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['pt.Text', 'ptl.Text'],
        '%${filter.text}%',
        operator: 'like',
      );
    }
    return builder;
  }
}
