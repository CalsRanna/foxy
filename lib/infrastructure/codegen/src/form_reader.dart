// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'form_model.dart';
import 'naming.dart';

const _fullEntityChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullEntity',
);
const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullField',
);

/// 默认推断支持的字段类型(非 nullable)。
///
/// `bool` 没有专用 controller,库中一致做法是
/// `SelectFieldController<int>(fallback: 0)` + `collect() == 1` 转换,
/// 见 pickpocketing_loot_template_collection_editor_view_model.dart。
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

    final entityType = annotation.read('entity').typeValue;
    if (entityType is! InterfaceType) {
      _fail(
        '$className 的 @FoxyDetailViewModel 参数不是 Entity class。',
        element,
        '传入具体的 Full Entity 类型。',
      );
    }
    final entityElement = entityType.element;
    final entityClassName = entityElement.name;
    if (entityClassName == null || !entityClassName.endsWith('Entity')) {
      _fail('$className 绑定的类型必须以 Entity 结尾。', element, '传入具体的 Full Entity 类型。');
    }
    final entityAnnotations = _fullEntityChecker
        .annotationsOf(entityElement)
        .toList();
    if (entityAnnotations.length != 1) {
      _fail(
        '$entityClassName 必须且只能声明一个 @FoxyFullEntity。',
        entityElement,
        '只绑定已迁移的生成型 Full Entity。',
      );
    }

    final constructor = entityElement.unnamedConstructor;
    if (constructor == null || !constructor.isGenerative) {
      _fail(
        '$entityClassName 必须声明未命名 generative constructor。',
        entityElement,
        '添加 const $entityClassName({...}) 构造函数。',
      );
    }

    final selects = _readSelects(annotation);
    final flags = _readStringSet(annotation, 'flags');
    final groups = _readStringSet(annotation, 'groups');
    final nullable = _readStringSet(annotation, 'nullable');
    final exclude = _readStringSet(annotation, 'exclude');
    _validateDistinctExceptions(
      className,
      entityClassName,
      selects.keys.toSet(),
      flags,
      groups,
      nullable,
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
      ...selects.keys,
      ...flags,
      ...groups,
      ...nullable,
      ...exclude,
    }) {
      if (!constructorFieldNames.contains(name)) {
        _fail(
          '$entityClassName 没有名为 $name 的字段。',
          element,
          '修正 @FoxyDetailViewModel 里拼写错误的字段名。',
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
          selects,
          flags,
          groups,
          nullable,
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
    if (repositoryReader != null && !repositoryReader.isNull) {
      final repositoryType = repositoryReader.typeValue;
      if (repositoryType is! InterfaceType) {
        _fail(
          '$className 的 @FoxyDetailViewModel repository 参数不是 Repository class。',
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
    );
  }

  /// 从 entity 的 `@FoxyFullField(key: true)` 推断 Key:
  /// 单 key 返回 (字段类型, 字段名),复合 key 返回 (`XxxKey`, null)。
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
    Map<String, Object> selects,
    Set<String> flags,
    Set<String> groups,
    Set<String> nullable,
    Element element,
  ) {
    final type = parameter.type.getDisplayString();
    final isNullable = type.endsWith('?');
    if (isNullable && !nullable.contains(name)) {
      _fail(
        '$entityClassName.$name 是 nullable($type)，必须显式标注 nullable。',
        element,
        '把该字段加入 @FoxyDetailViewModel 的 nullable 集合。',
      );
    }
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
    if (nullable.contains(name)) {
      if (type != 'String?') {
        _fail(
          '$entityClassName.$name 标注为 nullable 但类型是 $type。',
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
    final selectFallback = selects[name];
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

  Map<String, Object> _readSelects(ConstantReader annotation) {
    final reader = annotation.read('selects');
    if (reader.isNull) return const {};
    final map = reader.mapValue;
    return {
      for (final entry in map.entries)
        entry.key!.toStringValue()!: _readSelectValue(entry.value!),
    };
  }

  Object _readSelectValue(DartObject value) {
    final intValue = value.toIntValue();
    if (intValue != null) return intValue;
    final stringValue = value.toStringValue();
    if (stringValue != null) return stringValue;
    throw StateError('selects 只支持 int 或 String fallback');
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
    Set<String> nullable,
    Set<String> exclude,
    Element element,
  ) {
    final conflicts = <String, Set<String>>{
      'selects': selects,
      'flags': flags,
      'groups': groups,
      'nullable': nullable,
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
