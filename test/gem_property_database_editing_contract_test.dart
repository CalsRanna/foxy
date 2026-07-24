import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_gem_property_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const GemPropertyEntity(id: 7)).id, key);
    expect(const BriefGemPropertyEntity(id: 7).key, key);
  });
}
