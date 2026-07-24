import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

const annotationAsset =
    'foxy|lib/infrastructure/codegen/repository_annotations.dart';
const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';

const annotationSource = r'''
enum FoxyFilterType { boolean, decimal, integer, text }

class FoxyFilter {
  final Object defaultValue;
  final String name;
  final FoxyFilterType type;

  const FoxyFilter.boolean(this.name, {bool this.defaultValue = false})
    : type = FoxyFilterType.boolean;

  const FoxyFilter.decimal(this.name, {double this.defaultValue = 0.0})
    : type = FoxyFilterType.decimal;

  const FoxyFilter.integer(this.name, {int this.defaultValue = 0})
    : type = FoxyFilterType.integer;

  const FoxyFilter.text(this.name, {String this.defaultValue = ''})
    : type = FoxyFilterType.text;
}

class FoxyRepository {
  final Type entity;

  const FoxyRepository(this.entity);
}
''';

const repositorySource = r'''
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyFilter.text('id')
@FoxyFilter.integer('kind', defaultValue: -1)
@FoxyFilter.decimal('ratio')
@FoxyFilter.boolean('enabled')
class SampleRepository {}
''';

void main() {
  test('可重复 FoxyFilter 注解生成无 Entity 后缀的 Filter DTO', () async {
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

  test('Filter 名称由 Repository 推导且重复字段会失败', () async {
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
    expect(logs.any((log) => log.contains('重复声明字段 id')), isTrue);
  });

  test('非法字段名在生成期给出明确诊断', () async {
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
    expect(logs.any((log) => log.contains('不是合法 lowerCamelCase')), isTrue);
  });
}
