import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'page_text_repository.g.dart';

@FoxyRepository(PageTextEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('text')
class PageTextRepository with RepositoryMixin, _PageTextRepositoryMixin {
  static const _table = 'page_text';

  static const _localeTable = 'page_text_locale';

  @override
  Future<int> copyPageText(int key) async {
    final source = await getPageText(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final nextId = await _getNextId();
    final copied = source.copyWith(id: nextId);
    await _validateNextPage(copied.id, copied.nextPageId);
    await storePageText(copied);
    return copied.id;
  }

  @override
  Future<int> countPageTexts({PageTextFilter? filter}) async {
    final needsLocaleJoin =
        localeEnabled && filter != null && filter.text.isNotEmpty;
    if (!needsLocaleJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.id.isNotEmpty) {
        builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
      }
      if (filter != null && filter.text.isNotEmpty) {
        builder = builder.where('Text', '%${escapeLike(filter.text)}%', comparator: 'like');
      }
      return builder.count();
    }
    var builder = laconic.table('$_table as pt');
    builder = builder.leftJoin(
      '$_localeTable as ptl',
      (join) => join.on('pt.ID', 'ptl.ID').where('ptl.locale', 'zhCN'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  @override
  Future<PageTextEntity> createPageText() async {
    return PageTextEntity(id: await _getNextId());
  }

  @override
  Future<List<BriefPageTextEntity>> getBriefPageTexts({
    int page = 1,
    PageTextFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as pt');
    final fields = <String>[
      'pt.ID',
      'pt.Text',
      if (localeEnabled) 'ptl.Text as localeText',
      'pt.NextPageID',
    ];
    builder = builder.select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        '$_localeTable as ptl',
        (join) => join.on('pt.ID', 'ptl.ID').where('ptl.locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('pt.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefPageTextEntity.fromJson(e.toMap())).toList();
  }

  @override
  Future<List<PageTextEntity>> getPageTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => PageTextEntity.fromJson(e.toMap())).toList();
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, PageTextFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('pt.ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.text.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['pt.Text', 'ptl.Text'],
          '%${escapeLike(filter.text)}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'pt.Text',
          '%${escapeLike(filter.text)}%',
          comparator: 'like',
        );
      }
    }
    return builder;
  }

  @override
  Future<void> _beforeStore(PageTextEntity pageText) =>
      _validateNextPage(pageText.id, pageText.nextPageId);

  @override
  Future<void> _beforeUpdate(int originalKey, PageTextEntity pageText) =>
      _validateNextPage(pageText.id, pageText.nextPageId);

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > kPageTextMaxUnsignedInt) {
      throw IdExhaustedException('no free uint32 ID left in page_text');
    }
    return id;
  }

  Future<void> _validateNextPage(int id, int nextPageId) async {
    if (nextPageId == 0) return;
    var current = nextPageId;
    final visited = <int>{id};
    while (current != 0) {
      if (!visited.add(current)) {
        throw ValidationException('NextPageID forms a circular reference');
      }
      final page = await getPageText(current);
      if (page == null) {
        throw RecordNotFoundException(
          'page text $current referenced by NextPageID does not exist',
        );
      }
      current = page.nextPageId;
    }
  }
}
