import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_filter_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PageTextRepository with RepositoryMixin {
  static const _table = 'page_text';
  static const _localeTable = 'page_text_locale';

  Future<List<BriefPageTextEntity>> getBriefPageTexts({
    int page = 1,
    PageTextFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS pt');
    const fields = [
      'pt.ID',
      'pt.Text',
      'ptl.Text AS localeText',
      'pt.NextPageID',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      '$_localeTable AS ptl',
      (join) => join.on('pt.ID', 'ptl.ID').on('ptl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefPageTextEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<PageTextEntity>> getPageTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => PageTextEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countPageTexts({PageTextFilterEntity? filter}) async {
    var builder = laconic.table('$_table AS pt');
    builder = builder.leftJoin(
      '$_localeTable AS ptl',
      (join) => join.on('pt.ID', 'ptl.ID').on('ptl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<PageTextEntity?> getPageText(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return PageTextEntity.fromJson(results.first.toMap());
  }

  Future<PageTextEntity> createPageText() async {
    return const PageTextEntity();
  }

  Future<int> storePageText(PageTextEntity pageText) async {
    var json = pageText.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updatePageText(PageTextEntity pageText) async {
    var json = pageText.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', pageText.id).update(json);
  }

  Future<void> destroyPageText(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyPageText(int id) async {
    var source = await getPageText(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> savePageText(PageTextEntity pageText) async {
    if (pageText.id == 0) {
      await storePageText(pageText);
      return;
    }
    var existing = await getPageText(pageText.id);
    if (existing != null) {
      await updatePageText(pageText);
    } else {
      await laconic.table(_table).insert([pageText.toJson()]);
    }
  }

  Future<List<PageTextLocaleEntity>> getPageTextLocales(int id) async {
    var results = await laconic.table(_localeTable).where('ID', id).get();
    return results
        .map((e) => PageTextLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> savePageTextLocales(
    int id,
    List<PageTextLocaleEntity> locales,
  ) async {
    await laconic.transaction(() async {
      await laconic.table(_localeTable).where('ID', id).delete();
      if (locales.isEmpty) return;
      var jsons = locales.map((e) {
        var json = e.toJson();
        json['ID'] = id;
        return json;
      }).toList();
      await laconic.table(_localeTable).insert(jsons);
    });
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    PageTextFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('pt.ID', filter.id);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['pt.Text', 'ptl.Text'],
        '%${filter.text}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
