import 'package:foxy_annotation/repository_annotations.dart';

final class RepositoryFilterFieldModel {
  /// Physical column name; `_applyFilter` does an equality match on this
  /// column.
  final String column;
  final Object defaultValue;
  final String name;
  final FoxyFilterType type;

  const RepositoryFilterFieldModel({
    required this.column,
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
