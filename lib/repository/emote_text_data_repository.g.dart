// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_data_repository.dart';

mixin _EmoteTextDataRepositoryMixin on RepositoryMixin {
  Future<void> destroyEmoteTextData(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_emotes_text_data'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<EmoteTextDataEntity?> getEmoteTextData(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_emotes_text_data'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return EmoteTextDataEntity.fromJson(results.first.toMap());
  }

  Future<void> updateEmoteTextData(
    int originalKey,
    EmoteTextDataEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_emotes_text_data'),
        originalKey,
      ).update(data.toJson());
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

final class EmoteTextDataFilter {
  final String id;
  final String text;

  const EmoteTextDataFilter({this.id = '', this.text = ''});

  factory EmoteTextDataFilter.fromJson(Map<String, dynamic> json) {
    return EmoteTextDataFilter(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  EmoteTextDataFilter copyWith({String? id, String? text}) {
    return EmoteTextDataFilter(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
