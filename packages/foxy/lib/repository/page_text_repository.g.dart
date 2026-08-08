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
      throw RecordNotFoundException('page_text record not found');
    }
    final blank = await createPageText();
    final copied = source.copyWith(id: blank.id);
    await storePageText(copied);
    return copied.id;
  }

  Future<int> countPageTexts({PageTextFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<PageTextEntity> createPageText() async {
    return PageTextEntity(id: await nextMaxPlusOne(_table, '`ID`'));
  }

  Future<void> destroyPageText(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('page_text record not found');
    }
  }

  Future<PageTextEntity?> getPageText(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PageTextEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefPageTextEntity>> getBriefPageTexts({
    int page = 1,
    PageTextFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
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
    var builder = laconic.table(_table).orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => PageTextEntity.fromJson(e.toMap())).toList();
  }

  Future<int> storePageText(PageTextEntity pageText) async {
    if (pageText.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(pageText);
    final json = prepareWriteJson(pageText.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = pageText.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in page_text');
        }
        rethrow;
      }
    }
    return pageText.id;
  }

  Future<void> updatePageText(int originalKey, PageTextEntity pageText) async {
    await _beforeUpdate(originalKey, pageText);
    final json = prepareWriteJson(pageText.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in page_text');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('page_text record not found');
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

const _table = 'page_text';
