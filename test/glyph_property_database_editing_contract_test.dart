import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_glyph_property_entity.dart';
import 'package:foxy/entity/glyph_property_entity.dart';

import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const GlyphPropertyEntity(id: 7)).id, key);
    expect(const BriefGlyphPropertyEntity(id: 7).key, key);
  });

  test('BriefGlyphProperty 不暴露候选写入 API', () {
    final source = readLocalDartLibrarySource(
      'lib/entity/brief_glyph_property_entity.dart',
    );
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
