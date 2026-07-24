// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_repository.dart';

mixin _ItemTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemTemplate(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('item_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemTemplateEntity?> getItemTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('item_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> updateItemTemplate(
    int originalKey,
    ItemTemplateEntity template,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('item_template'),
        originalKey,
      ).update(template.toJson());
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
    return builder.where('entry', key);
  }
}

final class ItemTemplateFilter {
  final String entry;
  final String name;
  final String description;
  final int classId;
  final int subclass;

  const ItemTemplateFilter({
    this.entry = '',
    this.name = '',
    this.description = '',
    this.classId = -1,
    this.subclass = -1,
  });

  factory ItemTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ItemTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      classId: (json['classId'] as num?)?.toInt() ?? -1,
      subclass: (json['subclass'] as num?)?.toInt() ?? -1,
    );
  }

  ItemTemplateFilter copyWith({
    String? entry,
    String? name,
    String? description,
    int? classId,
    int? subclass,
  }) {
    return ItemTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      description: description ?? this.description,
      classId: classId ?? this.classId,
      subclass: subclass ?? this.subclass,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'name': name,
      'description': description,
      'classId': classId,
      'subclass': subclass,
    };
  }
}
