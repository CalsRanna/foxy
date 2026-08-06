// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_data_repository.dart';

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

mixin _EmoteTextDataRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroyEmoteTextData(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_emotes_text_data'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_emotes_text_data record not found',
      );
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

  Future<List<DbcLocaleFieldValue>> getEmoteTextDataLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveEmoteTextDataLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeEmoteTextData(EmoteTextDataEntity emoteTextData) async {
    if (emoteTextData.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(emoteTextData);
    final json = prepareWriteJson(emoteTextData.toJson());
    try {
      await laconic.table('foxy.dbc_emotes_text_data').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = emoteTextData.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_emotes_text_data', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_emotes_text_data').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_emotes_text_data',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateEmoteTextData(
    int originalKey,
    EmoteTextDataEntity emoteTextData,
  ) async {
    await _beforeUpdate(originalKey, emoteTextData);
    final json = prepareWriteJson(emoteTextData.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_emotes_text_data'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_emotes_text_data',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_emotes_text_data record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(EmoteTextDataEntity emoteTextData) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    EmoteTextDataEntity emoteTextData,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
