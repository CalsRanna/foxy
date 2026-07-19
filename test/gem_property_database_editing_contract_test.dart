import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_gem_property_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/entity/gem_property_key.dart';

void main() {
  test('GemPropertyKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = GemPropertyKey(id: 7);
    expect(key, const GemPropertyKey(id: 7));
    expect(key.hashCode, const GemPropertyKey(id: 7).hashCode);
    expect(GemPropertyKey.fromEntity(const GemPropertyEntity(id: 7)), key);
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
