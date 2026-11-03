import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('单整数主键保存后同步实体和主键控制器', () async {
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      _assets(_viewModelSource),
      outputs: {
        _output: decodedMatches(
          allOf(<Matcher>[
            contains('var candidate = _collectCandidate();'),
            contains(
              'final storedKey = await _repository.storeSample(candidate);',
            ),
            contains('persistedKey.value = storedKey;'),
            contains('if (storedKey != candidate.id)'),
            contains('candidate = candidate.copyWith(id: storedKey);'),
            contains('if (!isDisposed)'),
            contains('idController.init(storedKey);'),
            contains('entity.value = candidate;'),
            contains('_logActivity(action, candidate);'),
            isNot(contains('_applyCandidate(candidate);')),
          ]),
        ),
      },
    );
  });

  test('主键排除出表单时只同步实体而不引用不存在的控制器', () async {
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      _assets(
        _viewModelSource.replaceFirst(
          '@FoxyDetailViewModel()',
          "@FoxyDetailViewModel(exclude: {'id'})",
        ),
      ),
      outputs: {
        _output: decodedMatches(
          allOf(<Matcher>[
            contains('candidate = candidate.copyWith(id: storedKey);'),
            isNot(contains('idController')),
          ]),
        ),
      },
    );
  });
}

const _output =
    'foxy|lib/view_model/sample_detail_view_model.foxy_view_model.g.part';

Map<String, String> _assets(String viewModel) => {
  'foxy_annotation|lib/entity_annotations.dart': foxyAnnotationSource(
    'entity_annotations.dart',
  ),
  'foxy_annotation|lib/form_annotations.dart': foxyAnnotationSource(
    'form_annotations.dart',
  ),
  'foxy_annotation|lib/repository_annotations.dart': foxyAnnotationSource(
    'repository_annotations.dart',
  ),
  'foxy|lib/entity/sample_entity.dart': _entitySource,
  'foxy|lib/repository/sample_repository.dart': _repositorySource,
  'foxy|lib/view_model/sample_detail_view_model.dart': viewModel,
};

const _entitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyFullEntity()
class SampleEntity {
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Name')
  final String name;

  const SampleEntity({this.id = 0, this.name = ''});
}
''';

const _repositorySource = r'''
import 'package:foxy_annotation/repository_annotations.dart';

@FoxyRepository()
class SampleRepository {}
''';

const _viewModelSource = r'''
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/widget/form/field_controller.dart';

part 'sample_detail_view_model.g.dart';

@FoxyDetailViewModel()
class SampleDetailViewModel
    with FieldControllerMixin, _SampleDetailViewModelMixin {}
''';
