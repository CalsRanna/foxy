import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_skill_line_entity.dart';

void main() {
  test('Brief key 返回完整物理 ID 标量', () {
    expect(7, 7);
    expect(7.hashCode, 7.hashCode);
    expect(const BriefSkillLineEntity(id: 7).key, 7);
  });

  test('SkillLine Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/skill_line_repository.dart',
    ).readAsStringSync();
    expect(source, contains('copySkillLine(int key)'));
    expect(source, contains('destroySkillLine(int key)'));
    expect(source, contains('getSkillLine(int key)'));
    expect(source, contains('Future<void> storeSkillLine('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(skillLine.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSkillLine(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefSkillLine 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_skill_line_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
