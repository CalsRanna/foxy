import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart' show foxyAnnotationSource;

void main() {
  test('Repeated FoxyFilter annotations generate a filter DTO without the Entity suffix', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {annotationAsset: annotationSource, repositoryAsset: repositorySource},
      outputs: {
        'foxy|lib/repository/sample_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('final class SampleFilter'),
                contains('final String id;'),
                contains('final int kind;'),
                contains('final double ratio;'),
                contains('final bool enabled;'),
                contains("this.id = ''"),
                contains('this.kind = -1'),
                contains('this.ratio = 0.0'),
                contains('this.enabled = false'),
                contains("id: json['id']?.toString() ?? ''"),
                contains("(json['kind'] as num?)?.toInt() ?? -1"),
                contains("(json['ratio'] as num?)?.toDouble() ?? 0.0"),
                contains("json['enabled'] as bool? ?? false"),
                contains('SampleFilter copyWith'),
                contains("'id': id"),
                isNot(contains('WHERE')),
                isNot(contains('Entity')),
              ]),
            ),
      },
    );
  });

  test(
    'Filter names are derived from repositories and duplicate fields fail',
    () async {
      final source = repositorySource.replaceFirst(
        "@FoxyFilter.integer('kind', defaultValue: -1)",
        "@FoxyFilter.integer('id', defaultValue: -1)",
      );
      final logs = <String>[];

      await testBuilder(
        foxyRepositoryBuilder(BuilderOptions.empty),
        {annotationAsset: annotationSource, repositoryAsset: source},
        outputs: {},
        onLog: (record) => logs.add(record.toString()),
      );
      expect(
        logs.any((log) => log.contains('declares field id more than once')),
        isTrue,
      );
    },
  );

  test('Invalid field names produce generation diagnostics', () async {
    final source = repositorySource.replaceFirst(
      "@FoxyFilter.text('id')",
      "@FoxyFilter.text('bad-name')",
    );
    final logs = <String>[];

    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {annotationAsset: annotationSource, repositoryAsset: source},
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any(
        (log) => log.contains('is not a valid lowerCamelCase identifier'),
      ),
      isTrue,
    );
  });
}

const annotationAsset = 'foxy_annotation|lib/repository_annotations.dart';

const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';

const repositorySource = r'''
import 'package:foxy_annotation/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyFilter.text('id')
@FoxyFilter.integer('kind', defaultValue: -1)
@FoxyFilter.decimal('ratio')
@FoxyFilter.boolean('enabled')
class SampleRepository {}
''';

final annotationSource = foxyAnnotationSource('repository_annotations.dart');
