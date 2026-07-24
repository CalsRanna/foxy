import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('生成全部 Full Entity Mixin 成员并保留字段顺序与常量默认值', () async {
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, standardEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_sample_entity.foxy_entity.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('mixin _CodegenSampleEntityMixin'),
                isNot(contains('int get id;')),
                isNot(contains('String get name;')),
                contains('final self = this as CodegenSampleEntity;'),
                contains('static CodegenSampleEntity fromJson'),
                contains("(json['ID'] as num?)?.toInt() ?? 0"),
                contains("(json['Ratio'] as num?)?.toDouble() ?? 100.0"),
                contains("json['Name']?.toString() ?? ''"),
                contains(
                  "json['Enabled'] == null\n"
                  '          ? false\n'
                  "          : (json['Enabled'] as num).toInt() == 1",
                ),
                contains('String? description'),
                contains('CodegenSampleEntity copyWith'),
                contains('Map<String, dynamic> toJson'),
                contains('bool operator =='),
                contains('Object.hashAll'),
                contains('String toString()'),
              ]),
            ),
      },
    );
  });

  test('不支持 required 参数时给出构建期错误', () async {
    final source = standardEntitySource.replaceFirst(
      'this.id = 0,',
      'required this.id,',
    );
    final logs = <String>[];

    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, 'required 构造参数暂不支持'), isTrue);
  });

  test('重复物理列名时整体生成失败', () async {
    final source = standardEntitySource.replaceFirst(
      "@FoxyFullField('Ratio')",
      "@FoxyFullField('ID')",
    );
    final logs = <String>[];

    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, '重复声明物理列名 ID'), isTrue);
  });

  test('缺少字段注解与不支持类型都不会被静默跳过', () async {
    final missingAnnotation = standardEntitySource.replaceFirst(
      "  @FoxyFullField('Enabled')\n",
      '',
    );
    final missingLogs = <String>[];
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, missingAnnotation),
      outputs: {},
      onLog: (record) => missingLogs.add(record.toString()),
    );
    expect(logContains(missingLogs, 'enabled 缺少 @FoxyFullField'), isTrue);

    final unsupportedType = standardEntitySource.replaceFirst(
      'final String? description;',
      'final List<int>? description;',
    );
    final unsupportedLogs = <String>[];
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, unsupportedType),
      outputs: {},
      onLog: (record) => unsupportedLogs.add(record.toString()),
    );
    expect(logContains(unsupportedLogs, 'List<int>? 暂不支持'), isTrue);
  });

  test('一个输入文件包含多个 Full Entity 时给出拆分诊断', () async {
    final source =
        '$standardEntitySource\n'
        '@FoxyFullEntity(table: \'other\')\n'
        'class OtherEntity {}\n';
    final logs = <String>[];

    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, '当前为 2 个'), isTrue);
  });

  test('调整 class 与 field 注解排列顺序产生相同代码', () async {
    final reordered = standardEntitySource
        .replaceFirst(
          '@FoxyBriefEntity()\n'
              '@FoxyFilterEntity()\n'
              "@FoxyFullEntity(table: 'foxy.codegen_sample')",
          "@FoxyFullEntity(table: 'foxy.codegen_sample')\n"
              '@FoxyFilterEntity()\n'
              '@FoxyBriefEntity()',
        )
        .replaceFirst(
          '@FoxyBriefField()\n'
              '@FoxyFilterField(\n'
              "    defaultValue: '',\n"
              '    type: FoxyFilterFieldType.text,\n'
              '  )\n'
              "@FoxyFullField('ID', key: true)",
          "@FoxyFullField('ID', key: true)\n"
              '@FoxyFilterField(\n'
              "    defaultValue: '',\n"
              '    type: FoxyFilterFieldType.text,\n'
              '  )\n'
              '@FoxyBriefField()',
        );
    const output = 'foxy|lib/entity/codegen_sample_entity.foxy_entity.g.part';
    String? firstSource;
    String? secondSource;
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, standardEntitySource),
      outputs: {
        output: decodedMatches(
          predicate<String>((source) {
            firstSource = source;
            return true;
          }),
        ),
      },
    );
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, reordered),
      outputs: {
        output: decodedMatches(
          predicate<String>((source) {
            secondSource = source;
            return true;
          }),
        ),
      },
    );

    expect(firstSource, secondSource);
  });
}
