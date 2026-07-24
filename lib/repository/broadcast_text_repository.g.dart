// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_text_repository.dart';

mixin _BroadcastTextRepositoryMixin on RepositoryMixin {
  Future<void> destroyBroadcastText(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('broadcast_text'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<BroadcastTextEntity?> getBroadcastText(int key) async {
    final results = await _whereKey(
      laconic.table('broadcast_text'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return BroadcastTextEntity.fromJson(results.first.toMap());
  }

  Future<void> storeBroadcastText(BroadcastTextEntity broadcastText) async {
    if (broadcastText.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(broadcastText);
    final json = _prepareWriteJson(broadcastText.toJson());
    try {
      await laconic.table('broadcast_text').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateBroadcastText(
    int originalKey,
    BroadcastTextEntity broadcastText,
  ) async {
    await _beforeUpdate(originalKey, broadcastText);
    final json = _prepareWriteJson(broadcastText.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('broadcast_text'),
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

  Future<void> _beforeStore(BroadcastTextEntity broadcastText) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    BroadcastTextEntity broadcastText,
  ) async {}

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

final class BroadcastTextFilter {
  final String id;
  final String text;

  const BroadcastTextFilter({this.id = '', this.text = ''});

  factory BroadcastTextFilter.fromJson(Map<String, dynamic> json) {
    return BroadcastTextFilter(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  BroadcastTextFilter copyWith({String? id, String? text}) {
    return BroadcastTextFilter(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
