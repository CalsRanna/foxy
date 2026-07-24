// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'char_title_repository.dart';

mixin _CharTitleRepositoryMixin on RepositoryMixin {
  Future<void> destroyCharTitle(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_char_titles'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CharTitleEntity?> getCharTitle(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_char_titles'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CharTitleEntity.fromJson(results.first.toMap());
  }

  Future<void> updateCharTitle(int originalKey, CharTitleEntity title) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_char_titles'),
        originalKey,
      ).update(title.toJson());
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class CharTitleFilter {
  final String id;
  final String name;

  const CharTitleFilter({this.id = '', this.name = ''});

  factory CharTitleFilter.fromJson(Map<String, dynamic> json) {
    return CharTitleFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CharTitleFilter copyWith({String? id, String? name}) {
    return CharTitleFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
