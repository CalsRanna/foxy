import '../repository_annotations.dart';

final class RepositoryFilterGenerationModel {
  final String className;
  final List<RepositoryFilterFieldModel> fields;
  final String repositoryClassName;

  const RepositoryFilterGenerationModel({
    required this.className,
    required this.fields,
    required this.repositoryClassName,
  });
}

final class RepositoryFilterFieldModel {
  final Object defaultValue;
  final String name;
  final FoxyFilterFieldType type;

  const RepositoryFilterFieldModel({
    required this.defaultValue,
    required this.name,
    required this.type,
  });

  String get dartType => switch (type) {
    FoxyFilterFieldType.boolean => 'bool',
    FoxyFilterFieldType.decimal => 'double',
    FoxyFilterFieldType.integer => 'int',
    FoxyFilterFieldType.text => 'String',
  };
}
