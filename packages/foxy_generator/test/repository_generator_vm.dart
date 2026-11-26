import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('FoxyRepository generates public CRUD and uses the physical scalar key to locate rows', () async {
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
                contains('Future<int> storeSample(SampleEntity sample)'),
                contains('if (sample.id <= 0)'),
                contains(
                  'Future<void> updateSample('
                  'int originalKey, SampleEntity sample)',
                ),
                // The table name is generated as an instance getter
                // (single source of truth from the Entity annotation).
                contains('laconic.table(_table)'),
                contains("String get _table => 'foxy.sample';"),
                contains('MysqlErrorUtil.isDuplicateEntry(error)'),
                contains('final values = sample.toJson();'),
                contains('beforeKey: activityKey(originalKey),'),
                contains('afterKey: activityKey(sample.id),'),
                contains('columns: values.keys,'),
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

  test('Handwritten CRUD can override the generated methods when there is no list page', () async {
    final source = scalarRepositorySource.replaceFirst(
      'class SampleRepository with _SampleRepositoryMixin {',
      '''
class SampleRepository with _SampleRepositoryMixin {
  @override
  Future<SampleEntity?> getSample(int key) async => null;''',
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

  test('List queries generate filtering, projection, and pagination and create preallocates the key', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: briefEntitySource,
        repositoryAsset: filterRepositorySource,
        listViewModelAsset: listViewModelSource,
        listAnnotationAsset: foxyAnnotationSource('list_annotations.dart'),
      },
      outputs: {
        'foxy|lib/repository/sample_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                // count: goes through _applyFilter
                contains('Future<int> countSamples({SampleFilter? filter})'),
                contains('_applyFilter(laconic.table(_table), filter)'),
                contains("String get _table => 'foxy.sample';"),
                // create: key field prefilled via nextMaxPlusOne
                contains('Future<SampleEntity> createSample() async {'),
                contains("id: await nextMaxPlusOne(_table, '`ID`')"),
                // getBrief: brief projection columns + orderBy key +
                // pagination
                contains('Future<List<BriefSampleEntity>> getBriefSamples({'),
                contains("'`ID`',"),
                contains("'`Name`'"),
                contains('builder = builder.orderBy(\'`ID`\');'),
                contains('builder = builder.limit(kPageSize).offset(offset);'),
                // getXxxs: full list
                contains('Future<List<SampleEntity>> getSamples() async {'),
                // _applyFilter: text exact match + explicit column names
                contains(
                  'QueryBuilder _applyFilter('
                  'QueryBuilder builder, SampleFilter? filter)',
                ),
                contains('filter.id'),
                contains("'`Name_lang_zhCN`',"),
                contains('filter.name'),
              ]),
            ),
      },
    );
  });

  test('Names ending in a consonant plus y pluralize with ies', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        propertyEntityAsset: propertyEntitySource,
        propertyRepositoryAsset: propertyRepositorySource,
        propertyListViewModelAsset: propertyListViewModelSource,
        listAnnotationAsset: foxyAnnotationSource('list_annotations.dart'),
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

  test('Query generation rejects a filter with neither a matching entity field nor an explicit column', () async {
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
        listAnnotationAsset: foxyAnnotationSource('list_annotations.dart'),
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('cannot infer a physical column')),
      isTrue,
    );
  });

  test(
    'linkKey generates parent-scoped count, getBrief, create, and copy methods',
    () async {
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
                  // count: parent-key equality, no filter parameter
                  contains(
                    'Future<int> countChildRecords(int parentId) async {',
                  ),
                  contains("where('`ParentID`', parentId)"),
                  isNot(contains('filter')),
                  // getBrief: parent-key filter + pagination
                  contains('Future<List<BriefChildRecordEntity>>'),
                  contains('getBriefChildRecords('),
                  contains("builder = builder.where('`ParentID`', parentId);"),
                  // create: parent-key fields use the passed values, other
                  // key fields use nextMaxPlusOne (where carries the parent
                  // key)
                  contains(
                    'Future<ChildRecordEntity> createChildRecord(int parentId) async {',
                  ),
                  contains('parentId: parentId,'),
                  contains('childId: await nextMaxPlusOne('),
                  contains("'`ChildID`',"),
                  // _linkWhereMap backticks columns (laconic does not escape
                  // identifiers; reserved-word link columns need quoting).
                  contains("where: {'`ParentID`': parentId}"),
                  // copy: create carrying the parent key
                  contains(
                    'final blank = await createChildRecord(source.parentId);',
                  ),
                  // Child tables generate no full list or _applyFilter
                  isNot(contains('getChildren()')),
                  isNot(contains('_applyFilter')),
                ]),
              ),
        },
      );
    },
  );

  test('Generation rejects a linkKey that names a non-key field', () async {
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
      logs.any(
        (log) => log.contains('is not a key field of ChildRecordEntity'),
      ),
      isTrue,
    );
  });

  test(
    'DbcLocaleRepositoryMixin adds locale helpers and widens the on clauses',
    () async {
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
                  contains(
                    'Future<List<DbcLocaleFieldValue>> getLocaleLocales(',
                  ),
                  contains('loadDbcLocaleField(id, field);'),
                  contains('Future<void> saveLocaleLocales('),
                  contains('storeDbcLocaleField(id, field, locales);'),
                ]),
              ),
        },
      );
    },
  );

  test('FoxyRepository locates rows using every physical column of a composite key', () async {
    const compositeEntity = r'''
import 'package:foxy_annotation/entity_annotations.dart';

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

  test('CRUD generation rejects nullable entity key fields', () async {
    const nullableKeyEntity = r'''
import 'package:foxy_annotation/entity_annotations.dart';

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
      logs.any(
        (log) =>
            log.contains('cannot serve as the physical Key for generated CRUD'),
      ),
      isTrue,
      reason: '`列 = NULL` 恒不成立，生成的 _whereKey 会静默匹配 0 行',
    );
  });

  test(
    'Generation rejects mismatched repository and entity base names',
    () async {
      final entity = scalarEntitySource.replaceAll(
        'SampleEntity',
        'OtherEntity',
      );
      final source = scalarRepositorySource
          .replaceFirst(
            '@FoxyRepository(entity: SampleEntity)',
            '@FoxyRepository(entity: OtherEntity)',
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
      expect(
        logs.any(
          (log) =>
              log.contains('do not follow the one-to-one naming convention'),
        ),
        isTrue,
      );
    },
  );

  test('Handwritten count and getBrief overrides allow valid SQL for aliased filters', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: briefEntitySource,
        repositoryAsset: dottedFilterRepositorySource,
        listViewModelAsset: listViewModelSource,
        listAnnotationAsset: foxyAnnotationSource('list_annotations.dart'),
      },
      outputs: {
        'foxy|lib/repository/sample_repository.foxy_repository.g.part':
            decodedMatches(
              allOf(<Matcher>[
                // A dotted column is a qualified reference: each segment is
                // backticked (`it`.`name`), never a single `it.name` id.
                contains("'`it`.`name`'"),
                contains('filter.name'),
                contains("String get _table => 'foxy.sample';"),
              ]),
            ),
      },
    );
  });

  test('An aliased filter requires a handwritten count override', () async {
    final logs = <String>[];
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: briefEntitySource,
        repositoryAsset: dottedFilterRepositorySource.replaceFirst(
          '  @override\n'
              '  Future<int> countSamples({SampleFilter? filter}) async => 0;\n\n',
          '',
        ),
        listViewModelAsset: listViewModelSource,
        listAnnotationAsset: foxyAnnotationSource('list_annotations.dart'),
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('countSamples must be hand-written')),
      isTrue,
      reason: '主表 count 走 _applyFilter，别名列查询无法由生成器表达',
    );
  });

  test('An aliased filter requires a handwritten getBrief override', () async {
    final logs = <String>[];
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        entityAsset: briefEntitySource,
        repositoryAsset: dottedFilterRepositorySource.replaceFirst(
          '  @override\n'
              '  Future<List<BriefSampleEntity>> getBriefSamples({\n'
              '    int page = 1,\n'
              '    SampleFilter? filter,\n'
              '  }) async => [];',
          '',
        ),
        listViewModelAsset: listViewModelSource,
        listAnnotationAsset: foxyAnnotationSource('list_annotations.dart'),
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('getBriefSamples must be hand-written')),
      isTrue,
    );
  });

  test(
    'A class-level brief alias requires a handwritten getBrief override',
    () async {
      final logs = <String>[];
      await testBuilder(
        foxyRepositoryBuilder(BuilderOptions.empty),
        {
          repositoryAnnotationAsset: repositoryAnnotationSource,
          entityAnnotationAsset: entityAnnotationSource,
          entityAsset: aliasBriefEntitySource,
          repositoryAsset: filterRepositorySource,
          listViewModelAsset: listViewModelSource,
          listAnnotationAsset: foxyAnnotationSource('list_annotations.dart'),
        },
        outputs: {},
        onLog: (record) => logs.add(record.toString()),
      );
      expect(
        logs.any(
          (log) =>
              log.contains('getBriefSamples must be hand-written') &&
              log.contains('Brief projection fields'),
        ),
        isTrue,
        reason: '类级 @FoxyBriefField.* 是 JOIN 别名，生成器无法填充',
      );
    },
  );

  test(
    'Generation rejects a handwritten _table so the table name has one source',
    () async {
      final repository = scalarRepositorySource.replaceFirst(
        'class SampleRepository with _SampleRepositoryMixin {}',
        '''
class SampleRepository with _SampleRepositoryMixin {
  static const _table = 'foxy.sample';
}''',
      );
      final logs = <String>[];
      await testBuilder(
        foxyRepositoryBuilder(BuilderOptions.empty),
        {
          repositoryAnnotationAsset: repositoryAnnotationSource,
          entityAnnotationAsset: entityAnnotationSource,
          entityAsset: scalarEntitySource,
          repositoryAsset: repository,
        },
        outputs: {},
        onLog: (record) => logs.add(record.toString()),
      );
      expect(
        logs.any((log) => log.contains('Remove the _table member')),
        isTrue,
      );
    },
  );
}

/// Entity whose Brief declares a class-level projection alias
/// (`localeName`): the alias comes from a JOINed table the generator cannot
/// express, so getBrief must be hand-written (validated by the reader).
const aliasBriefEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('localeName')
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

/// Entity with a Brief projection and key, for query-layer generation
/// tests.
const briefEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

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
const childEntityAsset = 'foxy|lib/entity/child_record_entity.dart';

/// Child-table entity: parent key ParentID + auto-increment ChildID.
const childEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

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

  const ChildRecordEntity({
    this.parentId = 0,
    this.childId = 0,
    this.note = '',
  });
}
''';
const childRepositoryAsset = 'foxy|lib/repository/child_record_repository.dart';

/// Child-table repository declaring linkKey.
const childRepositorySource = r'''
import 'package:foxy/entity/child_record_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'child_record_repository.g.dart';

@FoxyRepository(entity: ChildRecordEntity, linkKey: ['parentId'])
class ChildRecordRepository with _ChildRecordRepositoryMixin {}
''';

const dbcLocaleMixinAsset =
    'foxy|lib/repository/dbc_locale_repository_mixin.dart';

/// Repository declaring a filter on a JOINed table (dotted column): the
/// query layer cannot express the JOIN, so count/getBrief must be
/// hand-written (validated by the reader).
const dottedFilterRepositorySource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(entity: SampleEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'it.name')
class SampleRepository with _SampleRepositoryMixin {
  @override
  Future<int> countSamples({SampleFilter? filter}) async => 0;

  @override
  Future<List<BriefSampleEntity>> getBriefSamples({
    int page = 1,
    SampleFilter? filter,
  }) async => [];
}
''';

const entityAnnotationAsset = 'foxy_annotation|lib/entity_annotations.dart';
const entityAsset = 'foxy|lib/entity/sample_entity.dart';

/// Repository declaring a text filter (with explicit column), for
/// query-layer generation tests.
const filterRepositorySource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(entity: SampleEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'Name_lang_zhCN')
class SampleRepository with _SampleRepositoryMixin {}
''';
const listAnnotationAsset = 'foxy_annotation|lib/list_annotations.dart';
const listViewModelAsset = 'foxy|lib/view_model/sample_list_view_model.dart';

/// List-page presence marker: the Repository generator must enable the
/// query layer only when the list ViewModel actually declares
/// `@FoxyListViewModel` (a shape check, not mere file existence).
const listViewModelSource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy/repository/sample_repository.dart';
import 'package:foxy_annotation/list_annotations.dart';

@FoxyListViewModel(
  entity: SampleEntity,
  repository: SampleRepository,
)
class SampleListViewModel {}
''';
const localeEntityAsset = 'foxy|lib/entity/locale_entity.dart';

/// Repository mixing in DbcLocaleRepositoryMixin (the locale-helper
/// generation trigger).
const localeEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.sample')
class LocaleEntity {
  @FoxyFullField('ID', key: true)
  final int id;

  const LocaleEntity({this.id = 0});
}
''';

const localeRepositoryAsset = 'foxy|lib/repository/locale_repository.dart';

const localeRepositorySource = r'''
import 'package:foxy/entity/locale_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';

part 'locale_repository.g.dart';

@FoxyRepository(entity: LocaleEntity)
class LocaleRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _LocaleRepositoryMixin {
  @override
  String get dbcLocaleTableName => _table;
}
''';

const propertyEntityAsset = 'foxy|lib/entity/sample_property_entity.dart';

/// Consonant + y base name (SampleProperty → SampleProperties).
const propertyEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

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

const propertyListViewModelAsset =
    'foxy|lib/view_model/sample_property_list_view_model.dart';

/// Property-flavoured list ViewModel for the y→ies pluralization test.
const propertyListViewModelSource = r'''
import 'package:foxy/entity/sample_property_entity.dart';
import 'package:foxy/repository/sample_property_repository.dart';
import 'package:foxy_annotation/list_annotations.dart';

@FoxyListViewModel(
  entity: SamplePropertyEntity,
  repository: SamplePropertyRepository,
)
class SamplePropertyListViewModel {}
''';

const propertyRepositoryAsset =
    'foxy|lib/repository/sample_property_repository.dart';

const propertyRepositorySource = r'''
import 'package:foxy/entity/sample_property_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'sample_property_repository.g.dart';

@FoxyRepository(entity: SamplePropertyEntity)
@FoxyFilter.text('id')
class SamplePropertyRepository with _SamplePropertyRepositoryMixin {}
''';

const repositoryAnnotationAsset =
    'foxy_annotation|lib/repository_annotations.dart';

const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';

const repositoryMixinAsset = 'foxy|lib/repository/repository_mixin.dart';

const scalarEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.sample')
class SampleEntity {
  @FoxyFullField('ID', key: true)
  final int id;

  const SampleEntity({this.id = 0});
}
''';

const scalarRepositorySource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(entity: SampleEntity)
class SampleRepository with _SampleRepositoryMixin {}
''';

final dbcLocaleMixinSource = foxyAppSource(
  'repository/dbc_locale_repository_mixin.dart',
);

final entityAnnotationSource = foxyAnnotationSource('entity_annotations.dart');

/// Reads the real annotation source directly instead of keeping a
/// hand-copied duplicate in tests.
///
/// Copies silently drift when annotations gain parameters or change
/// defaults, letting tests pass against stale definitions. Tests run from
/// the foxy_generator package root.
final repositoryAnnotationSource = foxyAnnotationSource(
  'repository_annotations.dart',
);

final repositoryMixinSource = foxyAppSource('repository/repository_mixin.dart');
