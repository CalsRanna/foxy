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
