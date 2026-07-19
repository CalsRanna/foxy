import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_gem_property_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const GemPropertyEntity(id: 7)).id, key);
    expect(const BriefGemPropertyEntity(id: 7).key, key);
  });

  test('BriefGemProperty 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_gem_property_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
