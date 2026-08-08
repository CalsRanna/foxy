// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/convention.dart';
import 'package:foxy_generator/src/entity_resolver.dart';
import 'package:foxy_generator/src/form_model.dart';
import 'package:foxy_generator/src/naming.dart';

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
  const FormReader();

  Future<FormGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyDetailViewModel 只能标注 ViewModel class。',
        element,
        '把注解移动到具体 Detail ViewModel class。',
      );
    }
    final className = element.name;
    if (className == null || !className.endsWith('ViewModel')) {
      _fail(
        '@FoxyDetailViewModel 只能标注以 ViewModel 结尾的 class。',
        element,
        '使用具体 Detail ViewModel class。',
      );
    }

    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${toSnakeCase(className)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$className 必须位于 $expectedFileName，当前文件是 $inputFileName。',
        element,
        '让 ViewModel class 与文件名保持一致。',
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
          '$className 的注解 entity 参数不是 Entity class。',
          element,
          '传入具体的 Full Entity 类型。',
        );
      }
      entityClassName = entityType.element.name!;
      if (!entityClassName.endsWith('Entity')) {
        _fail('$className 绑定的类型必须以 Entity 结尾。', element, '传入具体的 Full Entity 类型。');
      }
    } else {
      entityClassName = entityClassNameOfViewModel(className) ??
          (throw InvalidGenerationSourceError(
            '$className 无法推导 entity 类名：类名不包含约定的'
                ' ListViewModel/DetailViewModel/LinkedListViewModel/'
                'LinkedDetailViewModel 后缀。',
            element: element,
          ));
    }
    final resolved = await resolveFullEntity(
      buildStep,
      element,
      entityClassName,
      '$className 的注解',
    );
    final entityElement = resolved.entityElement;
    final table = resolved.table;

    final constructor = entityElement.unnamedConstructor;
    if (constructor == null || !constructor.isGenerative) {
      _fail(
        '$entityClassName 必须声明未命名 generative constructor。',
        entityElement,
        '添加 const $entityClassName({...}) 构造函数。',
      );
    }

    // `selects` accepts two shapes: a Map (explicit fallback, e.g.
    // {'type': 0}) or a Set (fallback derived from the entity constructor
    // default for the same field, e.g. {'type'}).
    final (declaredSelects, derivedSelects) = _readSelects(annotation);
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
          '$entityClassName 没有名为 $name 的字段。',
          element,
          '修正注解里拼写错误的字段名。',
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
    final source = await buildStep.readAsString(buildStep.inputId);
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    if (!source.contains("part '$partName';") &&
        !source.contains('part "$partName";')) {
      _fail(
        '$className 缺少 part \'$partName\';。',
        element,
        '在 ViewModel imports 后声明生成 part。',
      );
    }
    if (!RegExp(
      'class\\s+$className\\s+with\\s+[^\\{;]*\\b$mixinName\\b',
    ).hasMatch(source)) {
      _fail(
        '$className 必须混入 $mixinName。',
        element,
        '把 $mixinName 添加到 ViewModel 的 with 列表末尾。',
      );
    }
    final withList = RegExp(
      'class\\s+$className\\s+with\\s+([^\\{;]*)',
    ).firstMatch(source)?.group(1);
    if (withList != null) {
      final parts = withList.split(',').map((part) => part.trim()).toList();
      final controllerIndex = parts.indexOf('FieldControllerMixin');
      final mixinIndex = parts.indexOf(mixinName);
      if (controllerIndex < 0) {
        _fail(
          '$className 必须混入 FieldControllerMixin。',
          element,
          '把 FieldControllerMixin 添加到 with 列表。',
        );
      }
      if (controllerIndex > mixinIndex) {
        _fail(
          'FieldControllerMixin 必须在 $mixinName 之前。',
          element,
          '调整 with 顺序：FieldControllerMixin, ..., $mixinName。',
        );
      }
    }

    String repositoryClassName = '';
    String keyType = '';
    String? singleKeyFieldName;
    final repositoryReader = annotation.peek('repository');
    final skeletonDisabled = annotation.peek('skeleton')?.boolValue == false;
    if (repositoryReader != null && !repositoryReader.isNull) {
      if (skeletonDisabled) {
        _fail(
          '$className 不能同时声明 repository 与 skeleton: false。',
          element,
          '只保留 repository:（生成行为骨架），'
              '或只保留 skeleton: false（无骨架，不传 repository）。',
        );
      }
      final repositoryType = repositoryReader.typeValue;
      if (repositoryType is! InterfaceType) {
        _fail(
          '$className 的注解 repository 参数不是 Repository class。',
          element,
          '传入具体的 Repository 类型。',
        );
      }
      repositoryClassName = repositoryType.element.name!;
      if (!repositoryClassName.endsWith('Repository')) {
        _fail(
          '$className 绑定的 Repository 必须以 Repository 结尾。',
          element,
          '传入具体的 Repository 类型。',
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
        final present = await buildStep.canRead(assetId) &&
            (await buildStep.readAsString(assetId)).contains('@FoxyRepository');
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
        '${entityElement.name} 没有可用于详情加载的物理 Key。',
        element,
        '在至少一个 @FoxyFullField 上设置 key: true。',
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
      '$message\n修复方式：$correction',
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
          '$entityClassName.$name 标注为 groups 但类型是 $type。',
          element,
          'groups 只支持 int 字段。',
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
          '$entityClassName.$name 是 nullable($type)。',
          element,
          'nullable 只支持 String? 字段。',
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
          '$entityClassName.$name 标注为 selects 但类型是 $type'
              '($selectFallback)。',
          element,
          'selects 的 fallback 类型必须与字段类型一致(int/String)。',
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
          '$entityClassName.$name 标注为 selects 但类型是 $type'
              '(构造默认值 $fallback)。',
          element,
          'selects 的 fallback 类型必须与字段类型一致(int/String)。',
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
          '$entityClassName.$name 标注为 flags 但类型是 $type。',
          element,
          'flags 只支持 int 字段。',
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
        '$entityClassName.$name 的类型 $type 暂不支持。',
        element,
        '用 selects/flags/exclude 标注例外，或等待类型支持扩展。',
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
  (Map<String, Object>, Set<String>) _readSelects(ConstantReader annotation) {
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
    throw InvalidGenerationSourceError(
      'selects 必须是 Map（显式 fallback）或 Set（推导 fallback）。',
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
        '$entityClassName.$name 标注为 selects 但构造参数没有默认值。',
        element,
        '给 this.$name 添加常量默认值，'
            '或用 Map 形态显式声明 fallback：selects: {\'$name\': ...}。',
      );
    }
    final value = parameter.computeConstantValue();
    if (value == null || !value.hasKnownValue || value.isNull) {
      _fail(
        '$entityClassName.$name 的构造默认值不是可求值的常量。',
        element,
        '改用 Map 形态显式声明 fallback：selects: {\'$name\': ...}。',
      );
    }
    final intValue = value.toIntValue();
    if (intValue != null) return intValue;
    final stringValue = value.toStringValue();
    if (stringValue != null) return stringValue;
    _fail(
      '$entityClassName.$name 的构造默认值类型不是 int/String。',
      element,
      '改用 Map 形态显式声明 fallback：selects: {\'$name\': ...}。',
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
            '$entityClassName 的字段 ${overlap.join(', ')} 同时出现在 '
                '${entry.key} 和 ${other.key}。',
            element,
            '一个字段只能属于一个例外集合。',
          );
        }
      }
    }
  }
}
