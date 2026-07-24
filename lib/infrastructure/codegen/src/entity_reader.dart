// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../entity_annotations.dart';
import 'entity_model.dart';
import 'entity_validator.dart';

const _fullEntityChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullEntity',
);
const _briefEntityChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyBriefEntity',
);
const _filterEntityChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFilterEntity',
);
const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullField',
);
const _briefFieldChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyBriefField',
);
const _filterFieldChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFilterField',
);

final class EntityReader {
  final EntityValidator validator;

  const EntityReader({this.validator = const EntityValidator()});

  Future<EntityGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyFullEntity 只能标注 class。',
        element,
        '把注解移动到 Full Entity class。',
      );
    }
    final classElement = element;
    _validateUniqueFullEntity(classElement);

    final className = classElement.name;
    if (className == null) {
      _fail('Full Entity class 必须有名称。', classElement, '为 class 命名。');
    }
    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${_toSnakeCase(className)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$className 必须位于 $expectedFileName，当前文件是 $inputFileName。',
        classElement,
        '重命名输入文件，使其与 Full Entity class 对应。',
      );
    }

    final source = await buildStep.readAsString(buildStep.inputId);
    final mixinName = '_${className}Mixin';
    _validateSourceShape(
      classElement,
      source,
      className,
      mixinName,
      inputFileName,
    );

    _validateNoGeneratedMemberConflicts(classElement);
    final constructor = classElement.unnamedConstructor;
    if (constructor == null || !constructor.isGenerative) {
      _fail(
        '$className 必须声明未命名 generative constructor。',
        classElement,
        '添加 const $className({...}) 构造函数。',
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

    final model = EntityGenerationModel(
      className: className,
      generateBrief: _hasSingleAnnotation(
        classElement,
        _briefEntityChecker,
        'FoxyBriefEntity',
      ),
      generateFilter: _hasSingleAnnotation(
        classElement,
        _filterEntityChecker,
        'FoxyFilterEntity',
      ),
      inputFileName: inputFileName,
      mixinName: mixinName,
      table: annotation.read('table').stringValue,
      fields: List.unmodifiable(fields),
      briefProjectionFields: List.unmodifiable(
        _readBriefProjectionFields(classElement),
      ),
    );
    validator.validate(model, classElement);
    return model;
  }

  EntityFieldModel _readField(
    ClassElement classElement,
    FieldElement field,
    Map<String?, FormalParameterElement> parameters,
  ) {
    final fieldName = field.name;
    if (fieldName == null) {
      _fail('${classElement.name} 包含无名称实例字段。', field, '为字段命名。');
    }
    if (!field.isFinal) {
      _fail(
        '${classElement.name}.$fieldName 必须是 final。',
        field,
        '把实例字段声明为 final。',
      );
    }
    if (field.constantInitializer != null) {
      _fail(
        '${classElement.name}.$fieldName 不能使用字段初始化器。',
        field,
        '把默认值移动到 this.$fieldName 构造参数。',
      );
    }

    final fullAnnotations = _fullFieldChecker.annotationsOf(field).toList();
    if (fullAnnotations.length != 1) {
      _fail(
        fullAnnotations.isEmpty
            ? '${classElement.name}.$fieldName 缺少 @FoxyFullField。'
            : '${classElement.name}.$fieldName 重复使用 @FoxyFullField。',
        field,
        fullAnnotations.isEmpty ? '添加唯一的字段注解。' : '只保留一个字段注解。',
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
        '${classElement.name}.$fieldName 的类型 $typeName 暂不支持。',
        field,
        '第一阶段只支持 int、double、String、bool 及其 nullable 形式。',
      );
    }

    final parameter = parameters[fieldName];
    if (parameter == null) {
      _fail(
        '${classElement.name}.$fieldName 缺少同名 named 构造参数。',
        field,
        '在未命名构造函数中添加 this.$fieldName。',
      );
    }
    if (!parameter.isNamed || !parameter.isInitializingFormal) {
      _fail(
        '${classElement.name}.$fieldName 的构造参数必须是 named '
            'initializing formal：this.$fieldName。',
        parameter,
        '改用 {this.$fieldName = ...}。',
      );
    }
    if (parameter.isRequiredNamed) {
      _fail(
        '${classElement.name}.$fieldName 的 required 构造参数暂不支持。',
        parameter,
        '第一阶段保留该 Entity 手写，或改成有常量默认值的可选参数。',
      );
    }
    if (parameter.type.getDisplayString() != typeName) {
      _fail(
        '${classElement.name}.$fieldName 的构造参数类型与字段类型不一致。',
        parameter,
        '让 this.$fieldName 与字段都使用 $typeName。',
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
    final filterAnnotations = _filterFieldChecker.annotationsOf(field).toList();
    if (filterAnnotations.length > 1) {
      _fail(
        '${classElement.name}.$fieldName 重复使用 @FoxyFilterField。',
        field,
        '只保留一个 @FoxyFilterField。',
      );
    }

    return EntityFieldModel(
      dartName: fieldName,
      dartType: typeName,
      columnName: full.read('name').stringValue,
      constructorDefaultValue: defaultValue,
      filter: filterAnnotations.isEmpty
          ? null
          : _readFilter(ConstantReader(filterAnnotations.single), field),
      includeInBrief: includeInBrief,
      nullable: nullable,
      key: full.peek('key')?.boolValue ?? false,
    );
  }

  bool _readPhysicalBriefField(FieldElement field) {
    final annotations = _briefFieldChecker.annotationsOf(field).toList();
    if (annotations.length > 1) {
      _fail(
        '${field.enclosingElement.name}.${field.name} 重复使用 @FoxyBriefField。',
        field,
        '只保留一个 @FoxyBriefField。',
      );
    }
    if (annotations.isEmpty) return false;

    final annotation = ConstantReader(annotations.single);
    if (!annotation.read('name').isNull ||
        !annotation.read('type').isNull ||
        !annotation.read('defaultValue').isNull) {
      _fail(
        '${field.enclosingElement.name}.${field.name} 上只能使用'
            '无参数的 @FoxyBriefField()。',
        field,
        'Brief 投影字段请使用 class 上的具名构造函数。',
      );
    }
    return true;
  }

  List<EntityFieldModel> _readBriefProjectionFields(ClassElement classElement) {
    final result = <EntityFieldModel>[];
    for (final value in _briefFieldChecker.annotationsOf(classElement)) {
      final annotation = ConstantReader(value);
      final nameReader = annotation.read('name');
      final typeReader = annotation.read('type');
      if (nameReader.isNull || typeReader.isNull) {
        _fail(
          '${classElement.name} 上的 @FoxyBriefField 必须使用'
              ' text/integer/decimal/boolean 具名构造函数。',
          classElement,
          '无参数的 @FoxyBriefField() 只能标注 Full Entity 字段。',
        );
      }

      final name = nameReader.stringValue;
      final typeIndex = typeReader.objectValue.getField('index')?.toIntValue();
      if (typeIndex == null ||
          typeIndex < 0 ||
          typeIndex >= FoxyBriefFieldType.values.length) {
        _fail(
          '${classElement.name} 的 Brief 投影字段 $name 类型无法识别。',
          classElement,
          '使用 FoxyBriefField 的具名构造函数。',
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
          '${classElement.name} 的 Brief 投影字段 $name 默认值类型不匹配。',
          classElement,
          '通过对应具名构造函数传入正确类型的 defaultValue。',
        );
      }

      result.add(
        EntityFieldModel(
          dartName: name,
          dartType: dartType,
          columnName: name,
          constructorDefaultValue: defaultValue,
          filter: null,
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
        '${classElement.name}.${field.name} 的 non-nullable 构造参数'
            '必须提供显式常量默认值。',
        parameter,
        '为 this.${field.name} 添加与 $type 兼容的默认值。',
      );
    }
    final value = parameter.computeConstantValue();
    if (value == null || !value.hasKnownValue) {
      _fail(
        '${classElement.name}.${field.name} 的默认值必须是可求值的编译期常量。',
        parameter,
        '使用 int、double、String、bool 或 null 常量。',
      );
    }
    if (value.isNull) {
      if (nullable) return null;
      _fail(
        '${classElement.name}.${field.name} 是 non-nullable，默认值不能为 null。',
        parameter,
        '提供与 $type 兼容的非空默认值。',
      );
    }
    final converted = _convertConstant(value, type);
    if (converted == null) {
      _fail(
        '${classElement.name}.${field.name} 的构造参数默认值类型不匹配：'
            '字段类型为 ${field.type.getDisplayString()}。',
        parameter,
        '提供与字段类型兼容的常量默认值。',
      );
    }
    return converted;
  }

  FilterFieldGenerationModel _readFilter(
    ConstantReader annotation,
    FieldElement field,
  ) {
    final typeIndex = annotation
        .read('type')
        .objectValue
        .getField('index')
        ?.toIntValue();
    if (typeIndex == null ||
        typeIndex < 0 ||
        typeIndex >= FoxyFilterFieldType.values.length) {
      _fail(
        '${field.enclosingElement.name}.${field.name} 的 Filter 类型无法识别。',
        field,
        '使用 FoxyFilterFieldType 中的值。',
      );
    }
    final type = FoxyFilterFieldType.values[typeIndex];
    final defaultObject = annotation.read('defaultValue').objectValue;
    final defaultValue = defaultObject.isNull
        ? null
        : _convertConstant(defaultObject, switch (type) {
            FoxyFilterFieldType.boolean => 'bool',
            FoxyFilterFieldType.decimal => 'double',
            FoxyFilterFieldType.integer => 'int',
            FoxyFilterFieldType.text => 'String',
          });
    return FilterFieldGenerationModel(defaultValue: defaultValue, type: type);
  }

  Object? _convertConstant(DartObject value, String type) => switch (type) {
    'int' => value.toIntValue(),
    'double' => value.toDoubleValue() ?? value.toIntValue()?.toDouble(),
    'String' => value.toStringValue(),
    'bool' => value.toBoolValue(),
    _ => null,
  };

  void _validateUniqueFullEntity(ClassElement element) {
    final library = element.library;
    final annotated = library.classes
        .where((candidate) => _fullEntityChecker.hasAnnotationOf(candidate))
        .toList(growable: false);
    if (annotated.length != 1) {
      _fail(
        '${library.uri} 必须且只能声明一个 @FoxyFullEntity class，'
            '当前为 ${annotated.length} 个。',
        element,
        '把每个 Full Entity 拆到独立源文件。',
      );
    }
    final annotations = _fullEntityChecker.annotationsOf(element).toList();
    if (annotations.length != 1) {
      _fail(
        '${element.name} 重复使用 @FoxyFullEntity。',
        element,
        '只保留一个 @FoxyFullEntity。',
      );
    }
  }

  void _validateSourceShape(
    ClassElement element,
    String source,
    String className,
    String mixinName,
    String inputFileName,
  ) {
    final escapedClass = RegExp.escape(className);
    final escapedMixin = RegExp.escape(mixinName);
    if (!RegExp(
      'class\\s+$escapedClass\\s+with\\s+$escapedMixin\\b',
    ).hasMatch(source)) {
      _fail(
        '$className 必须应用约定 Mixin $mixinName。',
        element,
        '把声明改为 class $className with $mixinName。',
      );
    }
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    if (!RegExp(
      "part\\s+['\"]${RegExp.escape(partName)}['\"]\\s*;",
    ).hasMatch(source)) {
      _fail(
        '$className 缺少正确的 part ${_quote(partName)}。',
        element,
        "添加 part ${_quote(partName)};",
      );
    }
    if (!RegExp(
      'factory\\s+$escapedClass\\.fromJson\\s*'
      '\\(\\s*Map<String,\\s*dynamic>\\s+json\\s*,?\\s*\\)\\s*=>\\s*'
      '$escapedMixin\\.fromJson\\(json\\)\\s*;',
      multiLine: true,
    ).hasMatch(source)) {
      _fail(
        '$className 必须保留约定签名的 fromJson factory 委托。',
        element,
        '委托到 $mixinName.fromJson(json)。',
      );
    }
  }

  void _validateNoGeneratedMemberConflicts(ClassElement element) {
    const generatedMethods = {'copyWith', 'toJson', 'toString', '=='};
    for (final method in element.methods) {
      if (generatedMethods.contains(method.name)) {
        _fail(
          '${element.name} 已手写 ${method.name}，与生成成员冲突。',
          method,
          '删除手写成员，保留 Entity 特有业务方法。',
        );
      }
    }
    if (element.getters.any((getter) => getter.name == 'hashCode')) {
      _fail('${element.name} 已手写 hashCode，与生成成员冲突。', element, '删除手写 hashCode。');
    }
    final fromJson = element.constructors.where(
      (constructor) => constructor.name == 'fromJson',
    );
    if (fromJson.length != 1 || !fromJson.single.isFactory) {
      _fail(
        '${element.name} 必须声明唯一的 fromJson factory。',
        element,
        '添加约定签名的 factory 委托。',
      );
    }
  }

  bool _hasSingleAnnotation(
    Element element,
    TypeChecker checker,
    String annotationName,
  ) {
    final annotations = checker.annotationsOf(element).toList();
    if (annotations.length > 1) {
      _fail(
        '${element.displayName} 重复使用 @$annotationName。',
        element,
        '只保留一个 @$annotationName。',
      );
    }
    return annotations.isNotEmpty;
  }

  String _toSnakeCase(String value) => value
      .replaceAllMapped(
        RegExp(r'([a-z0-9])([A-Z])'),
        (match) => '${match[1]}_${match[2]}',
      )
      .toLowerCase();

  String _quote(String value) => "'$value'";

  Never _fail(String message, Element element, String todo) {
    throw InvalidGenerationSourceError(message, element: element, todo: todo);
  }
}
