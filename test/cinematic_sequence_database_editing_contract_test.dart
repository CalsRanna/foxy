import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/cinematic_sequence_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 2;
    expect((const CinematicSequenceEntity(id: 2)).id, first);
    expect(const BriefCinematicSequenceEntity(id: 2).key, first);
  });

  test('CinematicSequence Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/cinematic_sequence_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<int> copyCinematicSequence('));
    expect(source, contains('Future<void> storeCinematicSequence('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeCinematicSequence')));
    expect(source, isNot(contains('saveCinematicSequence(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
