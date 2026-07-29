import 'dart:io';

const standardEntityAsset = 'foxy|lib/entity/codegen_sample_entity.dart';

const annotationAsset =
    'foxy|lib/infrastructure/codegen/entity_annotations.dart';

/// 直接读取真实注解源码，而不是在测试里维护一份手抄副本。
///
/// 副本会在注解新增参数或改默认值后悄悄失真，让测试对着旧定义通过。
/// 测试从仓库根目录运行（见 AGENTS.md）。
final annotationSource = File(
  'lib/infrastructure/codegen/entity_annotations.dart',
).readAsStringSync();

const standardEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

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

const compositeEntityAsset = 'foxy|lib/entity/codegen_relation_entity.dart';

const compositeEntitySource = r'''
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

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

Map<String, String> sourceAsset(String asset, String source) => {
  annotationAsset: annotationSource,
  asset: source,
};

bool logContains(List<String> logs, String message) =>
    logs.any((log) => log.contains(message));
