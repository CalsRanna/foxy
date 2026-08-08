import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('FoxyLinkedDetailViewModel 生成单行关联编辑器骨架', () async {
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        formAnnotationAsset: formAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: addonEntitySource,
        repositoryAsset: addonRepositorySource,
        viewModelAsset: linkedDetailViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/addon_linked_detail_view_model.foxy_view_model.g.part':
            decodedMatches(
              allOf(<Matcher>[
                // Fields: repository + link-key/editing-key/entity state
                // signals
                contains(
                  'final _repository = '
                  'GetIt.instance.get<AddonRepository>();',
                ),
                contains('final linkKey = signal<int?>(null);'),
                contains('final editingKey = signal<int?>(null);'),
                contains('final entity = signal<AddonEntity?>(null);'),
                contains('final loading = signal(false);'),
                contains('final submitting = signal(false);'),
                contains('final errorMessage = signal<String?>(null);'),
                // Controller boilerplate (reuses FormEmitter)
                contains('late final entryController = '
                    'registerController(IntFieldController());'),
                // Race token
                contains('int _refreshToken = 0;'),
                contains('int _linkToken = 0;'),
                // Public methods:
                // destroy/dispose/initSignals/persist/setLinkKey
                contains('Future<void> destroy() async {'),
                contains('await _repository.destroyAddon(key);'),
                contains('void dispose() {'),
                contains(
                  'Future<void> initSignals({required int linkKey}) {',
                ),
                contains('return setLinkKey(linkKey);'),
                contains(
                  "throw LinkNotLoadedException('link record not loaded');",
                ),
                contains('await _repository.storeAddon(candidate);'),
                contains('await _repository.updateAddon('),
                contains('editingKey.value = candidate.entry;'),
                contains('Future<void> setLinkKey(int linkKey) async {'),
                // Private: _refresh goes get-or-create (link key is the
                // primary key)
                contains('final existing = await _repository.getAddon('),
                contains('existing ?? await _repository.createAddon('),
                contains('editingKey.value = existing == null ? null : linkSnapshot;'),
                contains("LoggerUtil.instance.e('加载单行编辑器失败'"),
              ]),
            ),
      },
    );
  });

  test('复合键实体拒绝生成 Linked Detail 骨架', () async {
    final logs = <String>[];
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        formAnnotationAsset: formAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        compositeEntityAsset: compositeEntitySource,
        compositeRepositoryAsset: compositeRepositorySource,
        compositeViewModelAsset: compositeViewModelSource,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any(
        (log) => log.contains(
          'is a composite-key entity; a Linked Detail skeleton '
              'cannot be generated',
        ),
      ),
      isTrue,
    );
  });

  test('绑定 Repository 无 linkKey 时允许生成(手写 create 兜底)', () async {
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        formAnnotationAsset: formAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: addonEntitySource,
        repositoryAsset: addonRepositorySource.replaceFirst(
          ", linkKey: ['entry']",
          '',
        ),
        viewModelAsset: linkedDetailViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/addon_linked_detail_view_model'
            '.foxy_view_model.g.part': anything,
      },
    );
  });

  test('绑定 Repository 声明多个 linkKey 时拒绝生成', () async {
    final logs = <String>[];
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        formAnnotationAsset: formAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: addonEntitySource,
        repositoryAsset: addonRepositorySource.replaceFirst(
          "linkKey: ['entry']",
          "linkKey: ['entry', 'comment']",
        ),
        viewModelAsset: linkedDetailViewModelSource,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('supports only a single linkKey')),
      isTrue,
    );
  });

  test('linkKey 与实体主键不匹配时拒绝生成', () async {
    final logs = <String>[];
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        formAnnotationAsset: formAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: addonEntitySource,
        repositoryAsset: addonRepositorySource.replaceFirst(
          "linkKey: ['entry']",
          "linkKey: ['comment']",
        ),
        viewModelAsset: linkedDetailViewModelSource,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any(
        (log) => log.contains('must equal the entity primary key entry'),
      ),
      isTrue,
    );
  });
}

const formAnnotationAsset =
    'foxy_annotation|lib/form_annotations.dart';
const entityAnnotationAsset =
    'foxy_annotation|lib/entity_annotations.dart';
const entityAsset = 'foxy|lib/entity/addon_entity.dart';
const repositoryAnnotationAsset =
    'foxy_annotation|lib/repository_annotations.dart';
const repositoryAsset = 'foxy|lib/repository/addon_repository.dart';
const viewModelAsset =
    'foxy|lib/view_model/addon_linked_detail_view_model.dart';

const compositeEntityAsset = 'foxy|lib/entity/composite_entity.dart';
const compositeRepositoryAsset =
    'foxy|lib/repository/composite_repository.dart';
const compositeViewModelAsset =
    'foxy|lib/view_model/composite_linked_detail_view_model.dart';

const addonEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.addon')
class AddonEntity {
  @FoxyFullField('Entry', key: true)
  final int entry;

  @FoxyFullField('Comment')
  final String comment;

  const AddonEntity({this.entry = 0, this.comment = ''});
}
''';

const addonRepositorySource = r'''
import 'package:foxy/entity/addon_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'addon_repository.g.dart';

@FoxyRepository(AddonEntity, linkKey: ['entry'])
class AddonRepository with _AddonRepositoryMixin {}
''';

const linkedDetailViewModelSource = r'''
import 'package:foxy/entity/addon_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/addon_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';

part 'addon_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: AddonEntity,
  repository: AddonRepository,
)
class AddonLinkedDetailViewModel
    with FieldControllerMixin, _AddonLinkedDetailViewModelMixin {}
''';

const compositeEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyFullEntity(table: 'foxy.composite')
class CompositeEntity {
  @FoxyFullField('Race', key: true)
  final int race;

  @FoxyFullField('Class', key: true)
  final int class_;

  const CompositeEntity({this.race = 0, this.class_ = 0});
}
''';

const compositeRepositorySource = r'''
import 'package:foxy/entity/composite_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'composite_repository.g.dart';

@FoxyRepository(CompositeEntity)
class CompositeRepository with _CompositeRepositoryMixin {}
''';

const compositeViewModelSource = r'''
import 'package:foxy/entity/composite_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/composite_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';

part 'composite_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: CompositeEntity,
  repository: CompositeRepository,
)
class CompositeLinkedDetailViewModel
    with FieldControllerMixin, _CompositeLinkedDetailViewModelMixin {}
''';

/// Reads the real annotation source directly instead of keeping a
/// hand-copied duplicate in tests.
final formAnnotationSource = foxyAnnotationSource('form_annotations.dart');

final entityAnnotationSource = foxyAnnotationSource('entity_annotations.dart');

final repositoryAnnotationSource = foxyAnnotationSource('repository_annotations.dart');
