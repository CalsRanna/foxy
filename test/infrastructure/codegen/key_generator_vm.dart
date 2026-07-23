import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('标量 key 不生成额外类型', () async {
    await testBuilder(
      foxyKeyBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, standardEntitySource),
      outputs: {},
    );
  });

  test('复合 key 按声明顺序生成完整不可变身份', () async {
    await testBuilder(
      foxyKeyBuilder(BuilderOptions.empty),
      sourceAsset(compositeEntityAsset, compositeEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_relation_entity.key.g.dart': decodedMatches(
          allOf(<Matcher>[
            contains("import 'codegen_relation_entity.dart';"),
            contains('final class CodegenRelationKey'),
            contains('final int ownerId;'),
            contains('final String locale;'),
            contains('const CodegenRelationKey({'),
            contains('factory CodegenRelationKey.fromEntity'),
            contains('ownerId: entity.ownerId'),
            contains('locale: entity.locale'),
            contains('bool operator =='),
            contains('Object.hashAll'),
            contains('String toString()'),
          ]),
        ),
      },
    );
  });

  test('没有 key 字段时拒绝生成', () async {
    final source = standardEntitySource.replaceFirst(
      "@FoxyFullField('ID', key: true)",
      "@FoxyFullField('ID')",
    );
    final logs = <String>[];

    await testBuilder(
      foxyKeyBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, '没有物理主键字段'), isTrue);
  });
}
