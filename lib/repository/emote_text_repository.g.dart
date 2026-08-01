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
  Future<int> copyEmoteText(int key) async {
    final source = await getEmoteText(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createEmoteText();
    final copied = source.copyWith(id: blank.id);
    await storeEmoteText(copied);
    return copied.id;
  }

  Future<int> countEmoteTexts({EmoteTextFilter? filter}) async {
    return _applyFilter(laconic.table('foxy.dbc_emotes_text'), filter).count();
  }

  Future<EmoteTextEntity> createEmoteText() async {
    return EmoteTextEntity(
      id: await nextMaxPlusOne('foxy.dbc_emotes_text', '`ID`'),
    );
  }

  Future<void> destroyEmoteText(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_emotes_text'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<EmoteTextEntity?> getEmoteText(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_emotes_text'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return EmoteTextEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefEmoteTextEntity>> getBriefEmoteTexts({
    int page = 1,
    EmoteTextFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_emotes_text').select([
      '`ID`',
      '`Name`',
      '`EmoteID`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefEmoteTextEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<EmoteTextEntity>> getEmoteTexts() async {
    var builder = laconic.table('foxy.dbc_emotes_text').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => EmoteTextEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeEmoteText(EmoteTextEntity emoteText) async {
    if (emoteText.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(emoteText);
    final json = prepareWriteJson(emoteText.toJson());
    try {
      await laconic.table('foxy.dbc_emotes_text').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateEmoteText(
    int originalKey,
    EmoteTextEntity emoteText,
  ) async {
    await _beforeUpdate(originalKey, emoteText);
    final json = prepareWriteJson(emoteText.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_emotes_text'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
