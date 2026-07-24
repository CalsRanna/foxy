import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

const repositoryAnnotationAsset =
    'foxy|lib/infrastructure/codegen/repository_annotations.dart';
const entityAnnotationAsset =
    'foxy|lib/infrastructure/codegen/entity_annotations.dart';
const entityAsset = 'foxy|lib/entity/sample_entity.dart';
const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';

const repositoryAnnotationSource = r'''
class FoxyRepository {
  final Type entity;

  const FoxyRepository(this.entity);
}

class FoxyFilter {
  final Object defaultValue;
  final String name;
  final Object type;
}
''';

const entityAnnotationSource = r'''
class FoxyFullEntity {
  final String table;

  const FoxyFullEntity({required this.table});
}

class FoxyFullField {
  final String name;
  final bool key;

  const FoxyFullField(this.name, {this.key = false});
}
''';

const scalarEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.sample')
class SampleEntity {
  @FoxyFullField('ID', key: true)
  final int id;

  const SampleEntity({this.id = 0});
}
''';

const scalarRepositorySource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(SampleEntity)
class SampleRepository with _SampleRepositoryMixin {
  static const _table = 'foxy.sample';
}
''';

void main() {
  test('FoxyRepository 生成标准公有 CRUD 与标量物理 Key 定位', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: scalarEntitySource,
        repositoryAsset: scalarRepositorySource,
      },
      outputs: {
        'foxy|lib/repository/sample_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('mixin _SampleRepositoryMixin on RepositoryMixin'),
                contains('Future<void> destroySample(int key)'),
                contains('Future<SampleEntity?> getSample(int key)'),
                contains('Future<void> storeSample(SampleEntity sample)'),
                contains(
                  'Future<void> updateSample('
                  'int originalKey, SampleEntity sample)',
                ),
                contains("laconic.table('foxy.sample')"),
                contains('MysqlErrorUtil.isDuplicateEntry(error)'),
                contains(
                  'QueryBuilder _whereKey(QueryBuilder builder, int key)',
                ),
                contains("return builder.where('ID', key);"),
                isNot(contains('Filter')),
              ]),
            ),
      },
    );
  });

  test('Repository 已有同签名业务方法时只跳过对应标准方法', () async {
    final source = scalarRepositorySource.replaceFirst(
      '  static const _table',
      '''
  Future<SampleEntity?> getSample(int key) async => null;

  static const _table''',
    );

    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: scalarEntitySource,
        repositoryAsset: source,
      },
      outputs: {
        'foxy|lib/repository/sample_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                isNot(contains('Future<SampleEntity?> getSample(')),
                contains('Future<void> destroySample(int key)'),
                contains('Future<void> storeSample(SampleEntity sample)'),
                contains('Future<void> updateSample('),
              ]),
            ),
      },
    );
  });

  test('FoxyRepository 按 Entity 字段顺序生成复合 Key 定位', () async {
    const compositeEntity = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.sample')
class SampleEntity {
  @FoxyFullField('OwnerID', key: true)
  final int ownerId;

  @FoxyFullField('Locale', key: true)
  final String locale;

  const SampleEntity({this.ownerId = 0, this.locale = ''});
}
''';

    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: compositeEntity,
        repositoryAsset: scalarRepositorySource,
      },
      outputs: {
        'foxy|lib/repository/sample_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains(
                  'QueryBuilder _whereKey('
                  'QueryBuilder builder, SampleKey key)',
                ),
                contains("query = query.where('OwnerID', key.ownerId);"),
                contains("query = query.where('Locale', key.locale);"),
              ]),
            ),
      },
    );
  });

  test('Repository 与 Entity base name 不一致时拒绝生成', () async {
    final entity = scalarEntitySource.replaceAll('SampleEntity', 'OtherEntity');
    final source = scalarRepositorySource
        .replaceFirst(
          '@FoxyRepository(SampleEntity)',
          '@FoxyRepository(OtherEntity)',
        )
        .replaceFirst(
          "import 'package:foxy/entity/sample_entity.dart';",
          "import 'package:foxy/entity/sample_entity.dart' show OtherEntity;",
        );
    final logs = <String>[];

    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: entity,
        repositoryAsset: source,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logs.any((log) => log.contains('不符合一对一命名约定')), isTrue);
  });
}
