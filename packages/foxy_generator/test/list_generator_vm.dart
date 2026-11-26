import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('List generation supports filter reset, page fallback after delete, and activity for nameless entities', () async {
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: sampleEntitySource,
        repositoryAsset: sampleRepositorySource,
        viewModelAsset: sampleViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/sample_list_view_model.foxy_view_model.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains("entryController.init('');"),
                contains("nameController.init('');"),
                contains('page.value = 1;'),
                contains('markQueryVersion();'),
                contains('normalizePageAfterDelete(total.value - 1);'),
                contains('_logActivity(ActivityActionType.delete, key);'),
                contains("module: 'sample',"),
                contains('entityName: key.toString(),'),
              ]),
            ),
      },
    );
  });

  test('For entities with a name, _logActivity queries by key to resolve it', () async {
    final entity = sampleEntitySource.replaceFirst(
      '  const SampleEntity({this.id = 0});',
      "  @FoxyFullField('Name')\n"
          "  final String name;\n\n"
          "  const SampleEntity({this.id = 0, this.name = ''});",
    );

    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: entity,
        repositoryAsset: sampleRepositorySource,
        viewModelAsset: sampleViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/sample_list_view_model.foxy_view_model.g.part':
            decodedMatches(
              allOf(<Matcher>[
                // Load the record before deletion so the log can include its name.
                contains('final record = await _repository.getSample(key);'),
                contains(
                  'await _logActivity(ActivityActionType.delete, key, record);',
                ),
                contains('await _logActivity(ActivityActionType.copy, key);'),
                contains(
                  'final resolved = record ?? '
                  'await _repository.getSample(key);',
                ),
                contains('resolved.name.isNotEmpty'),
                contains('? resolved.name'),
                contains("entityName: entityName,"),
              ]),
            ),
      },
    );
  });

  test('For entities with only nameLangZhCN, _logActivity uses the locale candidate field', () async {
    final entity = sampleEntitySource.replaceFirst(
      '  const SampleEntity({this.id = 0});',
      "  @FoxyFullField('Name_lang_zhCN')\n"
          "  final String nameLangZhCN;\n\n"
          "  const SampleEntity({this.id = 0, this.nameLangZhCN = ''});",
    );

    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: entity,
        repositoryAsset: sampleRepositorySource,
        viewModelAsset: sampleViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/sample_list_view_model.foxy_view_model.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('resolved.nameLangZhCN.isNotEmpty'),
                contains('? resolved.nameLangZhCN'),
              ]),
            ),
      },
    );
  });

  test('An id filter generates a controller named idController', () async {
    final repository = sampleRepositorySource.replaceFirst(
      "@FoxyFilter.text('entry')",
      "@FoxyFilter.text('id')",
    );

    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: sampleEntitySource,
        repositoryAsset: repository,
        viewModelAsset: sampleViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/sample_list_view_model.foxy_view_model.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains(
                  'late final idController = '
                  'registerController(StringFieldController());',
                ),
                contains("idController.init('');"),
                contains('id: idController.collect(),'),
                contains('late final nameController = '),
                isNot(contains('entryController')),
              ]),
            ),
      },
    );
  });

  test(
    'For composite keys, copy and destroy take an XxxKey parameter',
    () async {
      final entity = sampleEntitySource.replaceFirst(
        "  const SampleEntity({this.id = 0});",
        "  @FoxyFullField('Owner', key: true)\n"
            "  final int owner;\n\n"
            "  const SampleEntity({this.id = 0, this.owner = 0});",
      );

      await testBuilder(
        foxyViewModelBuilder(BuilderOptions.empty),
        {
          listAnnotationAsset: listAnnotationSource,
          entityAnnotationAsset: entityAnnotationSource,
          repositoryAnnotationAsset: repositoryAnnotationSource,
          entityAsset: entity,
          repositoryAsset: sampleRepositorySource,
          viewModelAsset: sampleViewModelSource,
        },
        outputs: {
          'foxy|lib/view_model/sample_list_view_model.foxy_view_model.g.part':
              decodedMatches(
                allOf(<Matcher>[
                  contains(
                    'Future<void> copy(SampleKey key) => EntityWrittenEvent.capture(',
                  ),
                  contains('sourceKey: _repository.activityKey(key)'),
                  contains(
                    'Future<void> destroy(SampleKey key) => EntityWrittenEvent.capture(',
                  ),
                ]),
              ),
        },
      );
    },
  );

  test('Query methods are called by naming convention without reading repository source', () async {
    const repository = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(entity: SampleEntity)
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class SampleRepository with _SampleRepositoryMixin {}

class SampleFilter {
  final String entry;
  final String name;

  const SampleFilter({this.entry = '', this.name = ''});
}

class BriefSampleEntity {
  const BriefSampleEntity();
}
''';

    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: sampleEntitySource,
        repositoryAsset: repository,
        viewModelAsset: sampleViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/sample_list_view_model.foxy_view_model.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains(
                  'Future<void> copy(int key) => EntityWrittenEvent.capture(',
                ),
                contains('await _repository.copySample(key);'),
                contains('await _repository.destroySample(key);'),
                contains('_repository.getBriefSamples('),
                contains('_repository.countSamples(filter: filter),'),
              ]),
            ),
      },
    );
  });

  test('Generation rejects non-text filters', () async {
    final repository = sampleRepositorySource.replaceFirst(
      "@FoxyFilter.text('entry')",
      "@FoxyFilter.text('entry')\n"
          "@FoxyFilter.integer('classId', defaultValue: -1)",
    );

    final logs = <String>[];
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: sampleEntitySource,
        repositoryAsset: repository,
        viewModelAsset: sampleViewModelSource,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('supports only @FoxyFilter.text')),
      isTrue,
    );
  });

  test(
    'Generation rejects view model names without the ListViewModel suffix',
    () async {
      final source = sampleViewModelSource.replaceFirst(
        'SampleListViewModel',
        'SampleList',
      );
      final logs = <String>[];
      await testBuilder(
        foxyViewModelBuilder(BuilderOptions.empty),
        {
          listAnnotationAsset: listAnnotationSource,
          entityAnnotationAsset: entityAnnotationSource,
          repositoryAnnotationAsset: repositoryAnnotationSource,
          entityAsset: sampleEntitySource,
          repositoryAsset: sampleRepositorySource,
          viewModelAsset: source,
        },
        outputs: {},
        onLog: (record) => logs.add(record.toString()),
      );
      expect(
        logs.any((log) => log.contains('ending in ListViewModel')),
        isTrue,
      );
    },
  );

  test('Generation rejects a missing part declaration', () async {
    final source = sampleViewModelSource.replaceFirst(
      "part 'sample_list_view_model.g.dart';\n",
      '',
    );
    final logs = <String>[];
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: sampleEntitySource,
        repositoryAsset: sampleRepositorySource,
        viewModelAsset: source,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logs.any((log) => log.contains('is missing part')), isTrue);
  });

  test('Generation rejects a missing mixin', () async {
    final source = sampleViewModelSource.replaceFirst(
      ', _SampleListViewModelMixin',
      '',
    );
    final logs = <String>[];
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: sampleEntitySource,
        repositoryAsset: sampleRepositorySource,
        viewModelAsset: source,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('must mix in _SampleListViewModelMixin')),
      isTrue,
    );
  });

  test(
    'Generation rejects mismatched repository and entity base names',
    () async {
      // The repository class name is changed so its base name no longer
      // matches the entity's; the reader's one-to-one naming check fires
      // before the derived-repository resolution.
      final repository = sampleRepositorySource.replaceFirst(
        'class SampleRepository',
        'class OtherRepository',
      );
      final source = sampleViewModelSource
          .replaceFirst(
            'repository: SampleRepository',
            'repository: OtherRepository',
          )
          .replaceFirst(
            "import 'package:foxy/repository/sample_repository.dart';",
            "import 'package:foxy/repository/sample_repository.dart' "
                'show OtherRepository;',
          );
      final logs = <String>[];
      await testBuilder(
        foxyViewModelBuilder(BuilderOptions.empty),
        {
          listAnnotationAsset: listAnnotationSource,
          entityAnnotationAsset: entityAnnotationSource,
          repositoryAnnotationAsset: repositoryAnnotationSource,
          entityAsset: sampleEntitySource,
          repositoryAsset: repository,
          viewModelAsset: source,
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
}

const entityAnnotationAsset = 'foxy_annotation|lib/entity_annotations.dart';
const entityAsset = 'foxy|lib/entity/sample_entity.dart';
const listAnnotationAsset = 'foxy_annotation|lib/list_annotations.dart';
const repositoryAnnotationAsset =
    'foxy_annotation|lib/repository_annotations.dart';
const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';
const sampleEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.sample')
class SampleEntity {
  @FoxyFullField('ID', key: true)
  final int id;

  const SampleEntity({this.id = 0});
}
''';

const sampleRepositorySource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(entity: SampleEntity)
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class SampleRepository with _SampleRepositoryMixin {
  Future<void> copySample(int key) async {}

  Future<int> countSamples({SampleFilter? filter}) async => 0;

  Future<void> destroySample(int key) async {}

  Future<List<BriefSampleEntity>> getBriefSamples({
    int page = 1,
    SampleFilter? filter,
  }) async => [];
}

class SampleFilter {
  final String entry;
  final String name;

  const SampleFilter({this.entry = '', this.name = ''});
}

class BriefSampleEntity {
  const BriefSampleEntity();
}
''';

const sampleViewModelSource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy_annotation/list_annotations.dart';
import 'package:foxy/repository/sample_repository.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/view_model/query_version_mixin.dart';

part 'sample_list_view_model.g.dart';

@FoxyListViewModel(entity: SampleEntity, repository: SampleRepository)
class SampleListViewModel
    with FieldControllerMixin, QueryVersionMixin, _SampleListViewModelMixin {}
''';

const viewModelAsset = 'foxy|lib/view_model/sample_list_view_model.dart';

/// Reads the real annotation source directly instead of keeping a
/// hand-copied duplicate in tests.
///
/// Copies silently drift when annotations gain parameters or change
/// defaults, letting tests pass against stale definitions. Tests run from
/// the foxy_generator package root.
final entityAnnotationSource = foxyAnnotationSource('entity_annotations.dart');

final listAnnotationSource = foxyAnnotationSource('list_annotations.dart');

final repositoryAnnotationSource = foxyAnnotationSource(
  'repository_annotations.dart',
);
