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
  final FoxyFilterType type;

  const RepositoryFilterFieldModel({
    required this.defaultValue,
    required this.name,
    required this.type,
  });

  String get dartType => switch (type) {
    FoxyFilterType.boolean => 'bool',
    FoxyFilterType.decimal => 'double',
    FoxyFilterType.integer => 'int',
    FoxyFilterType.text => 'String',
  };
}
