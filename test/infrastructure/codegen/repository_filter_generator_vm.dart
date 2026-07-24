import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

const annotationAsset =
    'foxy|lib/infrastructure/codegen/repository_annotations.dart';
const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';

const annotationSource = r'''
enum FoxyFilterFieldType { boolean, decimal, integer, text }

class FoxyRepositoryFilterField {
  final Object defaultValue;
  final String name;
  final FoxyFilterFieldType type;

  const FoxyRepositoryFilterField({
    required this.name,
    required this.type,
    required this.defaultValue,
  });
}

class FoxyRepositoryFilter {
  final List<FoxyRepositoryFilterField> fields;
  final String name;

  const FoxyRepositoryFilter({required this.name, required this.fields});
}
''';

const repositorySource = r'''
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'SampleFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'kind',
      type: FoxyFilterFieldType.integer,
      defaultValue: -1,
    ),
    FoxyRepositoryFilterField(
      name: 'ratio',
      type: FoxyFilterFieldType.decimal,
      defaultValue: 0,
    ),
    FoxyRepositoryFilterField(
      name: 'enabled',
      type: FoxyFilterFieldType.boolean,
      defaultValue: false,
    ),
  ],
)
class SampleRepository {}
''';

void main() {
  test('Repository 注解生成无 Entity 后缀的 Filter DTO', () async {
    await testBuilder(
      foxyRepositoryFilterBuilder(BuilderOptions.empty),
      {annotationAsset: annotationSource, repositoryAsset: repositorySource},
      outputs: {
        'foxy|lib/repository/sample_repository.foxy_repository_filter.g.part':
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

  test('Repository Filter 拒绝 Entity 后缀和重复字段', () async {
    final source = repositorySource
        .replaceFirst("'SampleFilter'", "'SampleFilterEntity'")
        .replaceFirst("name: 'kind'", "name: 'id'");
    final logs = <String>[];

    await testBuilder(
      foxyRepositoryFilterBuilder(BuilderOptions.empty),
      {annotationAsset: annotationSource, repositoryAsset: source},
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('Filter 名称') || log.contains('重复声明')),
      isTrue,
    );
  });

  test('Repository Filter 默认值必须匹配类型', () async {
    final source = repositorySource.replaceFirst(
      "type: FoxyFilterFieldType.integer,\n      defaultValue: -1,",
      "type: FoxyFilterFieldType.integer,\n      defaultValue: '',",
    );
    final logs = <String>[];

    await testBuilder(
      foxyRepositoryFilterBuilder(BuilderOptions.empty),
      {annotationAsset: annotationSource, repositoryAsset: source},
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logs.any((log) => log.contains('默认值')), isTrue);
  });
}
