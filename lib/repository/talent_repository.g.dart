// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_repository.dart';

mixin _TalentRepositoryMixin on RepositoryMixin {
  Future<void> destroyTalent(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_talent'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<TalentEntity?> getTalent(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_talent'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return TalentEntity.fromJson(results.first.toMap());
  }

  Future<void> storeTalent(TalentEntity talent) async {
    if (talent.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(talent);
    final json = _prepareWriteJson(talent.toJson());
    try {
      await laconic.table('foxy.dbc_talent').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateTalent(int originalKey, TalentEntity talent) async {
    await _beforeUpdate(originalKey, talent);
    final json = _prepareWriteJson(talent.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_talent'),
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

  Future<void> _beforeStore(TalentEntity talent) async {}

  Future<void> _beforeUpdate(int originalKey, TalentEntity talent) async {}

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

final class TalentFilter {
  final String id;
  final String spell;

  const TalentFilter({this.id = '', this.spell = ''});

  factory TalentFilter.fromJson(Map<String, dynamic> json) {
    return TalentFilter(
      id: json['id']?.toString() ?? '',
      spell: json['spell']?.toString() ?? '',
    );
  }

  TalentFilter copyWith({String? id, String? spell}) {
    return TalentFilter(id: id ?? this.id, spell: spell ?? this.spell);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell': spell};
  }
}
