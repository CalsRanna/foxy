import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  for (final (declaration, intFallback, stringFallback) in [
    ("{'id': 7, 'name': 'unknown'}", '7', "'unknown'"),
    ("{'id', 'name'}", '0', "''"),
  ]) {
    test('enums $declaration 生成匹配类型及 fallback 的控制器', () async {
      await testBuilder(
        foxyViewModelBuilder(BuilderOptions.empty),
        _assets(
          _viewModelSource.replaceFirst(
            '@FoxyDetailViewModel()',
            '@FoxyDetailViewModel(enums: $declaration)',
          ),
        ),
        outputs: {
          _output: decodedMatches(
            allOf(<Matcher>[
              contains('EnumFieldController<int>(fallback: $intFallback)'),
              contains(
                'EnumFieldController<String>(fallback: $stringFallback)',
              ),
              contains('idController.init(sample.id);'),
              contains('nameController.init(sample.name);'),
              contains('id: idController.collect(),'),
              contains('name: nameController.collect(),'),
            ]),
          ),
        },
      );
    });
  }

  test('bool 自动生成枚举控制器并保留 0/1 转换', () async {
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      _assets(_viewModelSource),
      outputs: {
        _output: decodedMatches(
          allOf(<Matcher>[
            contains('EnumFieldController<int>(fallback: 0)'),
            contains('enabledController.init(sample.enabled ? 1 : 0);'),
            contains('enabled: enabledController.collect() == 1,'),
          ]),
        ),
      },
    );
  });

  for (final (declaration, message) in [
    (
      "enums: {'id': 'wrong type'}",
      'The enums fallback type must match the field type',
    ),
    ("enums: {'id'}, flags: {'id'}", 'appear in both enums and flags'),
  ]) {
    test('拒绝不合法的枚举声明：$declaration', () async {
      final logs = <String>[];
      await testBuilder(
        foxyViewModelBuilder(BuilderOptions.empty),
        _assets(
          _viewModelSource.replaceFirst(
            '@FoxyDetailViewModel()',
            '@FoxyDetailViewModel($declaration)',
          ),
        ),
        outputs: {},
        onLog: (record) => logs.add(record.toString()),
      );
      expect(logContains(logs, message), isTrue);
    });
  }

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

  @FoxyFullField('Enabled')
  final bool enabled;

  const SampleEntity({this.id = 0, this.name = '', this.enabled = false});
}
''';

const _repositorySource = r'''
import 'package:foxy_annotation/repository_annotations.dart';

@FoxyRepository()
class SampleRepository {}
''';

const _viewModelSource = r'''
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/view_model/form/field_controller.dart';

part 'sample_detail_view_model.g.dart';

@FoxyDetailViewModel()
class SampleDetailViewModel
    with FieldControllerMixin, _SampleDetailViewModelMixin {}
''';
