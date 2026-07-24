import '../entity_annotations.dart';

final class EntityGenerationModel {
  final String className;
  final bool generateBrief;
  final bool generateFilter;
  final String inputFileName;
  final String mixinName;
  final String table;
  final List<EntityFieldModel> fields;
  final List<EntityFieldModel> briefProjectionFields;

  const EntityGenerationModel({
    required this.className,
    required this.generateBrief,
    required this.generateFilter,
    required this.inputFileName,
    required this.mixinName,
    required this.table,
    required this.fields,
    required this.briefProjectionFields,
  });

  String get baseName => className.endsWith('Entity')
      ? className.substring(0, className.length - 'Entity'.length)
      : className;

  String get briefClassName => 'Brief${baseName}Entity';

  String get filterClassName => '${baseName}FilterEntity';

  String get keyClassName => '${baseName}Key';

  List<EntityFieldModel> get keyFields =>
      fields.where((field) => field.key).toList(growable: false);

  List<EntityFieldModel> get briefFields => [
    ...fields.where((field) => field.includeInBrief),
    ...briefProjectionFields,
  ];

  List<EntityFieldModel> get filterFields =>
      fields.where((field) => field.filter != null).toList(growable: false);
}

final class EntityFieldModel {
  final String dartName;
  final String dartType;
  final String columnName;
  final Object? constructorDefaultValue;
  final FilterFieldGenerationModel? filter;
  final bool includeInBrief;
  final bool nullable;
  final bool key;

  const EntityFieldModel({
    required this.dartName,
    required this.dartType,
    required this.columnName,
    required this.constructorDefaultValue,
    required this.filter,
    required this.includeInBrief,
    required this.nullable,
    required this.key,
  });

  String get nonNullableType =>
      nullable ? dartType.substring(0, dartType.length - 1) : dartType;
}

final class FilterFieldGenerationModel {
  final Object? defaultValue;
  final FoxyFilterFieldType type;

  const FilterFieldGenerationModel({
    required this.defaultValue,
    required this.type,
  });

  String get dartType => switch (type) {
    FoxyFilterFieldType.boolean => 'bool',
    FoxyFilterFieldType.decimal => 'double',
    FoxyFilterFieldType.integer => 'int',
    FoxyFilterFieldType.text => 'String',
  };
}
