import 'dart:convert';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

/// Matcher that captures a generated part and asserts it parses as valid
/// Dart. The existing generator tests assert with string `contains` and
/// would never catch structural breakage (e.g. a reserved-word parameter
/// name, an int assigned to a String key) — this smoke layer does.
final _parseable = _ParseableDart();

void main() {
  test('Repository 生成产物可解析为合法 Dart', () async {
    await testBuilder(
      foxyRepositoryBuilder(BuilderOptions.empty),
      {
        'foxy_annotation|lib/entity_annotations.dart':
            foxyAnnotationSource('entity_annotations.dart'),
        'foxy_annotation|lib/repository_annotations.dart':
            foxyAnnotationSource('repository_annotations.dart'),
        'foxy_annotation|lib/list_annotations.dart':
            foxyAnnotationSource('list_annotations.dart'),
        'foxy|lib/entity/codegen_sample_entity.dart': _sampleEntitySource,
        'foxy|lib/entity/codegen_relation_entity.dart': _relationEntitySource,
        'foxy|lib/repository/codegen_sample_repository.dart':
            _sampleRepositorySource,
        'foxy|lib/repository/codegen_relation_repository.dart':
            _relationRepositorySource,
        'foxy|lib/view_model/codegen_sample_list_view_model.dart':
            _sampleListViewModelSource,
      },
      outputs: {
        'foxy|lib/repository/codegen_sample_repository'
            '.foxy_repository.g.part': _parseable,
        'foxy|lib/repository/codegen_relation_repository'
            '.foxy_repository.g.part': _parseable,
      },
    );
  });

  test('Form/List/LinkedList/LinkedDetail 生成产物可解析为合法 Dart', () async {
    await testBuilder(
      foxyViewModelBuilder(BuilderOptions.empty),
      {
        'foxy_annotation|lib/entity_annotations.dart':
            foxyAnnotationSource('entity_annotations.dart'),
        'foxy_annotation|lib/form_annotations.dart':
            foxyAnnotationSource('form_annotations.dart'),
        'foxy_annotation|lib/list_annotations.dart':
            foxyAnnotationSource('list_annotations.dart'),
        'foxy_annotation|lib/repository_annotations.dart':
            foxyAnnotationSource('repository_annotations.dart'),
        'foxy|lib/entity/codegen_sample_entity.dart': _sampleEntitySource,
        'foxy|lib/repository/codegen_sample_repository.dart':
            _sampleRepositorySource,
        'foxy|lib/view_model/codegen_sample_list_view_model.dart':
            _sampleListViewModelSource,
        'foxy|lib/view_model/codegen_sample_detail_view_model.dart':
            _sampleDetailViewModelSource,
      },
      outputs: {
        'foxy|lib/view_model/codegen_sample_list_view_model'
            '.foxy_view_model.g.part': _parseable,
        'foxy|lib/view_model/codegen_sample_detail_view_model'
            '.foxy_view_model.g.part': _parseable,
      },
    );
  });
}

/// Part/mixin-free entity sources: build_test's resolver cannot follow
/// `part 'x.g.dart'` (the generated file is not an input), which would make
/// the annotations unresolvable. The generators read the same metadata from
/// these fixtures as from real entities.
const _sampleEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.codegen_sample')
class CodegenSampleEntity {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Name')
  final String name;

  @FoxyFullField('Enabled')
  final bool enabled;

  @FoxyFullField('Description')
  final String? description;

  const CodegenSampleEntity({
    this.id = 0,
    this.name = '',
    this.enabled = false,
    this.description,
  });
}
''';

const _relationEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'codegen_relation')
class CodegenRelationEntity {
  @FoxyBriefField()
  @FoxyFullField('OwnerID', key: true)
  final int ownerId;

  @FoxyBriefField()
  @FoxyFullField('Locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('Value')
  final String value;

  const CodegenRelationEntity({
    this.ownerId = 0,
    this.locale = '',
    this.value = '',
  });
}
''';

const _sampleRepositorySource = r'''
import 'package:foxy/entity/codegen_sample_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'codegen_sample_repository.g.dart';

@FoxyRepository(CodegenSampleEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class CodegenSampleRepository with _CodegenSampleRepositoryMixin {
  static const _table = 'foxy.codegen_sample';
}
''';

const _relationRepositorySource = r'''
import 'package:foxy/entity/codegen_relation_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';

part 'codegen_relation_repository.g.dart';

// Composite key with a String component: no query layer (no list VM, no
// linkKey), so the generated surface is destroy/get/getXxxs only — no
// create with `nextMaxPlusOne` on a String key.
@FoxyRepository(CodegenRelationEntity)
class CodegenRelationRepository with _CodegenRelationRepositoryMixin {
  static const _table = 'codegen_relation';
}
''';

const _sampleListViewModelSource = r'''
import 'package:foxy/entity/codegen_sample_entity.dart';
import 'package:foxy/repository/codegen_sample_repository.dart';
import 'package:foxy_annotation/list_annotations.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/view_model/query_version_mixin.dart';

part 'codegen_sample_list_view_model.g.dart';

@FoxyListViewModel(
  entity: CodegenSampleEntity,
  repository: CodegenSampleRepository,
)
class CodegenSampleListViewModel
    with FieldControllerMixin, QueryVersionMixin, _CodegenSampleListViewModelMixin {}
''';

const _sampleDetailViewModelSource = r'''
import 'package:foxy/entity/codegen_sample_entity.dart';
import 'package:foxy/repository/codegen_sample_repository.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/widget/form/field_controller.dart';

part 'codegen_sample_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: CodegenSampleEntity,
  repository: CodegenSampleRepository,
  nullable: {'description'},
)
class CodegenSampleDetailViewModel
    with FieldControllerMixin, _CodegenSampleDetailViewModelMixin {}
''';

final class _ParseableDart extends Matcher {
  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    // testBuilder hands matchers the raw output bytes, not a String.
    final content = item is String ? item : utf8.decode(item as List<int>);
    final result = parseString(content: content);
    if (result.errors.isNotEmpty) {
      matchState['errors'] = result.errors
          .map((e) => '${e.message} at ${e.offset}')
          .toList();
      return false;
    }
    return true;
  }

  @override
  Description describe(Description description) =>
      description.add('parseable Dart source');
}
