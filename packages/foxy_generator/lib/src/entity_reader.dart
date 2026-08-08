// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_generator/src/convention.dart';
import 'package:foxy_generator/src/entity_model.dart';
import 'package:foxy_generator/src/entity_validator.dart';
import 'package:foxy_generator/src/naming.dart';
import 'package:foxy_generator/src/source_shape.dart';

const _briefEntityChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyBriefEntity',
);
const _briefFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyBriefField',
);
const _fullEntityChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullEntity',
);
const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullField',
);

final class EntityReader {
  final EntityValidator validator;
  final SourceShape sourceShape;

  const EntityReader({
    this.validator = const EntityValidator(),
    this.sourceShape = const SourceShape(),
  });

  Future<EntityGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyFullEntity can only annotate a class.',
        element,
        'Move the annotation to a Full Entity class.',
      );
    }
    final classElement = element;
    _validateUniqueFullEntity(classElement);

    final className = classElement.name;
    if (className == null) {
      _fail(
        'The Full Entity class must have a name.',
        classElement,
        'Name the class.',
      );
    }
    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${toSnakeCase(className)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$className must be located in $expectedFileName; the current file '
            'is $inputFileName.',
        classElement,
        'Rename the input file to match the Full Entity class.',
      );
    }

    final mixinName = '_${className}Mixin';
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    _validateSourceShape(
      classElement,
      await sourceShape.parseInput(buildStep, classElement),
      className,
      mixinName,
      partName,
    );

    _validateNoGeneratedMemberConflicts(classElement);
    final constructor = classElement.unnamedConstructor;
    if (constructor == null || !constructor.isGenerative) {
      _fail(
        '$className must declare an unnamed generative constructor.',
        classElement,
        'Add a const $className({...}) constructor.',
      );
    }

    final parameters = {
      for (final parameter in constructor.formalParameters)
        parameter.name: parameter,
    };
    final fields = <EntityFieldModel>[];
    for (final field in classElement.fields.where(
      (field) => !field.isStatic && !field.isSynthetic,
    )) {
      fields.add(_readField(classElement, field, parameters));
    }

    // Physical table name: explicit `table:` wins; otherwise derived from
    // the class name (`CreatureLootTemplateEntity` → `creature_loot_template`).
    final table =
        annotation.peek('table')?.stringValue ?? tableNameOf(className);
    if (table.isEmpty) {
      _fail(
        '$className declares no @FoxyFullEntity(table:) and the table name '
            'cannot be derived from the class name (a class named exactly '
            '"Entity").',
        classElement,
        'Pass table: \'physical_table_name\' explicitly to @FoxyFullEntity.',
      );
    }

    final model = EntityGenerationModel(
      className: className,
      generateBrief: _hasSingleAnnotation(
        classElement,
        _briefEntityChecker,
        'FoxyBriefEntity',
      ),
      inputFileName: inputFileName,
      mixinName: mixinName,
      table: table,
      fields: List.unmodifiable(fields),
      briefProjectionFields: List.unmodifiable(
        _readBriefProjectionFields(classElement),
      ),
    );
    validator.validate(model, classElement);
    return model;
  }

  Object? _convertConstant(DartObject value, String type) => switch (type) {
    'int' => value.toIntValue(),
    'double' => value.toDoubleValue() ?? value.toIntValue()?.toDouble(),
    'String' => value.toStringValue(),
    'bool' => value.toBoolValue(),
    _ => null,
  };

  Never _fail(String message, Element element, String todo) {
    throw InvalidGenerationSourceError(message, element: element, todo: todo);
  }

  bool _hasSingleAnnotation(
    Element element,
    TypeChecker checker,
    String annotationName,
  ) {
    final annotations = checker.annotationsOf(element).toList();
    if (annotations.length > 1) {
      _fail(
        '${element.displayName} uses @$annotationName more than once.',
        element,
        'Keep only one @$annotationName.',
      );
    }
    return annotations.isNotEmpty;
  }

  String _quote(String value) => "'$value'";

  List<EntityFieldModel> _readBriefProjectionFields(ClassElement classElement) {
    final result = <EntityFieldModel>[];
    for (final value in _briefFieldChecker.annotationsOf(classElement)) {
      final annotation = ConstantReader(value);
      final nameReader = annotation.read('name');
      final typeReader = annotation.read('type');
      if (nameReader.isNull || typeReader.isNull) {
        _fail(
          '@FoxyBriefField on ${classElement.name} must use the '
              'text/integer/decimal/boolean named constructors.',
          classElement,
          'The parameterless @FoxyBriefField() can only annotate Full '
              'Entity fields.',
        );
      }

      final name = nameReader.stringValue;
      final typeIndex = typeReader.objectValue.getField('index')?.toIntValue();
      if (typeIndex == null ||
          typeIndex < 0 ||
          typeIndex >= FoxyBriefFieldType.values.length) {
        _fail(
          'The type of Brief projection field $name on ${classElement.name} '
              'is unrecognized.',
          classElement,
          'Use a FoxyBriefField named constructor.',
        );
      }
      final type = FoxyBriefFieldType.values[typeIndex];
      final dartType = switch (type) {
        FoxyBriefFieldType.boolean => 'bool',
        FoxyBriefFieldType.decimal => 'double',
        FoxyBriefFieldType.integer => 'int',
        FoxyBriefFieldType.text => 'String',
      };
      final defaultObject = annotation.read('defaultValue').objectValue;
      final defaultValue = _convertConstant(defaultObject, dartType);
      if (defaultValue == null) {
        _fail(
          'The default value type of Brief projection field $name on '
              '${classElement.name} does not match.',
          classElement,
          'Pass a defaultValue of the correct type via the corresponding '
              'named constructor.',
        );
      }

      result.add(
        EntityFieldModel(
          dartName: name,
          dartType: dartType,
          columnName: name,
          constructorDefaultValue: defaultValue,
          includeInBrief: true,
          nullable: false,
          key: false,
        ),
      );
    }
    return result;
  }

  Object? _readConstructorDefault(
    ClassElement classElement,
    FieldElement field,
    FormalParameterElement parameter,
    String type,
    bool nullable,
  ) {
    if (!parameter.hasDefaultValue) {
      if (nullable) return null;
      _fail(
        'The non-nullable constructor parameter of '
            '${classElement.name}.${field.name} must provide an explicit '
            'constant default value.',
        parameter,
        'Add a default value compatible with $type to this.${field.name}.',
      );
    }
    final value = parameter.computeConstantValue();
    if (value == null || !value.hasKnownValue) {
      _fail(
        'The default value of ${classElement.name}.${field.name} must be '
            'an evaluable compile-time constant.',
        parameter,
        'Use an int, double, String, bool, or null constant.',
      );
    }
    if (value.isNull) {
      if (nullable) return null;
      _fail(
        '${classElement.name}.${field.name} is non-nullable, so its default '
            'value cannot be null.',
        parameter,
        'Provide a non-null default value compatible with $type.',
      );
    }
    final converted = _convertConstant(value, type);
    if (converted == null) {
      _fail(
        'The constructor parameter default value type of '
            '${classElement.name}.${field.name} does not match: the field '
            'type is ${field.type.getDisplayString()}.',
        parameter,
        'Provide a constant default value compatible with the field type.',
      );
    }
    return converted;
  }

  EntityFieldModel _readField(
    ClassElement classElement,
    FieldElement field,
    Map<String?, FormalParameterElement> parameters,
  ) {
    final fieldName = field.name;
    if (fieldName == null) {
      _fail(
        '${classElement.name} contains an unnamed instance field.',
        field,
        'Name the field.',
      );
    }
    if (!field.isFinal) {
      _fail(
        '${classElement.name}.$fieldName must be final.',
        field,
        'Declare the instance field as final.',
      );
    }
    if (field.constantInitializer != null) {
      _fail(
        '${classElement.name}.$fieldName cannot use a field initializer.',
        field,
        'Move the default value to the this.$fieldName constructor '
            'parameter.',
      );
    }

    final fullAnnotations = _fullFieldChecker.annotationsOf(field).toList();
    if (fullAnnotations.length != 1) {
      _fail(
        fullAnnotations.isEmpty
            ? '${classElement.name}.$fieldName is missing @FoxyFullField.'
            : '${classElement.name}.$fieldName uses @FoxyFullField more '
                'than once.',
        field,
        fullAnnotations.isEmpty
            ? 'Add a single field annotation.'
            : 'Keep only one field annotation.',
      );
    }
    final full = ConstantReader(fullAnnotations.single);
    final typeName = field.type.getDisplayString();
    final nullable = typeName.endsWith('?');
    final nonNullableType = nullable
        ? typeName.substring(0, typeName.length - 1)
        : typeName;
    if (!const {'int', 'double', 'String', 'bool'}.contains(nonNullableType)) {
      _fail(
        'The type $typeName of ${classElement.name}.$fieldName is not yet '
            'supported.',
        field,
        'Phase 1 supports only int, double, String, bool and their nullable '
            'forms.',
      );
    }

    final parameter = parameters[fieldName];
    if (parameter == null) {
      _fail(
        '${classElement.name}.$fieldName is missing a named constructor '
            'parameter with the same name.',
        field,
        'Add this.$fieldName to the unnamed constructor.',
      );
    }
    if (!parameter.isNamed || !parameter.isInitializingFormal) {
      _fail(
        'The constructor parameter of ${classElement.name}.$fieldName must '
            'be a named initializing formal: this.$fieldName.',
        parameter,
        'Use {this.$fieldName = ...} instead.',
      );
    }
    if (parameter.isRequiredNamed) {
      _fail(
        'Required constructor parameters are not yet supported for '
            '${classElement.name}.$fieldName.',
        parameter,
        'Keep this Entity handwritten for now in Phase 1, or make it an '
            'optional parameter with a constant default value.',
      );
    }
    if (parameter.type.getDisplayString() != typeName) {
      _fail(
        'The constructor parameter type of ${classElement.name}.$fieldName '
            'does not match the field type.',
        parameter,
        'Use $typeName for both this.$fieldName and the field.',
      );
    }

    final defaultValue = _readConstructorDefault(
      classElement,
      field,
      parameter,
      nonNullableType,
      nullable,
    );
    final includeInBrief = _readPhysicalBriefField(field);

    return EntityFieldModel(
      dartName: fieldName,
      dartType: typeName,
      columnName: full.read('name').stringValue,
      constructorDefaultValue: defaultValue,
      includeInBrief: includeInBrief,
      nullable: nullable,
      key: full.peek('key')?.boolValue ?? false,
    );
  }

  bool _readPhysicalBriefField(FieldElement field) {
    final annotations = _briefFieldChecker.annotationsOf(field).toList();
    if (annotations.length > 1) {
      _fail(
        '${field.enclosingElement.name}.${field.name} uses @FoxyBriefField '
            'more than once.',
        field,
        'Keep only one @FoxyBriefField.',
      );
    }
    if (annotations.isEmpty) return false;

    final annotation = ConstantReader(annotations.single);
    if (!annotation.read('name').isNull ||
        !annotation.read('type').isNull ||
        !annotation.read('defaultValue').isNull) {
      _fail(
        'Only the parameterless @FoxyBriefField() can be used on '
            '${field.enclosingElement.name}.${field.name}.',
        field,
        'Use the named constructors on the class for Brief projection '
            'fields.',
      );
    }
    return true;
  }

  void _validateNoGeneratedMemberConflicts(ClassElement element) {
    const generatedMethods = {'copyWith', 'toJson', 'toString', '=='};
    for (final method in element.methods) {
      if (generatedMethods.contains(method.name)) {
        _fail(
          '${element.name} hand-writes ${method.name}, conflicting with '
              'the generated member.',
          method,
          'Remove the hand-written member; keep Entity-specific business '
              'methods.',
        );
      }
    }
    if (element.getters.any((getter) => getter.name == 'hashCode')) {
      _fail(
        '${element.name} hand-writes hashCode, conflicting with the '
            'generated member.',
        element,
        'Remove the hand-written hashCode.',
      );
    }
    final fromJson = element.constructors.where(
      (constructor) => constructor.name == 'fromJson',
    );
    if (fromJson.length != 1 || !fromJson.single.isFactory) {
      _fail(
        '${element.name} must declare a single fromJson factory.',
        element,
        'Add a factory delegating with the conventional signature.',
      );
    }
  }

  void _validateSourceShape(
    ClassElement element,
    CompilationUnit unit,
    String className,
    String mixinName,
    String partName,
  ) {
    final cls = sourceShape.classDeclaration(unit, className);
    if (cls == null) {
      _fail(
        '$className is not declared in the current file.',
        element,
        'Declare the class in this file.',
      );
    }
    if (!sourceShape.withClauseTypeNames(cls).contains(mixinName)) {
      _fail(
        '$className must apply the conventional Mixin $mixinName.',
        element,
        'Change the declaration to class $className with $mixinName.',
      );
    }
    if (!sourceShape.hasPartDirective(unit, partName)) {
      _fail(
        '$className is missing the correct part ${_quote(partName)}.',
        element,
        "Add part ${_quote(partName)};",
      );
    }
    final fromJson = sourceShape.constructor(cls, 'fromJson');
    if (fromJson == null ||
        !sourceShape.factoryDelegatesTo(fromJson, mixinName)) {
      _fail(
        '$className must keep the fromJson factory delegating with the '
            'conventional signature.',
        element,
        'Delegate to $mixinName.fromJson(json).',
      );
    }
  }

  void _validateUniqueFullEntity(ClassElement element) {
    final library = element.library;
    final annotated = library.classes
        .where((candidate) => _fullEntityChecker.hasAnnotationOf(candidate))
        .toList(growable: false);
    if (annotated.length != 1) {
      _fail(
        '${library.uri} must declare exactly one @FoxyFullEntity class; '
            'it currently declares ${annotated.length}.',
        element,
        'Split each Full Entity into its own source file.',
      );
    }
    final annotations = _fullEntityChecker.annotationsOf(element).toList();
    if (annotations.length != 1) {
      _fail(
        '${element.name} uses @FoxyFullEntity more than once.',
        element,
        'Keep only one @FoxyFullEntity.',
      );
    }
  }
}
