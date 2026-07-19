import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_cinematic_sequence_entity.dart';
import 'package:foxy/entity/cinematic_sequence_entity.dart';
import 'package:foxy/entity/cinematic_sequence_key.dart';

void main() {
  test('CinematicSequenceKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = CinematicSequenceKey(id: 2);
    expect(first, const CinematicSequenceKey(id: 2));
    expect(first.hashCode, const CinematicSequenceKey(id: 2).hashCode);
    expect(first, isNot(const CinematicSequenceKey(id: 3)));
    expect(
      CinematicSequenceKey.fromEntity(const CinematicSequenceEntity(id: 2)),
      first,
    );
    expect(const BriefCinematicSequenceEntity(id: 2).key, first);
  });

  test('CinematicSequence Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/cinematic_sequence_repository.dart',
    ).readAsStringSync();
    expect(
      source,
      contains('Future<CinematicSequenceKey> copyCinematicSequence('),
    );
    expect(source, contains('Future<void> storeCinematicSequence('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeCinematicSequence')));
    expect(source, isNot(contains('saveCinematicSequence(')));
    expect(source, contains('CinematicSequenceKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
