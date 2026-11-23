// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_repository.dart';

final class EmoteTextFilter {
  final String id;
  final String name;

  const EmoteTextFilter({this.id = '', this.name = ''});

  factory EmoteTextFilter.fromJson(Map<String, dynamic> json) {
    return EmoteTextFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  EmoteTextFilter copyWith({String? id, String? name}) {
    return EmoteTextFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _EmoteTextRepositoryMixin on RepositoryMixin {
  String get _table => 'foxy.dbc_emotes_text';

  Future<int> copyEmoteText(int key) async {
    final source = await getEmoteText(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_emotes_text record not found');
    }
    final blank = await createEmoteText();
    final copied = source.copyWith(id: blank.id);
    return storeEmoteText(copied);
  }

  Future<int> countEmoteTexts({EmoteTextFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<EmoteTextEntity> createEmoteText() async {
    return EmoteTextEntity(id: await nextMaxPlusOne(_table, '`ID`'));
  }

  Future<void> destroyEmoteText(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_emotes_text record not found');
    }
  }

  Future<EmoteTextEntity?> getEmoteText(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return EmoteTextEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefEmoteTextEntity>> getBriefEmoteTexts({
    int page = 1,
    EmoteTextFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select(['`ID`', '`Name`', '`EmoteID`']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefEmoteTextEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<EmoteTextEntity>> getEmoteTexts() async {
    var builder = laconic.table(_table).orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => EmoteTextEntity.fromJson(e.toMap())).toList();
  }

  Future<int> storeEmoteText(EmoteTextEntity emoteText) async {
    if (emoteText.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(emoteText);
    final json = prepareWriteJson(emoteText.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(emoteText.id),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = emoteText.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(retried.id),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_emotes_text');
        }
        rethrow;
      }
    }
    return emoteText.id;
  }

  Future<void> updateEmoteText(
    int originalKey,
    EmoteTextEntity emoteText,
  ) async {
    await _beforeUpdate(originalKey, emoteText);
    final values = emoteText.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(emoteText.id),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_emotes_text');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_emotes_text record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, EmoteTextFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`Name`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(EmoteTextEntity emoteText) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    EmoteTextEntity emoteText,
  ) async {}

  Map<String, Object?> activityKey(int key) => {'ID': key};

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
