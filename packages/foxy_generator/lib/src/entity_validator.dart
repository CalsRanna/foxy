// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/entity_model.dart';

final class EntityValidator {
  const EntityValidator();

  void validate(EntityGenerationModel model, ClassElement element) {
    if (model.table.trim().isEmpty) {
      _fail(
        '@FoxyFullEntity.table of ${model.className} must not be empty.',
        element,
        'Fill in the full physical table name.',
      );
    }
    if (!model.className.endsWith('Entity')) {
      _fail(
        '${model.className} must end with Entity.',
        element,
        'Name the Full Entity in the form <Name>Entity.',
      );
    }
    if (model.keyFields.isEmpty) {
      _fail(
        '${model.className} has no physical primary key field.',
        element,
        'Set key: true on at least one @FoxyFullField.',
      );
    }

    final columns = <String>{};
    final dartNames = <String>{};
    for (final field in model.fields) {
      dartNames.add(field.dartName);
      if (field.columnName.trim().isEmpty) {
        _fail(
          'The physical column name of ${model.className}.${field.dartName} '
              'must not be empty.',
          element.getField(field.dartName) ?? element,
          'Fill in the exact physical column name for @FoxyFullField.',
        );
      }
      if (!columns.add(field.columnName)) {
        _fail(
          '${model.className} declares the physical column name '
              '${field.columnName} more than once.',
          element.getField(field.dartName) ?? element,
          'Ensure each @FoxyFullField.name is unique and case-sensitive '
              'within the Entity.',
        );
      }
    }

    final projectionNames = <String>{};
    for (final field in model.briefProjectionFields) {
      if (field.dartName.trim().isEmpty) {
        _fail(
          'The Brief projection field name of ${model.className} must not '
              'be empty.',
          element,
          'Fill in the field name for the FoxyBriefField named constructor.',
        );
      }
      if (!RegExp(r'^[a-z][A-Za-z0-9]*$').hasMatch(field.dartName)) {
        _fail(
          'The Brief projection field name ${field.dartName} of '
              '${model.className} is not a valid lowerCamelCase identifier.',
          element,
          'Use a valid Dart field name and have the Repository query use a '
              'same-named alias.',
        );
      }
      if (dartNames.contains(field.dartName) ||
          !projectionNames.add(field.dartName)) {
        _fail(
          '${model.className} declares Brief field ${field.dartName} more '
              'than once.',
          element,
          'Projection fields must not duplicate Full fields or other '
              'projection fields.',
        );
      }
    }

    if (model.generateBrief) {
      final missingKeys = model.keyFields
          .where((field) => !field.includeInBrief)
          .map((field) => field.dartName)
          .toList(growable: false);
      if (missingKeys.isNotEmpty) {
        _fail(
          '${model.briefClassName} is missing the full physical identity; '
              '${missingKeys.join(', ')} must be annotated with '
              '@FoxyBriefField.',
          element,
          'Add @FoxyBriefField to all key fields.',
        );
      }
    } else {
      final briefField = model.fields
          .where((field) => field.includeInBrief)
          .firstOrNull;
      if (briefField != null || model.briefProjectionFields.isNotEmpty) {
        _fail(
          '${model.className}'
              '${briefField == null ? '' : '.${briefField.dartName}'} '
              'uses @FoxyBriefField, but the class has no @FoxyBriefEntity.',
          briefField == null
              ? element
              : element.getField(briefField.dartName) ?? element,
          'Add @FoxyBriefEntity to the class, or remove the field '
              'annotation.',
        );
      }
    }
  }

  Never _fail(String message, Element element, String todo) {
    throw InvalidGenerationSourceError(message, element: element, todo: todo);
  }
}
