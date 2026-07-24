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

  Future<void> updateCinematicSequence(
    int originalKey,
    CinematicSequenceEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_cinematic_sequences'),
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
