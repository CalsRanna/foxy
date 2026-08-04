/// The controller intent of a form field.
enum FormFieldKind {
  /// Inferred from the field's Dart type (Int/Double/String/Bool).
  plain,

  /// `SelectFieldController`。
  select,

  /// `FlagFieldController`。
  flag,

  /// `IntFieldControllerGroup` (dynamic field editing).
  group,

  /// `NullableStringFieldController`。
  nullable,
}

final class FormFieldModel {
  /// Entity field name (the named parameter of collect/apply; also the
  /// source of the controller name).
  final String dartName;

  final String dartType;
  final FormFieldKind kind;

  /// Fallback value when `kind == select` (int or String).
  final Object? selectFallback;

  const FormFieldModel({
    required this.dartName,
    required this.dartType,
    required this.kind,
    this.selectFallback,
  });
}

final class FormGenerationModel {
  /// Hand-written Detail ViewModel class name, e.g. `TalentDetailViewModel`.
  final String className;

  /// Full Entity class name the form maps to, e.g. `TalentEntity`.
  final String entityClassName;

  /// Generated part mixin name, e.g. `_TalentDetailViewModelMixin`.
  final String mixinName;

  /// Fields ordered by the entity's constructor parameters, minus excluded
  /// ones.
  final List<FormFieldModel> fields;

  /// Whether to generate the behavior skeleton (the annotation declared
  /// `repository:`).
  final bool skeletonEnabled;

  /// Repository class name providing store/update/get/create.
  final String repositoryClassName;

  /// Physical Key type: `int` or composite `XxxKey`.
  final String keyType;

  /// Dart name of the single key field (null for composite keys); persist
  /// uses it to write back persistedKey.
  final String? singleKeyFieldName;

  const FormGenerationModel({
    required this.className,
    required this.entityClassName,
    required this.mixinName,
    required this.fields,
    required this.skeletonEnabled,
    required this.repositoryClassName,
    required this.keyType,
    required this.singleKeyFieldName,
  });

  /// `TalentEntity` → `talent` (matches the Repository's entity parameter
  /// naming).
  String get entityCamelName {
    final base = entityClassName.substring(
      0,
      entityClassName.length - 'Entity'.length,
    );
    return '${base[0].toLowerCase()}${base.substring(1)}';
  }

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);
}
