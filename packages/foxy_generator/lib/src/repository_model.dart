import 'package:foxy_generator/src/repository_filter_model.dart';

final class RepositoryGenerationModel {
  final String entityClassName;
  final String entityParameterName;
  final List<RepositoryFilterFieldModel> filterFields;
  final List<RepositoryKeyFieldModel> keyFields;
  final String mixinName;
  final List<String> briefProjectionColumns;

  /// Whether `lib/view_model/<base>_list_view_model.dart` exists
  /// (main-table list page).
  /// Full-list `getXxxs` and `_applyFilter` are only generated for main-table
  /// repositories.
  final bool listViewModelPresent;

  /// Whether to generate `get*Locales`/`save*Locales` delegates (the
  /// repository mixes in `DbcLocaleRepositoryMixin` and declares
  /// `dbcLocaleTableName`).
  final bool localeHelpersEnabled;

  /// Link-key field list (child-table repositories declaring `linkKey:`);
  /// empty = main-table form.
  final List<RepositoryKeyFieldModel> linkKeyFields;

  /// Field declared via `autoIncrementKey:` (dart name); null = not
  /// declared.
  final String? autoIncrementKey;

  /// Scope fields declared via `autoIncrementScope:` (dart names).
  final List<String> autoIncrementScope;
  final bool queryLayerEnabled;
  final String repositoryClassName;
  final String table;

  const RepositoryGenerationModel({
    required this.entityClassName,
    required this.entityParameterName,
    required this.filterFields,
    required this.keyFields,
    required this.listViewModelPresent,
    required this.localeHelpersEnabled,
    required this.mixinName,
    required this.briefProjectionColumns,
    required this.linkKeyFields,
    required this.autoIncrementKey,
    required this.autoIncrementScope,
    required this.queryLayerEnabled,
    required this.repositoryClassName,
    required this.table,
  });

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);

  String get briefEntityClassName => 'Brief${baseName}Entity';

  String get filterClassName => '${baseName}Filter';

  String get keyType =>
      keyFields.length == 1 ? keyFields.single.dartType : '${baseName}Key';
}

final class RepositoryKeyFieldModel {
  final String columnName;
  final String dartName;
  final String dartType;

  const RepositoryKeyFieldModel({
    required this.columnName,
    required this.dartName,
    required this.dartType,
  });
}
