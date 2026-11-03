import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('关联列表将父键传给查询和创建，并使用复合键编辑', () async {
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
                contains('final editingKey = signal<ChildItemKey?>(null);'),
                contains('Future<void> copy(ChildItemKey key) async {'),
                contains('await _repository.copyChildItem(key);'),
                contains('await _repository.createChildItem(link);'),
                contains('Future<void> destroy(ChildItemKey key) async {'),
                contains('Future<void> edit(ChildItemKey key) async {'),
                contains('_applyCandidate(ChildItemEntity(parentId: link));'),
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
      logs.any((log) => log.contains('must declare exactly one linkKey')),
      isTrue,
    );
  });
}

const formAnnotationAsset = 'foxy_annotation|lib/form_annotations.dart';
const entityAnnotationAsset = 'foxy_annotation|lib/entity_annotations.dart';
const entityAsset = 'foxy|lib/entity/child_item_entity.dart';
const repositoryAnnotationAsset =
    'foxy_annotation|lib/repository_annotations.dart';
const repositoryAsset = 'foxy|lib/repository/child_item_repository.dart';
const viewModelAsset = 'foxy|lib/view_model/child_item_editor_view_model.dart';

const childEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

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
import 'package:foxy_annotation/repository_annotations.dart';

part 'child_item_repository.g.dart';

@FoxyRepository(entity: ChildItemEntity, linkKey: ['parentId'])
class ChildItemRepository with _ChildItemRepositoryMixin {}
''';

const editorViewModelSource = r'''
import 'package:foxy/entity/child_item_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
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
final formAnnotationSource = foxyAnnotationSource('form_annotations.dart');

final entityAnnotationSource = foxyAnnotationSource('entity_annotations.dart');

final repositoryAnnotationSource = foxyAnnotationSource(
  'repository_annotations.dart',
);
