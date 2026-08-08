// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy_generator/src/naming.dart';
import 'package:foxy_generator/src/repository_filter_model.dart';

final class RepositoryFilterReader {
  const RepositoryFilterReader();

  Future<RepositoryFilterGenerationModel> read(
    ClassElement element,
    List<DartObject> annotations,
    BuildStep buildStep,
  ) async {
    final repositoryClassName = element.name;
    if (repositoryClassName == null ||
        !repositoryClassName.endsWith('Repository')) {
      _fail(
        '@FoxyFilter can only annotate a class ending with Repository.',
        element,
        'Use a concrete Repository class as the Filter owner.',
      );
    }

    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${toSnakeCase(repositoryClassName)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$repositoryClassName must be located in $expectedFileName; the '
            'current file is $inputFileName.',
        element,
        'Keep the Repository class consistent with the file name.',
      );
    }

    final source = await buildStep.readAsString(buildStep.inputId);
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    if (!source.contains("part '$partName';") &&
        !source.contains('part "$partName";')) {
      _fail(
        '$repositoryClassName is missing part \'$partName\';.',
        element,
        'Declare the generated part after the Repository imports.',
      );
    }

    final baseName = repositoryClassName.substring(
      0,
      repositoryClassName.length - 'Repository'.length,
    );
    final filterClassName = '${baseName}Filter';
    final names = <String>{};
    final fields = <RepositoryFilterFieldModel>[];
    for (final object in annotations) {
      final field = readFilterField(object, filterClassName, element);
      if (!names.add(field.name)) {
        _fail(
          '$filterClassName declares field ${field.name} more than once.',
          element,
          'Ensure each @FoxyFilter field name is unique.',
        );
      }
      fields.add(field);
    }

    return RepositoryFilterGenerationModel(
      className: filterClassName,
      fields: List.unmodifiable(fields),
      repositoryClassName: repositoryClassName,
    );
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\nFix: $correction',
      element: element,
    );
  }
}

/// Parses the field model from a single `@FoxyFilter` annotation, shared by
/// the Filter and Repository generators so both read the same field
/// definition.
///
/// Returns an empty string when `column` is not declared; callers decide
/// whether to infer or error out.
RepositoryFilterFieldModel readFilterField(
  DartObject object,
  String filterClassName,
  Element element,
) {
  final reader = ConstantReader(object);
  final name = reader.read('name').stringValue;
  if (!RegExp(r'^[a-z][A-Za-z0-9]*_?$').hasMatch(name)) {
    _fail(
      'The field name $name of $filterClassName is not a valid '
          'lowerCamelCase identifier.',
      element,
      'Use lowerCamelCase; Dart reserved words may append a single '
          'underscore.',
    );
  }

  final typeIndex = reader
      .read('type')
      .objectValue
      .getField('index')
      ?.toIntValue();
  if (typeIndex == null ||
      typeIndex < 0 ||
      typeIndex >= FoxyFilterType.values.length) {
    _fail(
      'The type of $filterClassName.$name is unrecognized.',
      element,
      'Use the text/integer/decimal/boolean named constructors of '
          'FoxyFilter.',
    );
  }
  final type = FoxyFilterType.values[typeIndex];
  final defaultValue = _convertDefault(
    reader.read('defaultValue').objectValue,
    type,
  );
  if (defaultValue == null) {
    _fail(
      'The default value of $filterClassName.$name is incompatible with '
          'type ${type.name}.',
      element,
      'Pass a correct default value via the corresponding FoxyFilter named '
          'constructor.',
    );
  }

  return RepositoryFilterFieldModel(
    column: reader.peek('column')?.stringValue ?? '',
    defaultValue: defaultValue,
    name: name,
    type: type,
  );
}

Never _fail(String message, Element element, String correction) {
  throw InvalidGenerationSourceError(
    '$message\nFix: $correction',
    element: element,
  );
}

Object? _convertDefault(DartObject object, FoxyFilterType type) =>
    switch (type) {
      FoxyFilterType.boolean => object.toBoolValue(),
      FoxyFilterType.decimal =>
        object.toDoubleValue() ?? object.toIntValue()?.toDouble(),
      FoxyFilterType.integer => object.toIntValue(),
      FoxyFilterType.text => object.toStringValue(),
    };
