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
/// Copies silently drift when annotations gain parameters or change
/// defaults, letting tests pass against stale definitions.
/// Tests run from the foxy_generator package root (workspace member,
/// `../foxy_annotation` resolves to the sibling package).
final annotationSource = File(
  '../foxy_annotation/lib/entity_annotations.dart',
).readAsStringSync();

bool logContains(List<String> logs, String message) =>
    logs.any((log) => log.contains(message));

Map<String, String> sourceAsset(String asset, String source) => {
  annotationAsset: annotationSource,
  asset: source,
};
