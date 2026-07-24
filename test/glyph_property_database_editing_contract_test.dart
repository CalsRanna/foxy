import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/glyph_property_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const GlyphPropertyEntity(id: 7)).id, key);
    expect(const BriefGlyphPropertyEntity(id: 7).key, key);
  });
}
