import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

void main() {
  test('FoxyLinkedListViewModel 生成全套编辑器骨架', () async {
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        formAnnotationAsset: formAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: childEntitySource,
        repositoryAsset: childRepositorySource,
        viewModelAsset: editorViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/child_item_editor_view_model.foxy_view_model.g.part':
            decodedMatches(
              allOf(<Matcher>[
                // Fields: repository + parent-key/list state signals
                contains(
                  'final _repository = '
                  'GetIt.instance.get<ChildItemRepository>();',
                ),
                contains('final linkKey = signal<int?>(null);'),
                contains('final items = signal(<BriefChildItemEntity>[]);'),
                contains('final editingKey = signal<ChildItemKey?>(null);'),
                contains('final selectedKey = signal<ChildItemKey?>(null);'),
                contains('final page = signal(1);'),
                contains('final total = signal(0);'),
                contains('final loading = signal(false);'),
                contains('final submitting = signal(false);'),
                contains('final errorMessage = signal<String?>(null);'),
                // Controller boilerplate (reuses FormEmitter)
                contains('late final childIdController = '
                    'registerController(IntFieldController());'),
                // Race token
                contains('int _refreshToken = 0;'),
                contains('int _interactionToken = 0;'),
                // Public methods:
                // copy/create/destroy/edit/persist/setLinkKey
                contains('Future<void> copy(ChildItemKey key) async {'),
                contains('await _repository.copyChildItem(key);'),
                contains('Future<void> create() async {'),
                contains('await _repository.createChildItem(link);'),
                contains('Future<void> destroy(ChildItemKey key) async {'),
                contains('Future<void> edit(ChildItemKey key) async {'),
                contains(
                  'Future<void> initSignals({required int linkKey}) '
                  '=> setLinkKey(linkKey);',
                ),
                contains('Future<void> paginate(int page) async {'),
                contains('Future<void> persist() async {'),
                contains('Future<void> setLinkKey(int linkKey) async {'),
                contains('_applyCandidate(ChildItemEntity(parentId: link));'),
                // Private: _refresh goes parent-key count + list
                contains('await _repository.countChildItems(link);'),
                contains('await _repository.getBriefChildItems('),
                contains('max(1, (count / _repository.kPageSize).ceil())'),
              ]),
            ),
      },
    );
  });

  test('仓库未声明 linkKey 时拒绝生成编辑器骨架', () async {
    final repository = childRepositorySource.replaceFirst(
      ", linkKey: ['parentId']",
      '',
    );
    final logs = <String>[];
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        formAnnotationAsset: formAnnotationSource,
        entityAnnotationAsset: entityAnnotationSource,
        repositoryAnnotationAsset: repositoryAnnotationSource,
        entityAsset: childEntitySource,
        repositoryAsset: repository,
        viewModelAsset: editorViewModelSource,
      },
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(
      logs.any((log) => log.contains('必须声明且只能声明一个 linkKey')),
      isTrue,
    );
  });
}

const formAnnotationAsset =
    'foxy|lib/infrastructure/codegen/form_annotations.dart';
const entityAnnotationAsset =
    'foxy|lib/infrastructure/codegen/entity_annotations.dart';
const entityAsset = 'foxy|lib/entity/child_item_entity.dart';
const repositoryAnnotationAsset =
    'foxy|lib/infrastructure/codegen/repository_annotations.dart';
const repositoryAsset = 'foxy|lib/repository/child_item_repository.dart';
const viewModelAsset = 'foxy|lib/view_model/child_item_editor_view_model.dart';

const childEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.child')
class ChildItemEntity {
  @FoxyBriefField()
  @FoxyFullField('ParentID', key: true)
  final int parentId;

  @FoxyBriefField()
  @FoxyFullField('ChildItemID', key: true)
  final int childId;

  const ChildItemEntity({this.parentId = 0, this.childId = 0});
}
''';

const childRepositorySource = r'''
import 'package:foxy/entity/child_item_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'child_item_repository.g.dart';

@FoxyRepository(ChildItemEntity, linkKey: ['parentId'])
class ChildItemRepository with _ChildItemRepositoryMixin {
  static const _table = 'foxy.child';
}
''';

const editorViewModelSource = r'''
import 'package:foxy/entity/child_item_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/child_item_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';

part 'child_item_editor_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: ChildItemEntity,
  repository: ChildItemRepository,
)
class ChildItemEditorViewModel
    with FieldControllerMixin, _ChildItemEditorViewModelMixin {}
''';

/// Reads the real annotation source directly instead of keeping a
/// hand-copied duplicate in tests.
final formAnnotationSource = File(
  'lib/infrastructure/codegen/form_annotations.dart',
).readAsStringSync();

final entityAnnotationSource = File(
  'lib/infrastructure/codegen/entity_annotations.dart',
).readAsStringSync();

final repositoryAnnotationSource = File(
  'lib/infrastructure/codegen/repository_annotations.dart',
).readAsStringSync();
