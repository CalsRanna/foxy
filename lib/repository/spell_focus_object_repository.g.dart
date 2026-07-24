// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_focus_object_repository.dart';

mixin _SpellFocusObjectRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellFocusObject(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_focus_object'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellFocusObjectEntity?> getSpellFocusObject(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_focus_object'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellFocusObjectEntity.fromJson(results.first.toMap());
  }

  Future<void> updateSpellFocusObject(
    int originalKey,
    SpellFocusObjectEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_focus_object'),
        originalKey,
      ).update(entity.toJson());
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

final class SpellFocusObjectFilter {
  final String id;
  final String name;

  const SpellFocusObjectFilter({this.id = '', this.name = ''});

  factory SpellFocusObjectFilter.fromJson(Map<String, dynamic> json) {
    return SpellFocusObjectFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellFocusObjectFilter copyWith({String? id, String? name}) {
    return SpellFocusObjectFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
