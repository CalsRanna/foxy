// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_repository.dart';

final class PageTextFilter {
  final String id;
  final String text;

  const PageTextFilter({this.id = '', this.text = ''});

  factory PageTextFilter.fromJson(Map<String, dynamic> json) {
    return PageTextFilter(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  PageTextFilter copyWith({String? id, String? text}) {
    return PageTextFilter(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}

mixin _PageTextRepositoryMixin on RepositoryMixin {
  Future<int> copyPageText(int key) async {
    final source = await getPageText(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createPageText();
    final copied = source.copyWith(id: blank.id);
    await storePageText(copied);
    return copied.id;
  }

  Future<int> countPageTexts({PageTextFilter? filter}) async {
    return _applyFilter(laconic.table('page_text'), filter).count();
  }

  Future<PageTextEntity> createPageText() async {
    return PageTextEntity(id: await nextMaxPlusOne('page_text', '`ID`'));
  }

  Future<void> destroyPageText(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('page_text'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PageTextEntity?> getPageText(int key) async {
    final results = await _whereKey(
      laconic.table('page_text'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PageTextEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefPageTextEntity>> getBriefPageTexts({
    int page = 1,
    PageTextFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('page_text').select([
      '`ID`',
      '`Text`',
      '`NextPageID`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results.map((e) => BriefPageTextEntity.fromJson(e.toMap())).toList();
  }

  Future<List<PageTextEntity>> getPageTexts() async {
    var builder = laconic.table('page_text').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => PageTextEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storePageText(PageTextEntity pageText) async {
    if (pageText.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(pageText);
    final json = prepareWriteJson(pageText.toJson());
    try {
      await laconic.table('page_text').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePageText(int originalKey, PageTextEntity pageText) async {
    await _beforeUpdate(originalKey, pageText);
    final json = prepareWriteJson(pageText.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('page_text'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, PageTextFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.where('`Text`', filter.text);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(PageTextEntity pageText) async {}

  Future<void> _beforeUpdate(int originalKey, PageTextEntity pageText) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
