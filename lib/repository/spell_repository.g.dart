// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_repository.dart';

mixin _SpellRepositoryMixin on RepositoryMixin {
  Future<void> destroySpell(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellEntity?> getSpell(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellEntity.fromJson(results.first.toMap());
  }

  Future<void> updateSpell(int originalKey, SpellEntity spell) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell'),
        originalKey,
      ).update(spell.toJson());
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

final class SpellFilter {
  final String id;
  final String name;

  const SpellFilter({this.id = '', this.name = ''});

  factory SpellFilter.fromJson(Map<String, dynamic> json) {
    return SpellFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellFilter copyWith({String? id, String? name}) {
    return SpellFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
