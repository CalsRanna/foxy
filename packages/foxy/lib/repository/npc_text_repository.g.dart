// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_text_repository.dart';

final class NpcTextFilter {
  final String id;
  final String text;

  const NpcTextFilter({this.id = '', this.text = ''});

  factory NpcTextFilter.fromJson(Map<String, dynamic> json) {
    return NpcTextFilter(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  NpcTextFilter copyWith({String? id, String? text}) {
    return NpcTextFilter(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}

mixin _NpcTextRepositoryMixin on RepositoryMixin {
  Future<void> destroyNpcText(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('npc_text record not found');
    }
  }

  Future<NpcTextEntity?> getNpcText(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTextEntity.fromJson(results.first.toMap());
  }

  Future<int> storeNpcText(NpcTextEntity npcText) async {
    if (npcText.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(npcText);
    final json = prepareWriteJson(npcText.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = npcText.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in npc_text');
        }
        rethrow;
      }
    }
    return npcText.id;
  }

  Future<void> updateNpcText(int originalKey, NpcTextEntity npcText) async {
    await _beforeUpdate(originalKey, npcText);
    final json = prepareWriteJson(npcText.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in npc_text');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('npc_text record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(NpcTextEntity npcText) async {}

  Future<void> _beforeUpdate(int originalKey, NpcTextEntity npcText) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'npc_text';
