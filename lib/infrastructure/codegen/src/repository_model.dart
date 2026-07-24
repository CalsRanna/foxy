final class RepositoryGenerationModel {
  final String entityClassName;
  final String entityParameterName;
  final bool generateDestroy;
  final bool generateGet;
  final bool generateStore;
  final bool generateUpdate;
  final List<RepositoryKeyFieldModel> keyFields;
  final String mixinName;
  final String repositoryClassName;
  final String table;

  const RepositoryGenerationModel({
    required this.entityClassName,
    required this.entityParameterName,
    required this.generateDestroy,
    required this.generateGet,
    required this.generateStore,
    required this.generateUpdate,
    required this.keyFields,
    required this.mixinName,
    required this.repositoryClassName,
    required this.table,
  });

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);

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
