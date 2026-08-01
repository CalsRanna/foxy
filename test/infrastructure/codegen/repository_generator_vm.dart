import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

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
                contains('if (sample.id <= 0)'),
                contains(
                  'Future<void> updateSample('
                  'int originalKey, SampleEntity sample)',
                ),
                contains("laconic.table('foxy.sample')"),
                contains('MysqlErrorUtil.isDuplicateEntry(error)'),
                contains('prepareWriteJson(sample.toJson())'),
                contains('Future<void> _beforeDestroy(int key) async {}'),
                contains(
                  'QueryBuilder _whereKey(QueryBuilder builder, int key)',
                ),
                contains(r"return builder.where('`ID`', key);"),
                isNot(contains('Filter')),
              ]),
            ),
      },
    );
  });

  test('Repository 已有手写标准 CRUD 时拒绝生成', () async {
    final source = scalarRepositorySource.replaceFirst(
      '  static const _table',
      '''
  Future<SampleEntity?> getSample(int key) async => null;

  static const _table''',
    );

    final logs = <String>[];
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: scalarEntitySource,
        repositoryAsset: source,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logs.any((log) => log.contains('不允许手写标准 CRUD')), isTrue);
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
                contains(r"query = query.where('`OwnerID`', key.ownerId);"),
                contains(r"query = query.where('`Locale`', key.locale);"),
              ]),
            ),
      },
    );
  });

  test('Entity 的 nullable key 字段拒绝生成 CRUD', () async {
    const nullableKeyEntity = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.sample')
class SampleEntity {
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Note', key: true)
  final String? note;

  const SampleEntity({this.id = 0, this.note});
}
''';

    final logs = <String>[];
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: nullableKeyEntity,
        repositoryAsset: scalarRepositorySource,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('不能作为生成 CRUD 的物理 Key')),
      isTrue,
      reason: '`列 = NULL` 恒不成立，生成的 _whereKey 会静默匹配 0 行',
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
const entityAnnotationAsset =
    'foxy|lib/infrastructure/codegen/entity_annotations.dart';
const entityAsset = 'foxy|lib/entity/sample_entity.dart';
const repositoryAnnotationAsset =
    'foxy|lib/infrastructure/codegen/repository_annotations.dart';

const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';

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

final entityAnnotationSource = File(
  'lib/infrastructure/codegen/entity_annotations.dart',
).readAsStringSync();

/// 直接读取真实注解源码，而不是在测试里维护手抄副本。
///
/// 副本会在注解新增参数或改默认值后悄悄失真，让测试对着旧定义通过。
/// 测试从仓库根目录运行（见 AGENTS.md）。
final repositoryAnnotationSource = File(
  'lib/infrastructure/codegen/repository_annotations.dart',
).readAsStringSync();
