// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinematic_sequence_repository.dart';

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

mixin _CinematicSequenceRepositoryMixin on RepositoryMixin {
  Future<void> destroyCinematicSequence(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_cinematic_sequences'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_cinematic_sequences record not found',
      );
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

  Future<int> storeCinematicSequence(
    CinematicSequenceEntity cinematicSequence,
  ) async {
    if (cinematicSequence.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(cinematicSequence);
    final json = prepareWriteJson(cinematicSequence.toJson());
    try {
      await laconic.table('foxy.dbc_cinematic_sequences').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = cinematicSequence.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_cinematic_sequences', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_cinematic_sequences').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_cinematic_sequences',
          );
        }
        rethrow;
      }
    }
    return cinematicSequence.id;
  }

  Future<void> updateCinematicSequence(
    int originalKey,
    CinematicSequenceEntity cinematicSequence,
  ) async {
    await _beforeUpdate(originalKey, cinematicSequence);
    final json = prepareWriteJson(cinematicSequence.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_cinematic_sequences'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_cinematic_sequences',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_cinematic_sequences record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CinematicSequenceEntity cinematicSequence) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CinematicSequenceEntity cinematicSequence,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
