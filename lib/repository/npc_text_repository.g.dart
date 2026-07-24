// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_text_repository.dart';

mixin _NpcTextRepositoryMixin on RepositoryMixin {
  Future<void> destroyNpcText(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('npc_text'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<NpcTextEntity?> getNpcText(int key) async {
    final results = await _whereKey(
      laconic.table('npc_text'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTextEntity.fromJson(results.first.toMap());
  }

  Future<void> storeNpcText(NpcTextEntity npcText) async {
    if (npcText.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(npcText);
    final json = _prepareWriteJson(npcText.toJson());
    try {
      await laconic.table('npc_text').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateNpcText(int originalKey, NpcTextEntity npcText) async {
    await _beforeUpdate(originalKey, npcText);
    final json = _prepareWriteJson(npcText.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('npc_text'),
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

  Future<void> _beforeStore(NpcTextEntity npcText) async {}

  Future<void> _beforeUpdate(int originalKey, NpcTextEntity npcText) async {}

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
