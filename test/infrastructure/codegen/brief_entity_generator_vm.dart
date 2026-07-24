import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('Brief 只包含选中字段、复用 Full 默认值且不暴露写模型 API', () async {
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, standardEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_sample_entity.foxy_entity.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('final class BriefCodegenSampleEntity'),
                contains('final int id;'),
                contains('final double ratio;'),
                contains('final String name;'),
                isNot(contains('final bool enabled;')),
                contains('this.ratio = 100.0'),
                contains("(json['ID'] as num?)?.toInt() ?? 0"),
                contains('int get key => id;'),
                predicate<String>((source) {
                  final briefSource = source.substring(
                    source.indexOf('final class BriefCodegenSampleEntity'),
                  );
                  return !briefSource.contains('copyWith') &&
                      !briefSource.contains('toJson');
                }, 'Brief 不包含 copyWith/toJson'),
              ]),
            ),
      },
    );
  });

  test('复合身份 Brief 直接由 Full 元数据构建 typed key', () async {
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(compositeEntityAsset, compositeEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_relation_entity.foxy_entity.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('final class CodegenRelationKey'),
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
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(compositeEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, '缺少完整物理身份'), isTrue);
  });

  test('class 上的具名 FoxyBriefField 只生成 Brief 投影字段', () async {
    final source = standardEntitySource.replaceFirst(
      '@FoxyBriefEntity()',
      "@FoxyBriefEntity()\n"
          "@FoxyBriefField.boolean('active')\n"
          "@FoxyBriefField.decimal('score')\n"
          "@FoxyBriefField.text('localeName')\n"
          "@FoxyBriefField.integer('quality', defaultValue: -1)",
    );

    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {
        'foxy|lib/entity/codegen_sample_entity.foxy_entity.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('final bool active;'),
                contains('final double score;'),
                contains('final String localeName;'),
                contains('final int quality;'),
                contains('this.active = false'),
                contains('this.score = 0.0'),
                contains("this.localeName = ''"),
                contains('this.quality = -1'),
                contains(
                  "active: json['active'] == null\n"
                  "          ? false\n"
                  "          : (json['active'] as num).toInt() == 1",
                ),
                contains("(json['score'] as num?)?.toDouble() ?? 0.0"),
                contains("json['localeName']?.toString() ?? ''"),
                contains("(json['quality'] as num?)?.toInt() ?? -1"),
                predicate<String>((source) {
                  final fullSource = source.substring(
                    0,
                    source.indexOf('final class BriefCodegenSampleEntity'),
                  );
                  return !fullSource.contains('active') &&
                      !fullSource.contains('score') &&
                      !fullSource.contains('localeName') &&
                      !fullSource.contains('quality');
                }, '投影字段不进入 Full Mixin'),
              ]),
            ),
      },
    );
  });

  test('Brief 投影字段与 Full 字段重名时拒绝生成', () async {
    final source = standardEntitySource.replaceFirst(
      '@FoxyBriefEntity()',
      "@FoxyBriefEntity()\n@FoxyBriefField.text('name')",
    );
    final logs = <String>[];

    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, '重复声明 Brief 字段 name'), isTrue);
  });
}
