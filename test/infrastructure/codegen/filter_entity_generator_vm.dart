import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('Filter 使用显式类型、Dart 字段名 JSON key 且不生成 SQL', () async {
    await testBuilder(
      foxyFilterEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, standardEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_sample_entity.filter.g.dart': decodedMatches(
          allOf(<Matcher>[
            contains('final class CodegenSampleFilterEntity'),
            contains('final String id;'),
            contains("this.id = ''"),
            contains("id: json['id']?.toString() ?? ''"),
            contains('CodegenSampleFilterEntity copyWith'),
            contains("'id': id"),
            isNot(contains("'ID'")),
            isNot(contains('WHERE')),
            isNot(contains('comparator')),
          ]),
        ),
      },
    );
  });

  test('Filter 默认值与显式类型不兼容时拒绝生成', () async {
    final source = standardEntitySource.replaceFirst(
      "defaultValue: '',",
      'defaultValue: 1,',
    );
    final logs = <String>[];

    await testBuilder(
      foxyFilterEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, 'Filter 默认值类型不匹配'), isTrue);
  });

  test('字段有 Filter 注解但 class 未启用 Filter 时拒绝生成', () async {
    final source = standardEntitySource.replaceFirst(
      '@FoxyFilterEntity()\n',
      '',
    );
    final logs = <String>[];

    await testBuilder(
      foxyFilterEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, '但 class 没有 @FoxyFilterEntity'), isTrue);
  });
}
