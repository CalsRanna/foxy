import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'page_text_repository.g.dart';

@FoxyRepository(PageTextEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('text')
class PageTextRepository with RepositoryMixin, _PageTextRepositoryMixin {
  static const _table = 'page_text';

  @override
  Future<void> _beforeStore(PageTextEntity pageText) =>
      _validateNextPage(pageText.id, pageText.nextPageId);

  @override
  Future<void> _beforeUpdate(int originalKey, PageTextEntity pageText) =>
      _validateNextPage(pageText.id, pageText.nextPageId);
  static const _localeTable = 'page_text_locale';

  Future<int> copyPageText(int key) async {
    final source = await getPageText(key);
    if (source == null) {
      throw StateError('原页面文本不存在，可能已被其他操作修改或删除');
    }
    final nextId = await _getNextId();
    final copied = source.copyWith(id: nextId);
    await _validateNextPage(copied.id, copied.nextPageId);
    await storePageText(copied);
    return copied.id;
  }

  Future<int> countPageTexts({PageTextFilter? filter}) async {
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

  Future<List<BriefPageTextEntity>> getBriefPageTexts({
    int page = 1,
    PageTextFilter? filter,
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

  Future<List<PageTextEntity>> getPageTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => PageTextEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, PageTextFilter? filter) {
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
