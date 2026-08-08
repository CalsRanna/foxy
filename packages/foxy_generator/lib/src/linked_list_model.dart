import 'package:foxy_generator/src/naming.dart';
import 'package:foxy_generator/src/form_model.dart';

final class LinkedListGenerationModel {
  /// Hand-written Linked List ViewModel class name, e.g.
  /// `CreatureQuestItemLinkedListViewModel`.
  final String className;

  /// Full Entity class name the form maps to, e.g.
  /// `CreatureQuestItemEntity`.
  final String entityClassName;

  /// Generated part mixin name, e.g.
  /// `_CreatureQuestItemLinkedListViewModelMixin`.
  final String mixinName;

  /// Fields ordered by the entity's constructor parameters, minus excluded
  /// ones.
  final List<FormFieldModel> fields;

  /// Repository class name providing getBrief/count/create/copy/store/update.
  final String repositoryClassName;

  /// Physical Key type: `int` or composite `XxxKey`.
  final String keyType;

  /// Dart name of the single key field (null for composite keys); the
  /// activity log uses it to get the key from a candidate entity.
  final String? singleKeyFieldName;

  /// Dart name of the link field (the Repository's `linkKey:` declaration;
  /// single-link-key form).
  final String linkFieldName;

  /// Link-key parameter type (always int in the single-link-key form).
  final String linkKeyType;

  /// Physical table name from `@FoxyFullEntity(table:)`.
  final String table;

  /// Candidate name fields on the full entity (priority order, see
  /// ListReader); empty when the table has no name-ish column, in which
  /// case the activity log falls back to the record key.
  final List<String> logNameFields;

  const LinkedListGenerationModel({
    required this.className,
    required this.entityClassName,
    required this.mixinName,
    required this.fields,
    required this.repositoryClassName,
    required this.keyType,
    required this.singleKeyFieldName,
    required this.linkFieldName,
    required this.linkKeyType,
    required this.table,
    required this.logNameFields,
  });

  /// `foxy.dbc_achievement` → `dbc_achievement`; used as the activity-log
  /// module name.
  String get moduleName =>
      table.startsWith('foxy.') ? table.substring(5) : table;

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);

  String get briefEntityClassName => 'Brief${baseName}Entity';

  /// `CreatureQuestItemEntity` → `creatureQuestItem` (reserved words get a
  /// trailing underscore)。
  String get entityCamelName => entityParameterName(entityClassName);
}
