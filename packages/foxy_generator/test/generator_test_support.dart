import 'dart:io';

const annotationAsset =
    'foxy_annotation|lib/entity_annotations.dart';

const compositeEntityAsset = 'foxy|lib/entity/codegen_relation_entity.dart';

const compositeEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

part 'codegen_relation_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'codegen_relation')
class CodegenRelationEntity with _CodegenRelationEntityMixin {
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

  factory CodegenRelationEntity.fromJson(Map<String, dynamic> json) =>
      _CodegenRelationEntityMixin.fromJson(json);
}
''';

const standardEntityAsset = 'foxy|lib/entity/codegen_sample_entity.dart';

const standardEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

part 'codegen_sample_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.codegen_sample')
class CodegenSampleEntity with _CodegenSampleEntityMixin {
  static const defaultRatio = 100.0;

  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Ratio')
  final double ratio;

  @FoxyBriefField()
  @FoxyFullField('Name')
  final String name;

  @FoxyFullField('Enabled')
  final bool enabled;

  @FoxyFullField('Description')
  final String? description;

  const CodegenSampleEntity({
    this.id = 0,
    this.ratio = defaultRatio,
    this.name = '',
    this.enabled = false,
    this.description,
  });

  factory CodegenSampleEntity.fromJson(Map<String, dynamic> json) =>
      _CodegenSampleEntityMixin.fromJson(json);
}
''';

/// Reads the real annotation source directly instead of keeping a
/// hand-copied duplicate in tests.
///
/// 读取 workspace 兄弟包的真实源码(防测试与实现漂移:注解/混入源改动时
/// 测试立即暴露,而不是守着过期的手抄副本)。
///
/// 路径以 foxy_generator 包根为基准;跨包相对路径只集中在这里,其他
/// 测试文件一律通过 [foxyAnnotationSource] / [foxyAppSource] 获取。
String foxyAnnotationSource(String file) =>
    File('../foxy_annotation/lib/$file').readAsStringSync();

/// 读取主 app 包的真实源码(如 repository mixin 实现)。
String foxyAppSource(String file) =>
    File('../foxy/lib/$file').readAsStringSync();

final annotationSource = foxyAnnotationSource('entity_annotations.dart');

bool logContains(List<String> logs, String message) =>
    logs.any((log) => log.contains(message));

Map<String, String> sourceAsset(String asset, String source) => {
  annotationAsset: annotationSource,
  asset: source,
};
