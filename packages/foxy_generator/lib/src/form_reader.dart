// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, experimental_member_use

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/convention.dart';
import 'package:foxy_generator/src/entity_resolver.dart';
import 'package:foxy_generator/src/form_model.dart';
import 'package:foxy_generator/src/naming.dart';
import 'package:foxy_generator/src/source_shape.dart';

const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullField',
);

/// Field types supported by default inference (non-nullable).
///
/// `bool` has no dedicated controller; the library-wide convention is
/// `SelectFieldController<int>(fallback: 0)` plus a `collect() == 1`
/// conversion, see pickpocketing_loot_template_linked_list_view_model.dart.
const _supportedPlainTypes = {'int', 'double', 'String', 'bool'};

final class FormReader {
  final SourceShape sourceShape;

  const FormReader({this.sourceShape = const SourceShape()});

  Future<FormGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyDetailViewModel can only annotate a ViewModel class.',
        element,
        'Move the annotation to a concrete Detail ViewModel class.',
      );
    }
    final className = element.name;
    if (className == null || !className.endsWith('ViewModel')) {
      _fail(
        '@FoxyDetailViewModel can only annotate a class ending in '
            'ViewModel.',
        element,
        'Use a concrete Detail ViewModel class.',
      );
    }

    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${toSnakeCase(className)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$className must be in $expectedFileName; current file is '
            '$inputFileName.',
        element,
        'Keep the ViewModel class name consistent with the file name.',
      );
    }

    // Bound entity: explicit `entity:` wins; otherwise derived from the
    // class name (longest ViewModel suffix first, so a `@FoxyDetailViewModel`
    // on a hand-written `*LinkedListViewModel` class still resolves).
    String entityClassName;
    final declaredEntity = annotation.peek('entity');
    if (declaredEntity != null && !declaredEntity.isNull) {
      final entityType = declaredEntity.typeValue;
      if (entityType is! InterfaceType) {
        _fail(
          "The entity parameter of $className's annotation is not an "
              'Entity class.',
          element,
          'Pass a concrete Full Entity type.',
        );
      }
      entityClassName = entityType.element.name!;
      if (!entityClassName.endsWith('Entity')) {
        _fail(
          "The type bound by $className must end in Entity.",
          element,
          'Pass a concrete Full Entity type.',
        );
      }
    } else {
      entityClassName = entityClassNameOfViewModel(className) ??
          _fail(
            '$className cannot derive an entity class name.',
            element,
            'Use a convention suffix: ListViewModel/DetailViewModel/'
                'LinkedListViewModel/LinkedDetailViewModel.',
          );
    }
    final resolved = await resolveFullEntity(
      buildStep,
      element,
      entityClassName,
      "$className's annotation",
    );
    final entityElement = resolved.entityElement;
    final table = resolved.table;

    final constructor = entityElement.unnamedConstructor;
    if (constructor == null || !constructor.isGenerative) {
      _fail(
        '$entityClassName must declare an unnamed generative constructor.',
        entityElement,
        'Add a const $entityClassName({...}) constructor.',
      );
    }

    // `selects` accepts two shapes: a Map (explicit fallback, e.g.
    // {'type': 0}) or a Set (fallback derived from the entity constructor
    // default for the same field, e.g. {'type'}).
    final (declaredSelects, derivedSelects) = _readSelects(annotation, element);
    final flags = _readStringSet(annotation, 'flags');
    final groups = _readStringSet(annotation, 'groups');
    final exclude = _readStringSet(annotation, 'exclude');
    _validateDistinctExceptions(
      className,
      entityClassName,
      {...declaredSelects.keys, ...derivedSelects},
      flags,
      groups,
      exclude,
      element,
    );

    final constructorFieldNames = <String>{};
    for (final parameter in constructor.formalParameters) {
      if (!parameter.isNamed || !parameter.isInitializingFormal) {
        continue;
      }
      constructorFieldNames.add(parameter.name!);
    }
    for (final name in {
      ...declaredSelects.keys,
      ...derivedSelects,
      ...flags,
      ...groups,
      ...exclude,
    }) {
      if (!constructorFieldNames.contains(name)) {
        _fail(
          '$entityClassName has no field named $name.',
          element,
          'Fix the misspelled field name in the annotation.',
        );
      }
    }

    final fields = <FormFieldModel>[];
    for (final parameter in constructor.formalParameters) {
      if (!parameter.isNamed || !parameter.isInitializingFormal) {
        continue;
      }
      final name = parameter.name!;
      if (exclude.contains(name)) continue;
      fields.add(
        _readField(
          className,
          entityClassName,
          name,
          parameter,
          declaredSelects,
          derivedSelects,
          flags,
          groups,
          element,
        ),
      );
    }

    final mixinName = '_${className}Mixin';
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    final unit = await sourceShape.parseInput(buildStep, element);
    final cls = sourceShape.classDeclaration(unit, className);
    if (cls == null) {
      _fail(
        '$className is not declared in the current file.',
        element,
        'Declare the ViewModel class in this file.',
      );
    }
    if (!sourceShape.hasPartDirective(unit, partName)) {
      _fail(
        '$className is missing part \'$partName\';.',
        element,
        'Declare the generated part after the ViewModel imports.',
      );
    }
    final withClause = sourceShape.withClauseTypeNames(cls);
    if (!withClause.contains(mixinName)) {
      _fail(
        '$className must mix in $mixinName.',
        element,
        "Append $mixinName to the end of the ViewModel's with list.",
      );
    }
    final controllerIndex = withClause.indexOf('FieldControllerMixin');
    final mixinIndex = withClause.indexOf(mixinName);
    if (controllerIndex < 0) {
      _fail(
        '$className must mix in FieldControllerMixin.',
        element,
        'Add FieldControllerMixin to the with list.',
      );
    }
    if (controllerIndex > mixinIndex) {
      _fail(
        'FieldControllerMixin must come before $mixinName.',
        element,
        'Reorder the with list: FieldControllerMixin, ..., $mixinName.',
      );
    }

    String repositoryClassName = '';
    String keyType = '';
    String? singleKeyFieldName;
    final repositoryReader = annotation.peek('repository');
    final skeletonDisabled = annotation.peek('skeleton')?.boolValue == false;
    if (repositoryReader != null && !repositoryReader.isNull) {
      if (skeletonDisabled) {
        _fail(
          '$className cannot declare both repository and skeleton: false.',
          element,
          'Keep only repository: (generates a behavior skeleton), or keep '
              'only skeleton: false (no skeleton, no repository).',
        );
      }
      final repositoryType = repositoryReader.typeValue;
      if (repositoryType is! InterfaceType) {
        _fail(
          "The repository parameter of $className's annotation is not a "
              'Repository class.',
          element,
          'Pass a concrete Repository type.',
        );
      }
      repositoryClassName = repositoryType.element.name!;
      if (!repositoryClassName.endsWith('Repository')) {
        _fail(
          "The Repository bound by $className must end in Repository.",
          element,
          'Pass a concrete Repository type.',
        );
      }
    } else if (!skeletonDisabled) {
      // Behavior skeleton on by convention when a same-named repository
      // exists and is migrated; `skeleton: false` opts out.
      final derived = repositoryClassNameOfViewModel(className);
      if (derived != null) {
        final fileName = '${toSnakeCase(derived)}.dart';
        final assetId = AssetId(
          buildStep.inputId.package,
          'lib/repository/$fileName',
        );
        // AST-level presence check: the same-named repository must actually
        // carry the @FoxyRepository annotation (a comment/string mention or
        // a stale file must not enable the behavior skeleton).
        final present = await const SourceShape().fileHasAnnotation(
          buildStep,
          assetId,
          'FoxyRepository',
        );
        if (present) {
          repositoryClassName = derived;
        }
      }
    }
    if (repositoryClassName.isNotEmpty) {
      final keyFieldInfo = _readEntityKeyField(entityElement, element);
      keyType = keyFieldInfo.$1;
      singleKeyFieldName = keyFieldInfo.$2;
    }

    return FormGenerationModel(
      className: className,
      entityClassName: entityClassName,
      mixinName: mixinName,
      fields: List.unmodifiable(fields),
      skeletonEnabled: repositoryClassName.isNotEmpty,
      repositoryClassName: repositoryClassName,
      keyType: keyType,
      singleKeyFieldName: singleKeyFieldName,
      table: table,
    );
  }

  /// Infers the Key from the entity's `@FoxyFullField(key: true)`: a single
  /// key returns (field type, field name), a composite key returns
  /// (`XxxKey`, null).
  (String, String?) _readEntityKeyField(
    InterfaceElement entityElement,
    Element element,
  ) {
    final keyFields = <(String, String)>[];
    for (final field in entityElement.fields.where(
      (field) => !field.isStatic && !field.isSynthetic,
    )) {
      final annotations = _fullFieldChecker.annotationsOf(field).toList();
      if (annotations.length != 1) continue;
      if (!(ConstantReader(annotations.single).peek('key')?.boolValue ??
          false)) {
        continue;
      }
      keyFields.add((field.type.getDisplayString(), field.name!));
    }
    if (keyFields.isEmpty) {
      _fail(
        '${entityElement.name} has no physical Key usable for detail '
            'loading.',
        element,
        'Set key: true on at least one @FoxyFullField.',
      );
    }
    if (keyFields.length == 1) {
      return (keyFields.single.$1, keyFields.single.$2);
    }
    final baseName = entityElement.name!.substring(
      0,
      entityElement.name!.length - 'Entity'.length,
    );
    return ('${baseName}Key', null);
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\nFix: $correction',
      element: element,
    );
  }

  FormFieldModel _readField(
    String className,
    String entityClassName,
    String name,
    FormalParameterElement parameter,
    Map<String, Object> declaredSelects,
    Set<String> derivedSelects,
    Set<String> flags,
    Set<String> groups,
    Element element,
  ) {
    final type = parameter.type.getDisplayString();
    final isNullable = type.endsWith('?');
    if (groups.contains(name)) {
      if (type != 'int') {
        _fail(
          '$entityClassName.$name is marked as groups but its type is '
              '$type.',
          element,
          'groups only supports int fields.',
        );
      }
      return FormFieldModel(
        dartName: name,
        dartType: type,
        kind: FormFieldKind.group,
      );
    }
    if (isNullable) {
      if (type != 'String?') {
        _fail(
          '$entityClassName.$name is nullable ($type).',
          element,
          'nullable only supports String? fields.',
        );
      }
      return FormFieldModel(
        dartName: name,
        dartType: type,
        kind: FormFieldKind.nullable,
      );
    }
    final selectFallback = declaredSelects[name];
    if (selectFallback != null) {
      final supported = selectFallback is int
          ? type == 'int'
          : selectFallback is String && type == 'String';
      if (!supported) {
        _fail(
          '$entityClassName.$name is marked as selects but its type is '
              '$type ($selectFallback).',
          element,
          'The selects fallback type must match the field type '
              '(int/String).',
        );
      }
      return FormFieldModel(
        dartName: name,
        dartType: type,
        kind: FormFieldKind.select,
        selectFallback: selectFallback,
      );
    }
    if (derivedSelects.contains(name)) {
      // Set form: the fallback comes from the entity constructor default.
      final fallback = _deriveSelectFallback(
        name,
        parameter,
        entityClassName,
        element,
      );
      final supported = fallback is int
          ? type == 'int'
          : fallback is String && type == 'String';
      if (!supported) {
        _fail(
          '$entityClassName.$name is marked as selects but its type is '
              '$type (constructor default $fallback).',
          element,
          'The selects fallback type must match the field type '
              '(int/String).',
        );
      }
      return FormFieldModel(
        dartName: name,
        dartType: type,
        kind: FormFieldKind.select,
        selectFallback: fallback,
      );
    }
    if (flags.contains(name)) {
      if (type != 'int') {
        _fail(
          '$entityClassName.$name is marked as flags but its type is '
              '$type.',
          element,
          'flags only supports int fields.',
        );
      }
      return FormFieldModel(
        dartName: name,
        dartType: type,
        kind: FormFieldKind.flag,
      );
    }
    if (!_supportedPlainTypes.contains(type)) {
      _fail(
        'The type of $entityClassName.$name ($type) is not supported yet.',
        element,
        'Mark the field as an exception with selects/flags/exclude, or '
            'wait for extended type support.',
      );
    }
    return FormFieldModel(
      dartName: name,
      dartType: type,
      kind: FormFieldKind.plain,
    );
  }

  /// Reads the `selects` exception set, which accepts two shapes:
  /// a Map `{'name': fallback}` (explicit fallback) or a Set `{'name'}`
  /// (fallback derived from the entity constructor default).
  (Map<String, Object>, Set<String>) _readSelects(
    ConstantReader annotation,
    Element element,
  ) {
    final reader = annotation.read('selects');
    if (reader.isNull) return (const {}, const {});
    if (reader.isMap) {
      final map = reader.mapValue;
      return (
        {
          for (final entry in map.entries)
            entry.key!.toStringValue()!: _readSelectValue(entry.value!),
        },
        const {},
      );
    }
    if (reader.isSet) {
      return (
        const {},
        {for (final value in reader.setValue) value.toStringValue()!},
      );
    }
    _fail(
      'selects must be a Map (explicit fallback) or a Set (derived '
          'fallback).',
      element,
      "Write selects as Map({'fieldName': fallback}) or "
          "Set({'fieldName'}).",
    );
  }

  /// Derives the select fallback from the entity constructor's constant
  /// default for the same field (`this.type = 0` → `0`).
  Object _deriveSelectFallback(
    String name,
    FormalParameterElement parameter,
    String entityClassName,
    Element element,
  ) {
    if (!parameter.hasDefaultValue) {
      _fail(
        '$entityClassName.$name is marked as selects but its constructor '
            'parameter has no default value.',
        element,
        'Add a constant default value to this.$name, or declare the '
            'fallback explicitly in Map form: selects: {\'$name\': ...}.',
      );
    }
    final value = parameter.computeConstantValue();
    if (value == null || !value.hasKnownValue || value.isNull) {
      _fail(
        "$entityClassName.$name's constructor default is not an evaluable "
            'constant.',
        element,
        'Declare the fallback explicitly in Map form instead: '
            'selects: {\'$name\': ...}.',
      );
    }
    final intValue = value.toIntValue();
    if (intValue != null) return intValue;
    final stringValue = value.toStringValue();
    if (stringValue != null) return stringValue;
    _fail(
      "$entityClassName.$name's constructor default type is not int/String.",
      element,
      'Declare the fallback explicitly in Map form instead: '
          'selects: {\'$name\': ...}.',
    );
  }

  Object _readSelectValue(DartObject value) {
    final intValue = value.toIntValue();
    if (intValue != null) return intValue;
    final stringValue = value.toStringValue();
    if (stringValue != null) return stringValue;
    throw InvalidGenerationSourceError(
      'selects only supports int or String fallback',
    );
  }

  Set<String> _readStringSet(ConstantReader annotation, String name) {
    final reader = annotation.read(name);
    if (reader.isNull) return const {};
    return {for (final value in reader.setValue) value.toStringValue()!};
  }

  void _validateDistinctExceptions(
    String className,
    String entityClassName,
    Set<String> selects,
    Set<String> flags,
    Set<String> groups,
    Set<String> exclude,
    Element element,
  ) {
    final conflicts = <String, Set<String>>{
      'selects': selects,
      'flags': flags,
      'groups': groups,
      'exclude': exclude,
    };
    for (final entry in conflicts.entries) {
      for (final other in conflicts.entries) {
        if (entry.key == other.key) continue;
        final overlap = entry.value.intersection(other.value);
        if (overlap.isNotEmpty) {
          _fail(
            "$entityClassName's fields ${overlap.join(', ')} appear in "
                'both ${entry.key} and ${other.key}.',
            element,
            'A field can belong to only one exception set.',
          );
        }
      }
    }
  }
}
