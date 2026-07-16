import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_filter_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PageTextRepository with RepositoryMixin {
  static const _table = 'page_text';
  static const _localeTable = 'page_text_locale';

  Future<void> copyPageText(int id) async {
    final source = await getPageText(id);
    if (source == null) return;
    final nextId = await _getNextId();
    final copied = source.copyWith(id: nextId);
    await _validateNextPage(copied.id, copied.nextPageId);
    final locales = _prepareLocales(nextId, await getPageTextLocales(id));
    await laconic.transaction(() async {
      await laconic.table(_table).insert([copied.toJson()]);
      if (locales.isNotEmpty) {
        await laconic
            .table(_localeTable)
            .insert(locales.map((locale) => locale.toJson()).toList());
      }
    });
  }

  Future<int> countPageTexts({PageTextFilterEntity? filter}) async {
    final needsLocaleJoin =
        localeEnabled && filter != null && filter.text.isNotEmpty;
    if (!needsLocaleJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.id.isNotEmpty) {
        builder = builder.where('ID', filter.id);
      }
      if (filter != null && filter.text.isNotEmpty) {
        builder = builder.where('Text', '%${filter.text}%', comparator: 'like');
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS pt');
    builder = builder.leftJoin(
      '$_localeTable AS ptl',
      (join) => join.on('pt.ID', 'ptl.ID').where('ptl.locale', 'zhCN'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<PageTextEntity> createPageText() async {
    return PageTextEntity(id: await _getNextId());
  }

  Future<void> destroyPageText(int id) async {
    final nextPageReferences = await laconic
        .table(_table)
        .where('NextPageID', id)
        .count();
    final itemReferences = await laconic
        .table('item_template')
        .where('PageText', id)
        .count();
    final textGameObjectReferences = await laconic
        .table('gameobject_template')
        .where('type', 9)
        .where('Data0', id)
        .count();
    final gooberReferences = await laconic
        .table('gameobject_template')
        .where('type', 10)
        .where('Data7', id)
        .count();
    final references =
        nextPageReferences +
        itemReferences +
        textGameObjectReferences +
        gooberReferences;
    if (references > 0) {
      throw StateError(
        '页面文本 $id 仍有 $references 条引用，不能删除'
        '（下一页 $nextPageReferences、物品 $itemReferences、'
        '文本对象 $textGameObjectReferences、Goober $gooberReferences）',
      );
    }
    await laconic.transaction(() async {
      await laconic.table(_localeTable).where('ID', id).delete();
      await laconic.table(_table).where('ID', id).delete();
    });
  }

  Future<List<BriefPageTextEntity>> getBriefPageTexts({
    int page = 1,
    PageTextFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS pt');
    final fields = <String>[
      'pt.ID',
      'pt.Text',
      if (localeEnabled) 'ptl.Text AS localeText',
      'pt.NextPageID',
    ];
    builder = builder.select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        '$_localeTable AS ptl',
        (join) => join.on('pt.ID', 'ptl.ID').where('ptl.locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('pt.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefPageTextEntity.fromJson(e.toMap())).toList();
  }

  Future<PageTextEntity?> getPageText(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return PageTextEntity.fromJson(results.first.toMap());
  }

  Future<List<PageTextLocaleEntity>> getPageTextLocales(int id) async {
    final results = await laconic
        .table(_localeTable)
        .where('ID', id)
        .orderBy('locale')
        .get();
    return results
        .map((e) => PageTextLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<PageTextEntity>> getPageTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => PageTextEntity.fromJson(e.toMap())).toList();
  }

  Future<void> savePageText(PageTextEntity pageText) async {
    if (pageText.id == 0 || await getPageText(pageText.id) == null) {
      await storePageText(pageText);
      return;
    }
    await updatePageText(pageText);
  }

  Future<void> savePageTextLocales(
    int id,
    List<PageTextLocaleEntity> locales,
  ) async {
    if (await getPageText(id) == null) {
      throw StateError('页面文本 $id 不存在，不能保存本地化');
    }
    final stored = _prepareLocales(id, locales);
    await laconic.transaction(() async {
      await laconic.table(_localeTable).where('ID', id).delete();
      if (stored.isEmpty) return;
      await laconic
          .table(_localeTable)
          .insert(stored.map((locale) => locale.toJson()).toList());
    });
  }

  Future<int> storePageText(PageTextEntity pageText) async {
    final nextId = pageText.id > 0 ? pageText.id : await _getNextId();
    final stored = pageText.copyWith(id: nextId);
    await _validateNextPage(stored.id, stored.nextPageId);
    if (await getPageText(stored.id) != null) {
      throw StateError('页面文本 ${stored.id} 已存在');
    }
    await laconic.table(_table).insert([stored.toJson()]);
    return nextId;
  }

  Future<void> updatePageText(PageTextEntity pageText) async {
    if (await getPageText(pageText.id) == null) {
      throw StateError('页面文本 ${pageText.id} 不存在');
    }
    await _validateNextPage(pageText.id, pageText.nextPageId);
    final json = pageText.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', pageText.id).update(json);
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
      if (localeEnabled) {
        builder = builder.whereAny(
          ['pt.Text', 'ptl.Text'],
          '%${filter.text}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'pt.Text',
          '%${filter.text}%',
          comparator: 'like',
        );
      }
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > kPageTextMaxUnsignedInt) {
      throw StateError('page_text 已无可用 uint32 ID');
    }
    return id;
  }

  List<PageTextLocaleEntity> _prepareLocales(
    int id,
    List<PageTextLocaleEntity> locales,
  ) {
    final localeKeys = <String>{};
    return locales.map((locale) {
      final normalized = locale.copyWith(id: id);
      if (!localeKeys.add(normalized.locale)) {
        throw StateError('语言 ${normalized.locale} 重复');
      }
      return normalized;
    }).toList();
  }

  Future<void> _validateNextPage(int id, int nextPageId) async {
    if (nextPageId == 0) return;
    var current = nextPageId;
    final visited = <int>{id};
    while (current != 0) {
      if (!visited.add(current)) {
        throw StateError('NextPageID 形成循环引用');
      }
      final page = await getPageText(current);
      if (page == null) {
        throw StateError('NextPageID 引用的页面文本 $current 不存在');
      }
      current = page.nextPageId;
    }
  }
}
