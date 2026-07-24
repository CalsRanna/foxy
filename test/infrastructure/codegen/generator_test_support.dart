const standardEntityAsset = 'foxy|lib/entity/codegen_sample_entity.dart';

const annotationAsset =
    'foxy|lib/infrastructure/codegen/entity_annotations.dart';

const annotationSource = r'''
class FoxyBriefEntity {
  const FoxyBriefEntity();
}

class FoxyBriefField {
  final Object? defaultValue;
  final String? name;
  final FoxyBriefFieldType? type;

  const FoxyBriefField()
      : defaultValue = null,
        name = null,
        type = null;

  const FoxyBriefField.boolean(this.name, {bool this.defaultValue = false})
    : type = FoxyBriefFieldType.boolean;

  const FoxyBriefField.decimal(this.name, {double this.defaultValue = 0.0})
    : type = FoxyBriefFieldType.decimal;

  const FoxyBriefField.integer(this.name, {int this.defaultValue = 0})
    : type = FoxyBriefFieldType.integer;

  const FoxyBriefField.text(this.name, {String this.defaultValue = ''})
    : type = FoxyBriefFieldType.text;
}

enum FoxyBriefFieldType { boolean, decimal, integer, text }

class FoxyFullEntity {
  final String table;

  const FoxyFullEntity({required this.table});
}

class FoxyFullField {
  final String name;
  final bool key;

  const FoxyFullField(this.name, {this.key = false});
}
''';

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
