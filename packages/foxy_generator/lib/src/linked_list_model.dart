import 'form_model.dart';

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
  });

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);

  String get briefEntityClassName => 'Brief${baseName}Entity';

  /// `CreatureQuestItemEntity` → `creatureQuestItem`。
  String get entityCamelName {
    final base = baseName;
    return '${base[0].toLowerCase()}${base.substring(1)}';
  }
}
