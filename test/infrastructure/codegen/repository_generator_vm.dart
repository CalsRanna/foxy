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

  test('无列表页时手写 CRUD 合法(壳 override 生成版)', () async {
    final source = scalarRepositorySource.replaceFirst(
      '  static const _table',
      '''
  @override
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
              contains('Future<SampleEntity?> getSample(int key) async {'),
            ),
      },
    );
  });

  test('有列表页时生成查询层(create/copy/getBrief/count/getXxxs/_applyFilter)', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: briefEntitySource,
        repositoryAsset: filterRepositorySource,
        listViewModelAsset: listViewModelSource,
      },
      outputs: {
        'foxy|lib/repository/sample_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                // copy:get + create + copyWith 新 key + store,返回新 key
                contains('Future<int> copySample(int key) async {'),
                contains('final blank = await createSample();'),
                contains('final copied = source.copyWith(id: blank.id);'),
                contains('return copied.id;'),
                // count:走 _applyFilter
                contains('Future<int> countSamples({SampleFilter? filter})'),
                contains(
                  '_applyFilter(laconic.table(\'foxy.sample\'), filter)',
                ),
                // create:key 字段 nextMaxPlusOne 预分配
                contains('Future<SampleEntity> createSample() async {'),
                contains("id: await nextMaxPlusOne('foxy.sample', '`ID`')"),
                // getBrief:brief 投影列 + orderBy key + 分页
                contains('Future<List<BriefSampleEntity>> getBriefSamples({'),
                contains("'`ID`',"),
                contains("'`Name`'"),
                contains('builder = builder.orderBy(\'`ID`\');'),
                contains('builder = builder.limit(kPageSize).offset(offset);'),
                // getXxxs:全量列表
                contains('Future<List<SampleEntity>> getSamples() async {'),
                // _applyFilter:text 精确匹配 + column 显式列名
                contains(
                  'QueryBuilder _applyFilter('
                  'QueryBuilder builder, SampleFilter? filter)',
                ),
                contains("'`ID`',"),
                contains('filter.id'),
                contains("'`Name_lang_zhCN`',"),
                contains('filter.name'),
              ]),
            ),
      },
    );
  });

  test('辅音 + y 结尾的 base name 按 y → ies 复数化', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        propertyEntityAsset: propertyEntitySource,
        propertyRepositoryAsset: propertyRepositorySource,
        propertyListViewModelAsset: listViewModelSource,
      },
      outputs: {
        'foxy|lib/repository/sample_property_repository'
            '.foxy_repository.g.part': decodedMatches(
          allOf(<Matcher>[
            contains('Future<int> countSampleProperties('),
            contains(
              'Future<List<BriefSamplePropertyEntity>> '
              'getBriefSampleProperties({',
            ),
            contains(
              'Future<List<SamplePropertyEntity>> '
              'getSampleProperties() async {',
            ),
            isNot(contains('countSamplePropertys')),
          ]),
        ),
      },
    );
  });

  test('filter 无同名实体字段且未声明 column 时拒绝生成查询层', () async {
    final repository = filterRepositorySource.replaceFirst(
      "@FoxyFilter.text('name', column: 'Name_lang_zhCN')",
      "@FoxyFilter.text('unknown')",
    );

    final logs = <String>[];
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: briefEntitySource,
        repositoryAsset: repository,
        listViewModelAsset: listViewModelSource,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logs.any((log) => log.contains('无法推断物理列')), isTrue);
  });

  test('声明 linkKey 时生成父键形态(count/getBrief/create/copy)', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        childEntityAsset: childEntitySource,
        childRepositoryAsset: childRepositorySource,
      },
      outputs: {
        'foxy|lib/repository/child_record_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                // count:父键等值,无 filter 参数
                contains('Future<int> countChildRecords(int parentId) async {'),
                contains("where('`ParentID`', parentId)"),
                isNot(contains('filter')),
                // getBrief:父键过滤 + 分页
                contains('Future<List<BriefChildRecordEntity>>'),
                contains('getBriefChildRecords('),
                contains("builder = builder.where('`ParentID`', parentId);"),
                // create:父键字段用传入值,其余 key 字段 nextMaxPlusOne(where 带父键)
                contains(
                  'Future<ChildRecordEntity> createChildRecord(int parentId) async {',
                ),
                contains('parentId: parentId,'),
                contains('childId: await nextMaxPlusOne('),
                contains("'`ChildID`',"),
                contains("where: {'ParentID': parentId}"),
                // copy:create 带父键
                contains(
                  'final blank = await createChildRecord(source.parentId);',
                ),
                // 子表不生成全量列表与 _applyFilter
                isNot(contains('getChildren()')),
                isNot(contains('_applyFilter')),
              ]),
            ),
      },
    );
  });

  test('linkKey 指向非 key 字段时拒绝生成', () async {
    final repository = childRepositorySource.replaceFirst(
      "linkKey: ['parentId']",
      "linkKey: ['note']",
    );
    final logs = <String>[];
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        childEntityAsset: childEntitySource,
        childRepositoryAsset: repository,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('不是 ChildRecordEntity 的 key 字段')),
      isTrue,
    );
  });

  test('混入 DbcLocaleRepositoryMixin 时生成 locale helper 并扩宽 on 子句', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        localeEntityAsset: localeEntitySource,
        localeRepositoryAsset: localeRepositorySource,
        repositoryMixinAsset: repositoryMixinSource,
        dbcLocaleMixinAsset: dbcLocaleMixinSource,
      },
      outputs: {
        'foxy|lib/repository/locale_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains(
                  'mixin _LocaleRepositoryMixin on '
                  'RepositoryMixin, DbcLocaleRepositoryMixin {',
                ),
                contains('Future<List<DbcLocaleFieldValue>> getLocaleLocales('),
                contains('loadDbcLocaleField(id, field);'),
                contains('loadDbcLocaleField(id, field);'),
                contains('Future<void> saveLocaleLocales('),
                contains('storeDbcLocaleField(id, field, locales);'),
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
const listViewModelAsset = 'foxy|lib/view_model/sample_list_view_model.dart';
const propertyEntityAsset = 'foxy|lib/entity/sample_property_entity.dart';
const repositoryAnnotationAsset =
    'foxy|lib/infrastructure/codegen/repository_annotations.dart';

const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';

const propertyRepositoryAsset =
    'foxy|lib/repository/sample_property_repository.dart';

const repositoryMixinAsset = 'foxy|lib/repository/repository_mixin.dart';
const dbcLocaleMixinAsset =
    'foxy|lib/repository/dbc_locale_repository_mixin.dart';
const childEntityAsset = 'foxy|lib/entity/child_record_entity.dart';
const childRepositoryAsset = 'foxy|lib/repository/child_record_repository.dart';
const localeEntityAsset = 'foxy|lib/entity/locale_entity.dart';
const localeRepositoryAsset = 'foxy|lib/repository/locale_repository.dart';
const propertyListViewModelAsset =
    'foxy|lib/view_model/sample_property_list_view_model.dart';

/// 辅音 + y 结尾的 base name(SampleProperty → SampleProperties)。
const propertyEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.sample')
class SamplePropertyEntity {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Name')
  final String name;

  const SamplePropertyEntity({this.id = 0, this.name = ''});
}
''';

const propertyRepositorySource = r'''
import 'package:foxy/entity/sample_property_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'sample_property_repository.g.dart';

@FoxyRepository(SamplePropertyEntity)
@FoxyFilter.text('id')
class SamplePropertyRepository with _SamplePropertyRepositoryMixin {
  static const _table = 'foxy.sample';
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

/// 带 Brief 投影与 key 的实体,供查询层生成测试使用。
const briefEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.sample')
class SampleEntity {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Name')
  final String name;

  const SampleEntity({this.id = 0, this.name = ''});
}
''';

/// 声明 text filter(含显式 column)的仓库,供查询层生成测试使用。
const filterRepositorySource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(SampleEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'Name_lang_zhCN')
class SampleRepository with _SampleRepositoryMixin {
  static const _table = 'foxy.sample';
}
''';

/// 列表页存在标记:Repository 生成器只检查文件存在性,不解析内容。
/// 不用真实 `@FoxyListViewModel` 源码,避免 testBuilder 里 list_annotations
/// 的 meta 依赖导致注解无法解析、整次构建失败。
const listViewModelSource = r'''
// 仅作为「存在列表页」标记。
class SampleListViewModel {}
''';

/// 子表实体:父键 ParentID + 自增 ChildID。
const childEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.child')
class ChildRecordEntity {
  @FoxyBriefField()
  @FoxyFullField('ParentID', key: true)
  final int parentId;

  @FoxyBriefField()
  @FoxyFullField('ChildID', key: true)
  final int childId;

  @FoxyBriefField()
  @FoxyFullField('Note')
  final String note;

  const ChildEntity({this.parentId = 0, this.childId = 0, this.note = ''});
}
''';

/// 声明 linkKey 的子表仓库。
const childRepositorySource = r'''
import 'package:foxy/entity/child_record_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'child_record_repository.g.dart';

@FoxyRepository(ChildRecordEntity, linkKey: ['parentId'])
class ChildRecordRepository with _ChildRecordRepositoryMixin {
  static const _table = 'foxy.child';
}
''';

/// 混入 DbcLocaleRepositoryMixin 的仓库(locale helper 生成触发条件)。
const localeEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.sample')
class LocaleEntity {
  @FoxyFullField('ID', key: true)
  final int id;

  const LocaleEntity({this.id = 0});
}
''';

const localeRepositorySource = r'''
import 'package:foxy/entity/locale_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';

part 'locale_repository.g.dart';

@FoxyRepository(LocaleEntity)
class LocaleRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _LocaleRepositoryMixin {
  static const _table = 'foxy.sample';

  @override
  String get dbcLocaleTableName => _table;
}
''';

final repositoryMixinSource = File(
  'lib/repository/repository_mixin.dart',
).readAsStringSync();

final dbcLocaleMixinSource = File(
  'lib/repository/dbc_locale_repository_mixin.dart',
).readAsStringSync();

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
