import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('Brief 只包含选中字段、复用 Full 默认值且不暴露写模型 API', () async {
    await testBuilder(
      foxyBriefEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, standardEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_sample_entity.brief.g.dart': decodedMatches(
          allOf(<Matcher>[
            contains('final class BriefCodegenSampleEntity'),
            contains('final int id;'),
            contains('final double ratio;'),
            contains('final String name;'),
            isNot(contains('final bool enabled;')),
            contains('this.ratio = 100.0'),
            contains("(json['ID'] as num?)?.toInt() ?? 0"),
            contains('int get key => id;'),
            isNot(contains('copyWith')),
            isNot(contains('toJson')),
          ]),
        ),
      },
    );
  });

  test('复合身份 Brief 直接由 Full 元数据构建 typed key', () async {
    await testBuilder(
      foxyBriefEntityBuilder(BuilderOptions.empty),
      sourceAsset(compositeEntityAsset, compositeEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_relation_entity.brief.g.dart': decodedMatches(
          allOf(<Matcher>[
            contains("import 'codegen_relation_entity.key.g.dart';"),
            contains('CodegenRelationKey get key'),
            contains('ownerId: ownerId'),
            contains('locale: locale'),
          ]),
        ),
      },
    );
  });

  test('Brief 缺少任一 key 字段时拒绝生成', () async {
    final source = compositeEntitySource.replaceFirst(
      '@FoxyBriefField()\n  @FoxyFullField(\'Locale\', key: true)',
      '@FoxyFullField(\'Locale\', key: true)',
    );
    final logs = <String>[];

    await testBuilder(
      foxyBriefEntityBuilder(BuilderOptions.empty),
      sourceAsset(compositeEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, '缺少完整物理身份'), isTrue);
  });
}
