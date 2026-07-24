// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinematic_sequence_repository.dart';

mixin _CinematicSequenceRepositoryMixin on RepositoryMixin {
  Future<void> destroyCinematicSequence(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_cinematic_sequences'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CinematicSequenceEntity?> getCinematicSequence(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_cinematic_sequences'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CinematicSequenceEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCinematicSequence(
    CinematicSequenceEntity cinematicSequence,
  ) async {
    if (cinematicSequence.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(cinematicSequence);
    final json = _prepareWriteJson(cinematicSequence.toJson());
    try {
      await laconic.table('foxy.dbc_cinematic_sequences').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCinematicSequence(
    int originalKey,
    CinematicSequenceEntity cinematicSequence,
  ) async {
    await _beforeUpdate(originalKey, cinematicSequence);
    final json = _prepareWriteJson(cinematicSequence.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_cinematic_sequences'),
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

  Future<void> _beforeStore(CinematicSequenceEntity cinematicSequence) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CinematicSequenceEntity cinematicSequence,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class CinematicSequenceFilter {
  final String id;

  const CinematicSequenceFilter({this.id = ''});

  factory CinematicSequenceFilter.fromJson(Map<String, dynamic> json) {
    return CinematicSequenceFilter(id: json['id']?.toString() ?? '');
  }

  CinematicSequenceFilter copyWith({String? id}) {
    return CinematicSequenceFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
