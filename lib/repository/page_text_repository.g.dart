// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_repository.dart';

mixin _PageTextRepositoryMixin on RepositoryMixin {
  Future<void> destroyPageText(int key) async {
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

  Future<void> storePageText(PageTextEntity pageText) async {
    if (pageText.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(pageText);
    final json = _prepareWriteJson(pageText.toJson());
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
    final json = _prepareWriteJson(pageText.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('page_text'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(PageTextEntity pageText) async {}

  Future<void> _beforeUpdate(int originalKey, PageTextEntity pageText) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
