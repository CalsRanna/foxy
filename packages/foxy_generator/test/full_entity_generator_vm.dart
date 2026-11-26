import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('fromJson uses physical column names and preserves scalar conversions and constructor defaults', () async {
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, standardEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_sample_entity.foxy_entity.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains("(json['ID'] as num?)?.toInt() ?? 0"),
                contains("(json['Ratio'] as num?)?.toDouble() ?? 100.0"),
                contains("json['Name']?.toString() ?? ''"),
                contains(
                  "json['Enabled'] == null\n"
                  '          ? false\n'
                  "          : (json['Enabled'] == true || json['Enabled'] == 1)",
                ),
                contains('String? description'),
              ]),
            ),
      },
    );
  });

  test(
    'An unsupported required parameter produces a build-time error',
    () async {
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
      expect(
        logContains(
          logs,
          'Required constructor parameters are not yet supported',
        ),
        isTrue,
      );
    },
  );

  test('Duplicate physical column names fail generation', () async {
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
    expect(
      logContains(logs, 'declares the physical column name ID more than once'),
      isTrue,
    );
  });

  test(
    'Missing field annotations and unsupported field types are reported',
    () async {
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
      expect(
        logContains(missingLogs, 'enabled is missing @FoxyFullField'),
        isTrue,
      );

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
      expect(
        logContains(
          unsupportedLogs,
          'The type List<int>? of CodegenSampleEntity.description '
          'is not yet supported',
        ),
        isTrue,
      );
    },
  );

  test('Multiple full entities in one source file produce a diagnostic to split the file', () async {
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
    expect(logContains(logs, 'it currently declares 2.'), isTrue);
  });

  test(
    'Reordering class and field annotations produces identical code',
    () async {
      final reordered = standardEntitySource
          .replaceFirst(
            '@FoxyBriefEntity()\n'
                "@FoxyFullEntity(table: 'foxy.codegen_sample')",
            "@FoxyFullEntity(table: 'foxy.codegen_sample')\n"
                '@FoxyBriefEntity()',
          )
          .replaceFirst(
            '  @FoxyBriefField()\n'
                "  @FoxyFullField('ID', key: true)",
            "  @FoxyFullField('ID', key: true)\n"
                '  @FoxyBriefField()',
          );
      expect(
        reordered,
        contains(
          "@FoxyFullEntity(table: 'foxy.codegen_sample')\n"
          '@FoxyBriefEntity()',
        ),
      );
      expect(
        reordered,
        contains(
          "  @FoxyFullField('ID', key: true)\n"
          '  @FoxyBriefField()\n'
          '  final int id;',
        ),
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
    },
  );

  test(
    'AST validation accepts a block-bodied fromJson factory with delegation',
    () async {
      // The old source-text regex required the exact arrow form; the AST
      // check accepts any formatting that still delegates to the mixin.
      final blockBody = standardEntitySource.replaceFirst(
        '  factory CodegenSampleEntity.fromJson(Map<String, dynamic> json) =>\n'
            '      _CodegenSampleEntityMixin.fromJson(json);',
        '  factory CodegenSampleEntity.fromJson(Map<String, dynamic> json) {\n'
            '    return _CodegenSampleEntityMixin.fromJson(json);\n'
            '  }',
      );
      const output = 'foxy|lib/entity/codegen_sample_entity.foxy_entity.g.part';

      await testBuilder(
        foxyEntityBuilder(BuilderOptions.empty),
        sourceAsset(standardEntityAsset, blockBody),
        outputs: {
          output: decodedMatches(
            contains('static CodegenSampleEntity fromJson'),
          ),
        },
      );
    },
  );

  test('A missing fromJson delegate produces a build-time error', () async {
    final missing = standardEntitySource.replaceFirst(
      '  factory CodegenSampleEntity.fromJson(Map<String, dynamic> json) =>\n'
          '      _CodegenSampleEntityMixin.fromJson(json);',
      '  factory CodegenSampleEntity.fromJson(Map<String, dynamic> json) {\n'
          '    return CodegenSampleEntity();\n'
          '  }',
    );
    final logs = <String>[];
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, missing),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logContains(logs, 'must keep the fromJson factory delegating'),
      isTrue,
    );
  });
}
