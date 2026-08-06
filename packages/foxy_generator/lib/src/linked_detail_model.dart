import 'package:foxy_generator/src/form_model.dart';

final class LinkedDetailGenerationModel {
  /// Hand-written Linked Detail ViewModel class name, e.g.
  /// `CreatureTemplateAddonLinkedDetailViewModel`.
  final String className;

  /// Full Entity class name the form maps to, e.g.
  /// `CreatureTemplateAddonEntity`.
  final String entityClassName;

  /// Generated part mixin name, e.g.
  /// `_CreatureTemplateAddonLinkedDetailViewModelMixin`.
  final String mixinName;

  /// Fields ordered by the entity's constructor parameters, minus excluded
  /// ones.
  final List<FormFieldModel> fields;

  /// Repository class name providing get/store/update/destroy/create.
  final String repositoryClassName;

  /// Physical Key type (always int in the single-link-key form).
  final String keyType;

  /// Dart name of the single key field; persist writes editingKey back with
  /// it, and _refresh's get-or-create loads by the link key (i.e. the primary
  /// key).
  final String singleKeyFieldName;

  const LinkedDetailGenerationModel({
    required this.className,
    required this.entityClassName,
    required this.mixinName,
    required this.fields,
    required this.repositoryClassName,
    required this.keyType,
    required this.singleKeyFieldName,
  });

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);
}
