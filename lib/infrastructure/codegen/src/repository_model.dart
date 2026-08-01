import 'repository_filter_model.dart';

final class RepositoryGenerationModel {
  final String entityClassName;
  final String entityParameterName;
  final List<RepositoryFilterFieldModel> filterFields;
  final List<RepositoryKeyFieldModel> keyFields;
  final String mixinName;
  final List<String> briefProjectionColumns;
  final bool queryLayerEnabled;
  final String repositoryClassName;
  final String table;

  const RepositoryGenerationModel({
    required this.entityClassName,
    required this.entityParameterName,
    required this.filterFields,
    required this.keyFields,
    required this.mixinName,
    required this.briefProjectionColumns,
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
