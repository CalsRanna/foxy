// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_text_repository.dart';

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

mixin _BroadcastTextRepositoryMixin on RepositoryMixin {
  Future<void> destroyBroadcastText(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('broadcast_text'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('broadcast_text record not found');
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(broadcastText);
    final json = prepareWriteJson(broadcastText.toJson());
    try {
      await laconic.table('broadcast_text').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in broadcast_text');
      }
      rethrow;
    }
  }

  Future<void> updateBroadcastText(
    int originalKey,
    BroadcastTextEntity broadcastText,
  ) async {
    await _beforeUpdate(originalKey, broadcastText);
    final json = prepareWriteJson(broadcastText.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('broadcast_text'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in broadcast_text');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('broadcast_text record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(BroadcastTextEntity broadcastText) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    BroadcastTextEntity broadcastText,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
