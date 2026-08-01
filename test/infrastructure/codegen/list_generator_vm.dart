import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

void main() {
  test('FoxyListViewModel 生成标准列表样板(单 key int + copy)', () async {
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
                contains(
                  'mixin _SampleListViewModelMixin '
                  'on FieldControllerMixin, QueryVersionMixin {',
                ),
                contains(
                  'final _repository = '
                  'GetIt.instance.get<SampleRepository>();',
                ),
                contains('final items = signal(<BriefSampleEntity>[]);'),
                contains('@override\n  final page = signal(1);'),
                contains('final total = signal(0);'),
                contains('final loading = signal(false);'),
                contains('final submitting = signal(false);'),
                contains('final errorMessage = signal<String?>(null);'),
                contains(
                  'late final entryController = '
                  'registerController(StringFieldController());',
                ),
                contains(
                  'late final nameController = '
                  'registerController(StringFieldController());',
                ),
                contains('int _refreshToken = 0;'),
                contains('Future<void> copy(int key) async {'),
                contains('await _repository.copySample(key);'),
                contains('Future<void> destroy(int key) async {'),
                contains('await _repository.destroySample(key);'),
                contains("_logActivity(ActivityActionType.delete, key);"),
                contains('normalizePageAfterDelete(total.value - 1);'),
                contains('void dispose() {'),
                contains('Future<void> initSignals() async {'),
                contains('Future<void> paginate(int page) async {'),
                contains("entryController.init('');"),
                contains("nameController.init('');"),
                contains('page.value = 1;'),
                contains('markQueryVersion();'),
                contains('SampleFilter _collectFilter() {'),
                contains('entry: entryController.collect(),'),
                contains('name: nameController.collect(),'),
                contains(
                  'void _logActivity(ActivityActionType action, int key) {}',
                ),
                contains('_repository.getBriefSamples('),
                contains('_repository.countSamples(filter: filter),'),
                contains("LoggerUtil.instance.e('刷新列表失败: \$error');"),
              ]),
            ),
      },
    );
  });

  test('filter 字段 id 生成 idController(与字段同名)', () async {
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

  test('Repository 无 copy 方法时不生成 copy', () async {
    final repository = sampleRepositorySource.replaceFirst(
      '  Future<void> copySample(int key) async {}\n',
      '',
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
                isNot(contains('Future<void> copy(')),
                contains('Future<void> destroy(int key) async {'),
              ]),
            ),
      },
    );
  });

  test('复合 Key 时 copy/destroy 使用 XxxKey 参数', () async {
    final repository = sampleRepositorySource
        .replaceFirst(
          'Future<void> copySample(int key) async {}',
          'Future<SampleKey> copySample(SampleKey key) async => key;',
        )
        .replaceFirst(
          'Future<void> destroySample(int key) async {}',
          'Future<void> destroySample(SampleKey key) async {}',
        )
        .replaceFirst(
          "class BriefSampleEntity {",
          "class SampleKey {\n"
              "  final int entry;\n"
              "  const SampleKey({required this.entry});\n"
              "}\n\n"
              "class BriefSampleEntity {",
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
                contains('Future<void> copy(SampleKey key) async {'),
                contains('Future<void> destroy(SampleKey key) async {'),
                contains(
                  'void _logActivity(ActivityActionType action, SampleKey key) {}',
                ),
              ]),
            ),
      },
    );
  });

  test('方法名与 base name 不匹配时按签名匹配(reference 特例)', () async {
    const repository = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(SampleEntity)
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class SampleRepository with _SampleRepositoryMixin {
  Future<SampleKey> copyLootTemplate(SampleKey key) async => key;

  Future<int> countLootTemplateRows({SampleFilter? filter}) async => 0;

  Future<int> countLootTemplates({SampleFilter? filter}) async => 0;

  Future<void> destroySample(SampleKey key) async {}

  Future<List<BriefSampleEntity>> getBriefLootTemplateRows({
    int page = 1,
    SampleFilter? filter,
  }) async => [];

  Future<List<BriefSampleEntity>> getBriefLootTemplates(int entry) async => [];

  static const _table = 'foxy.sample';
}

class SampleKey {
  final int entry;

  const SampleKey({required this.entry});
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
                contains('Future<void> copy(SampleKey key) async {'),
                contains('await _repository.copyLootTemplate(key);'),
                contains('await _repository.destroySample(key);'),
                contains('_repository.getBriefLootTemplateRows('),
                contains('_repository.countLootTemplateRows(filter: filter),'),
                // 无 filter 参数的 getBrief 候选被排除
                isNot(contains('getBriefLootTemplates(')),
                isNot(contains('countLootTemplates(')),
              ]),
            ),
      },
    );
  });

  test('非 text 筛选字段拒绝生成', () async {
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
    expect(logs.any((log) => log.contains('只支持 @FoxyFilter.text')), isTrue);
  });

  test('VM 类名不以 ListViewModel 结尾时拒绝生成', () async {
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
    expect(logs.any((log) => log.contains('以 ListViewModel 结尾')), isTrue);
  });

  test('缺少 part 声明时拒绝生成', () async {
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
    expect(logs.any((log) => log.contains('缺少 part')), isTrue);
  });

  test('缺少 mixin 混入时拒绝生成', () async {
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
      logs.any((log) => log.contains('必须混入 _SampleListViewModelMixin')),
      isTrue,
    );
  });

  test('Repository 与 Entity base name 不一致时拒绝生成', () async {
    final entity = sampleEntitySource.replaceAll('SampleEntity', 'OtherEntity');
    final source = sampleViewModelSource
        .replaceFirst('entity: SampleEntity', 'entity: OtherEntity')
        .replaceFirst(
          "import 'package:foxy/entity/sample_entity.dart';",
          "import 'package:foxy/entity/sample_entity.dart' show OtherEntity;",
        );
    final logs = <String>[];
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        listAnnotationAsset: listAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: entity,
        repositoryAsset: sampleRepositorySource,
        viewModelAsset: source,
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
const listAnnotationAsset =
    'foxy|lib/infrastructure/codegen/list_annotations.dart';
const repositoryAnnotationAsset =
    'foxy|lib/infrastructure/codegen/repository_annotations.dart';
const repositoryAsset = 'foxy|lib/repository/sample_repository.dart';
const viewModelAsset = 'foxy|lib/view_model/sample_list_view_model.dart';

const sampleEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.sample')
class SampleEntity {
  @FoxyFullField('ID', key: true)
  final int id;

  const SampleEntity({this.id = 0});
}
''';

const sampleRepositorySource = r'''
import 'package:foxy/entity/sample_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'sample_repository.g.dart';

@FoxyRepository(SampleEntity)
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class SampleRepository with _SampleRepositoryMixin {
  static const _table = 'foxy.sample';

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
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/repository/sample_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';

part 'sample_list_view_model.g.dart';

@FoxyListViewModel(entity: SampleEntity, repository: SampleRepository)
class SampleListViewModel
    with FieldControllerMixin, QueryVersionMixin, _SampleListViewModelMixin {}
''';

/// 直接读取真实注解源码，而不是在测试里维护手抄副本。
///
/// 副本会在注解新增参数或改默认值后悄悄失真，让测试对着旧定义通过。
/// 测试从仓库根目录运行（见 AGENTS.md）。
final entityAnnotationSource = File(
  'lib/infrastructure/codegen/entity_annotations.dart',
).readAsStringSync();

final listAnnotationSource = File(
  'lib/infrastructure/codegen/list_annotations.dart',
).readAsStringSync();

final repositoryAnnotationSource = File(
  'lib/infrastructure/codegen/repository_annotations.dart',
).readAsStringSync();
