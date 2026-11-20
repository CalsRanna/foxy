// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:foxy_generator/src/convention.dart';
import 'package:foxy_generator/src/dart_literal.dart';
import 'package:foxy_generator/src/entity_resolver.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

const _fullEntityChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullEntity',
);
const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullField',
);
const _meaningChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/semantic_annotations.dart#FoxyFieldMeaning',
);

/// The builder's synthetic input; view inference runs only for it so test
/// builds (which run the builder on several inputs) stay single-output.
const _semanticsInputPath = 'lib/constant/agent_field_semantics.dart';

const _vmCheckers = [
  TypeChecker.fromUrl(
    'package:foxy_annotation/form_annotations.dart#FoxyDetailViewModel',
  ),
  TypeChecker.fromUrl(
    'package:foxy_annotation/form_annotations.dart#FoxyLinkedDetailViewModel',
  ),
  TypeChecker.fromUrl(
    'package:foxy_annotation/form_annotations.dart#FoxyLinkedListViewModel',
  ),
  TypeChecker.fromUrl(
    'package:foxy_annotation/list_annotations.dart#FoxyListViewModel',
  ),
];

DartObject? _constObject(Expression? expression) {
  final Element? element;
  if (expression is SimpleIdentifier) {
    element = expression.element;
  } else if (expression is PrefixedIdentifier) {
    element = expression.identifier.element;
  } else if (expression is PropertyAccess) {
    element = expression.propertyName.element;
  } else {
    element = null;
  }
  if (element is PropertyAccessorElement) {
    return element.variable.computeConstantValue();
  }
  if (element is VariableElement) {
    return element.computeConstantValue();
  }
  return null;
}

String? _controllerFieldName(Expression expression) {
  final name = switch (expression) {
    PrefixedIdentifier(:final identifier) => identifier.name,
    PropertyAccess(:final propertyName) => propertyName.name,
    _ => null,
  };
  const suffix = 'Controller';
  if (name == null || !name.endsWith(suffix)) return null;
  return name.substring(0, name.length - suffix.length);
}

List<_FlagMeaning>? _flagMeanings(DartObject? object) {
  final list = object?.toListValue();
  if (list == null || list.isEmpty) return null;
  final result = <_FlagMeaning>[];
  for (final item in list) {
    final value = item.getField('value')?.toIntValue();
    final label = item.getField('label')?.toStringValue();
    if (value == null || label == null) return null;
    result.add(_FlagMeaning(value: value, label: label));
  }
  return result;
}

Map<int, String>? _intStringMap(DartObject? object) {
  final map = object?.toMapValue();
  if (map == null || map.isEmpty) return null;
  final result = <int, String>{};
  for (final entry in map.entries) {
    final key = entry.key?.toIntValue();
    final value = entry.value?.toStringValue();
    if (key == null || value == null) return null;
    result[key] = value;
  }
  return result;
}

DartType? _receiverType(Expression expression) {
  if (expression is PrefixedIdentifier) return expression.prefix.staticType;
  if (expression is PropertyAccess) return expression.realTarget.staticType;
  return null;
}

/// Aggregates `@FoxyFieldMeaning` declarations across all entity files into a
/// single runtime map consumed by non-UI consumers (the agent catalog).
///
/// The builder's primary input is `lib/constant/agent_field_semantics.dart`;
/// entity files are discovered through [BuildStep.findAssets], so the registry
/// stays a code-generation product rather than a hand-maintained table.
final class FoxySemanticsGenerator implements Generator {
  const FoxySemanticsGenerator();

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    // Entity scanning is global, so only the synthetic input emits the
    // registry (production wiring also limits the builder to this file).
    if (buildStep.inputId.path != _semanticsInputPath) return null;
    final stats = _InferenceStats();
    final tables = <String, Map<String, _ColumnMeaning>>{};
    await for (final asset in buildStep.findAssets(
      Glob('lib/entity/**_entity.dart'),
    )) {
      final element = await buildStep.resolver.libraryFor(asset);
      for (final classElement in LibraryReader(element).classes) {
        _collectClass(classElement, tables);
      }
    }
    await _collectViews(buildStep, tables, stats);
    if (tables.isEmpty) return null;
    return _emit(tables);
  }

  Future<bool> _applyPicker(
    BuildStep buildStep,
    Map<String, Map<String, _ColumnMeaning>> tables,
    _ViewPicker picker,
    _InferenceStats stats,
  ) async {
    final vm = picker.vm;
    if (vm == null) {
      stats.noVm++;
      return false;
    }
    final entity = await _entityOfViewModel(buildStep, vm);
    if (entity == null) {
      stats.noEntity++;
      return false;
    }
    final table =
        ConstantReader(_fullEntityChecker.firstAnnotationOfExact(entity))
            .peek('table')
            ?.stringValue ??
        tableNameOf(entity.name ?? '');
    if (table.isEmpty) {
      stats.noEntity++;
      return false;
    }
    final field = entity.fields
        .where((field) => !field.isStatic && field.isOriginDeclaration)
        .where(
          (field) =>
              field.name == picker.fieldName ||
              field.name == '${picker.fieldName}_',
        )
        .firstOrNull;
    if (field == null) {
      stats.noField++;
      return false;
    }
    final column = ConstantReader(
      _fullFieldChecker.firstAnnotationOfExact(field),
    ).peek('name')?.stringValue;
    if (column == null || column.isEmpty) {
      stats.noColumn++;
      return false;
    }
    final tableMeanings = tables.putIfAbsent(table, () => {});
    if (tableMeanings.containsKey(column)) return false;
    final label = picker.label.isEmpty ? column : picker.label;
    final meaning = picker.enumValues != null
        ? _ColumnMeaning.enumValues(label, picker.enumValues!)
        : _ColumnMeaning.flags(label, picker.flags!);
    tableMeanings[column] = meaning;
    return true;
  }

  void _collectClass(
    ClassElement classElement,
    Map<String, Map<String, _ColumnMeaning>> tables,
  ) {
    final entity = _fullEntityChecker.firstAnnotationOfExact(classElement);
    if (entity == null) return;
    final className = classElement.name ?? '';
    final table =
        ConstantReader(entity).peek('table')?.stringValue ??
        tableNameOf(className);
    if (table.isEmpty) {
      throw InvalidGenerationSourceError(
        '$className has no derivable physical table name.',
        todo: "Fix: pass table: 'physical_table_name' to @FoxyFullEntity.",
        element: classElement,
      );
    }
    for (final field in classElement.fields.where(
      (field) => !field.isStatic && field.isOriginDeclaration,
    )) {
      final meaning = _meaningChecker.firstAnnotationOfExact(field);
      if (meaning == null) continue;
      final fullField = _fullFieldChecker.firstAnnotationOfExact(field);
      final column = fullField == null
          ? null
          : ConstantReader(fullField).peek('name')?.stringValue;
      if (column == null || column.isEmpty) {
        throw InvalidGenerationSourceError(
          '@FoxyFieldMeaning on ${classElement.name}.${field.name} requires '
          '@FoxyFullField(name: ...).',
          todo: 'Fix: annotate the field with @FoxyFullField.',
          element: field,
        );
      }
      final tableMeanings = tables.putIfAbsent(table, () => {});
      if (tableMeanings.containsKey(column)) {
        throw InvalidGenerationSourceError(
          'Column "$column" of table "$table" declares @FoxyFieldMeaning '
          'more than once.',
          todo: 'Fix: keep a single semantics declaration per column.',
          element: field,
        );
      }
      tableMeanings[column] = _readMeaning(meaning, field);
    }
  }

  /// Infers semantics from `FoxyEnumPicker` / `FoxyFlagPicker` usages in
  /// view files: the UI already wires each controller to a const definition,
  /// so annotations only need to cover fields the views do not render.
  /// Annotation-provided meanings always win; anything that does not resolve
  /// cleanly is skipped.
  Future<void> _collectViews(
    BuildStep buildStep,
    Map<String, Map<String, _ColumnMeaning>> tables,
    _InferenceStats stats,
  ) async {
    await for (final asset in buildStep.findAssets(
      Glob('lib/page/**_view.dart'),
    )) {
      stats.views++;
      final LibraryElement library;
      final AstNode? node;
      try {
        library = await buildStep.resolver.libraryFor(asset);
        node = await buildStep.resolver.astNodeFor(
          library.firstFragment,
          resolve: true,
        );
      } catch (_) {
        stats.resolveFailures++;
        continue;
      }
      if (node == null) {
        stats.resolveFailures++;
        continue;
      }
      final pickers = <_ViewPicker>[];
      node.accept(_ViewPickerVisitor(pickers.add));
      stats.pickers += pickers.length;
      for (final picker in pickers) {
        if (await _applyPicker(buildStep, tables, picker, stats)) {
          stats.applied++;
        }
      }
    }
  }

  String _emit(Map<String, Map<String, _ColumnMeaning>> tables) {
    final buffer = StringBuffer()
      ..writeln('abstract final class AgentFieldSemantics {')
      ..writeln(
        '  static const values = '
        '<String, Map<String, ColumnSemantics>>{',
      );
    final tableNames = tables.keys.toList()..sort();
    for (final table in tableNames) {
      buffer.writeln('    ${dartStringLiteral(table)}: {');
      final columns = tables[table]!;
      final columnNames = columns.keys.toList()..sort();
      for (final column in columnNames) {
        buffer.writeln(
          '      ${dartStringLiteral(column)}: ${columns[column]!.toDart()},',
        );
      }
      buffer.writeln('    },');
    }
    buffer
      ..writeln('  };')
      ..writeln('}');
    return buffer.toString();
  }

  Future<ClassElement?> _entityOfViewModel(
    BuildStep buildStep,
    ClassElement vm,
  ) async {
    for (final checker in _vmCheckers) {
      final annotation = checker.firstAnnotationOfExact(vm);
      if (annotation == null) continue;
      final type = ConstantReader(annotation).peek('entity')?.typeValue;
      final element = type is InterfaceType ? type.element : null;
      if (element is ClassElement) return element;
      break;
    }
    final name = vm.name;
    if (name == null) return null;
    final className = entityClassNameOfViewModel(name);
    if (className == null || className.isEmpty) return null;
    try {
      return await resolveClass(
        buildStep,
        vm,
        className,
        'entity',
        'Agent field semantics',
      );
    } on InvalidGenerationSourceError {
      return null;
    }
  }

  _ColumnMeaning _readMeaning(DartObject annotation, FieldElement field) {
    final label = annotation.getField('label')?.toStringValue() ?? '';
    if (label.isEmpty) {
      throw InvalidGenerationSourceError(
        '@FoxyFieldMeaning on $field declares an empty label.',
        todo: 'Fix: pass a human-readable label.',
        element: field,
      );
    }
    final values = annotation.getField('values')?.toMapValue();
    if (values != null && values.isNotEmpty) {
      final options = <int, String>{};
      for (final entry in values.entries) {
        final key = entry.key?.toIntValue();
        final value = entry.value?.toStringValue();
        if (key == null || value == null) {
          throw InvalidGenerationSourceError(
            '@FoxyFieldMeaning on $field has a non int→String values map.',
            todo: 'Fix: use Map<int, String> for enum values.',
            element: field,
          );
        }
        options[key] = value;
      }
      return _ColumnMeaning.enumValues(label, options);
    }
    final flags = annotation.getField('flags')?.toListValue();
    if (flags != null && flags.isNotEmpty) {
      final items = <_FlagMeaning>[];
      for (final flag in flags) {
        final value = flag.getField('value')?.toIntValue();
        final flagLabel = flag.getField('label')?.toStringValue();
        if (value == null || flagLabel == null) {
          throw InvalidGenerationSourceError(
            '@FoxyFieldMeaning on $field has an invalid FlagItem.',
            todo: 'Fix: use FlagItem(value, label) constants.',
            element: field,
          );
        }
        items.add(_FlagMeaning(value: value, label: flagLabel));
      }
      return _ColumnMeaning.flags(label, items);
    }
    final referenceTable = annotation
        .getField('referenceTable')
        ?.toStringValue();
    final referenceColumn = annotation
        .getField('referenceColumn')
        ?.toStringValue();
    if (referenceTable != null &&
        referenceColumn != null &&
        referenceTable.isNotEmpty &&
        referenceColumn.isNotEmpty) {
      return _ColumnMeaning.reference(
        label,
        table: referenceTable,
        column: referenceColumn,
      );
    }
    throw InvalidGenerationSourceError(
      '@FoxyFieldMeaning on $field declares no values, flags or reference '
      'target.',
      todo: 'Fix: use FoxyFieldMeaning.enumValues / .flags / .reference.',
      element: field,
    );
  }
}

final class _ColumnMeaning {
  final String label;

  final _MeaningKind kind;

  final Map<int, String> values;

  final List<_FlagMeaning> flags;

  final String? referenceTable;

  final String? referenceColumn;

  const _ColumnMeaning.enumValues(String label, Map<int, String> values)
    : this._(label, _MeaningKind.enumValues, values, const [], null, null);

  const _ColumnMeaning.flags(String label, List<_FlagMeaning> flags)
    : this._(label, _MeaningKind.flags, const {}, flags, null, null);

  const _ColumnMeaning.reference(
    String label, {
    required String table,
    required String column,
  }) : this._(label, _MeaningKind.reference, const {}, const [], table, column);

  const _ColumnMeaning._(
    this.label,
    this.kind,
    this.values,
    this.flags,
    this.referenceTable,
    this.referenceColumn,
  );

  String toDart() => switch (kind) {
    _MeaningKind.enumValues =>
      'ColumnSemantics.enumValues(label: ${dartStringLiteral(label)}, '
          'values: {${values.entries.map((entry) => '${entry.key}: ${dartStringLiteral(entry.value)}').join(', ')}})',
    _MeaningKind.flags =>
      'ColumnSemantics.flags(label: ${dartStringLiteral(label)}, flags: '
          '[${flags.map((flag) => 'ColumnFlag(value: ${flag.value}, label: ${dartStringLiteral(flag.label)})').join(', ')}])',
    _MeaningKind.reference =>
      'ColumnSemantics.reference(label: ${dartStringLiteral(label)}, '
          'reference: ColumnReference(table: ${dartStringLiteral(referenceTable!)}, '
          'column: ${dartStringLiteral(referenceColumn!)}))',
  };
}

final class _FlagMeaning {
  final int value;

  final String label;

  const _FlagMeaning({required this.value, required this.label});
}

final class _InferenceStats {
  var views = 0;

  var pickers = 0;

  var applied = 0;

  var noVm = 0;

  var noEntity = 0;

  var noField = 0;

  var noColumn = 0;

  var resolveFailures = 0;
}

enum _MeaningKind { enumValues, flags, reference }

final class _ViewPicker {
  final String fieldName;

  final ClassElement? vm;

  final String label;

  final Map<int, String>? enumValues;

  final List<_FlagMeaning>? flags;

  const _ViewPicker({
    required this.fieldName,
    required this.vm,
    required this.label,
    this.enumValues,
    this.flags,
  });
}

final class _ViewPickerVisitor extends RecursiveAstVisitor<void> {
  final void Function(_ViewPicker picker) onPicker;

  _ViewPickerVisitor(this.onPicker);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    // Descend regardless of the match: pickers are usually nested inside
    // FoxyFormItem(child: ...) constructor arguments.
    super.visitInstanceCreationExpression(node);
    final typeName = node.constructorName.type.name.lexeme;
    final isEnum = typeName == 'FoxyEnumPicker';
    final isFlags = typeName == 'FoxyFlagPicker';
    if (!isEnum && !isFlags) return;
    final arguments = <String, Expression>{};
    for (final argument in node.argumentList.arguments) {
      if (argument is NamedArgument) {
        arguments[argument.name.lexeme] = argument.argumentExpression;
      }
    }
    final controller = arguments['controller'];
    if (controller == null) return;
    final fieldName = _controllerFieldName(controller);
    if (fieldName == null) return;
    final type = _receiverType(controller);
    final interface = type is InterfaceType ? type.element : null;
    final vm = interface is ClassElement ? interface : null;
    final title = arguments['title'];
    final label = title is StringLiteral ? (title.stringValue ?? '') : '';
    if (isEnum) {
      final values = _intStringMap(_constObject(arguments['options']));
      if (values == null || values.isEmpty) return;
      onPicker(
        _ViewPicker(
          fieldName: fieldName,
          vm: vm,
          label: label,
          enumValues: values,
        ),
      );
    } else {
      final flags = _flagMeanings(_constObject(arguments['flags']));
      if (flags == null || flags.isEmpty) return;
      onPicker(
        _ViewPicker(fieldName: fieldName, vm: vm, label: label, flags: flags),
      );
    }
  }
}
