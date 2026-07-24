// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_duration_repository.dart';

mixin _SpellDurationRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellDuration(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_duration'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellDurationEntity?> getSpellDuration(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_duration'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellDurationEntity.fromJson(results.first.toMap());
  }

  Future<void> updateSpellDuration(
    int originalKey,
    SpellDurationEntity duration,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_duration'),
        originalKey,
      ).update(duration.toJson());
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

final class SpellDurationFilter {
  final String id;

  const SpellDurationFilter({this.id = ''});

  factory SpellDurationFilter.fromJson(Map<String, dynamic> json) {
    return SpellDurationFilter(id: json['id']?.toString() ?? '');
  }

  SpellDurationFilter copyWith({String? id}) {
    return SpellDurationFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
