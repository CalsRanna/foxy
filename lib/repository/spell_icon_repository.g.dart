// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_icon_repository.dart';

mixin _SpellIconRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellIcon(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_icon'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellIconEntity?> getSpellIcon(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_icon'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellIconEntity.fromJson(results.first.toMap());
  }

  Future<void> updateSpellIcon(int originalKey, SpellIconEntity icon) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_icon'),
        originalKey,
      ).update(icon.toJson());
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

final class SpellIconFilter {
  final String id;
  final String name;

  const SpellIconFilter({this.id = '', this.name = ''});

  factory SpellIconFilter.fromJson(Map<String, dynamic> json) {
    return SpellIconFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellIconFilter copyWith({String? id, String? name}) {
    return SpellIconFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
