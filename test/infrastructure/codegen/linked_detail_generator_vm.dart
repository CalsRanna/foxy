import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy/infrastructure/codegen/builder.dart';
import 'package:test/test.dart';

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
                // 字段:repository + 关联键/编辑键/entity 状态信号
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
                // controller 样板(复用 FormEmitter)
                contains('late final entryController = '
                    'registerController(IntFieldController());'),
                // 竞态 token
                contains('int _refreshToken = 0;'),
                contains('int _linkToken = 0;'),
                // 公开方法:destroy/dispose/initSignals/persist/setLinkKey
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
                // 私有:_refresh 走 get-or-create(关联键即主键)
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
      logs.any((log) => log.contains('是复合键实体，不能生成 Linked Detail 骨架')),
      isTrue,
    );
  });
}

const formAnnotationAsset =
    'foxy|lib/infrastructure/codegen/form_annotations.dart';
const entityAnnotationAsset =
    'foxy|lib/infrastructure/codegen/entity_annotations.dart';
const entityAsset = 'foxy|lib/entity/addon_entity.dart';
const repositoryAnnotationAsset =
    'foxy|lib/infrastructure/codegen/repository_annotations.dart';
const repositoryAsset = 'foxy|lib/repository/addon_repository.dart';
const viewModelAsset =
    'foxy|lib/view_model/addon_linked_detail_view_model.dart';

const compositeEntityAsset = 'foxy|lib/entity/composite_entity.dart';
const compositeRepositoryAsset =
    'foxy|lib/repository/composite_repository.dart';
const compositeViewModelAsset =
    'foxy|lib/view_model/composite_linked_detail_view_model.dart';

const addonEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

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
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'addon_repository.g.dart';

@FoxyRepository(AddonEntity)
class AddonRepository with _AddonRepositoryMixin {
  static const _table = 'foxy.addon';
}
''';

const linkedDetailViewModelSource = r'''
import 'package:foxy/entity/addon_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
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
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

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
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'composite_repository.g.dart';

@FoxyRepository(CompositeEntity)
class CompositeRepository with _CompositeRepositoryMixin {
  static const _table = 'foxy.composite';
}
''';

const compositeViewModelSource = r'''
import 'package:foxy/entity/composite_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
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

/// 直接读取真实注解源码，而不是在测试里维护手抄副本。
final formAnnotationSource = File(
  'lib/infrastructure/codegen/form_annotations.dart',
).readAsStringSync();

final entityAnnotationSource = File(
  'lib/infrastructure/codegen/entity_annotations.dart',
).readAsStringSync();

final repositoryAnnotationSource = File(
  'lib/infrastructure/codegen/repository_annotations.dart',
).readAsStringSync();
