// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'repository_model.dart';

const _fullEntityChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullEntity',
);
const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullField',
);

final class RepositoryReader {
  const RepositoryReader();

  Future<RepositoryGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyRepository 只能标注 Repository class。',
        element,
        '把注解移动到具体 Repository class。',
      );
    }
    final repositoryClassName = element.name;
    if (repositoryClassName == null ||
        !repositoryClassName.endsWith('Repository')) {
      _fail(
        '@FoxyRepository 只能标注以 Repository 结尾的 class。',
        element,
        '使用具体 Repository class。',
      );
    }

    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${_toSnakeCase(repositoryClassName)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$repositoryClassName 必须位于 $expectedFileName，'
            '当前文件是 $inputFileName。',
        element,
        '让 Repository class 与文件名保持一致。',
      );
    }

    final entityType = annotation.read('entity').typeValue;
    if (entityType is! InterfaceType) {
      _fail(
        '$repositoryClassName 的 @FoxyRepository 参数不是 Entity class。',
        element,
        '传入具体的 Full Entity 类型。',
      );
    }
    final entityElement = entityType.element;
    final entityClassName = entityElement.name;
    if (entityClassName == null || !entityClassName.endsWith('Entity')) {
      _fail(
        '$repositoryClassName 绑定的类型必须以 Entity 结尾。',
        element,
        '传入具体的 Full Entity 类型。',
      );
    }
    final expectedRepositoryClassName =
        '${entityClassName.substring(0, entityClassName.length - 'Entity'.length)}'
        'Repository';
    if (repositoryClassName != expectedRepositoryClassName) {
      _fail(
        '$repositoryClassName 与 $entityClassName 不符合一对一命名约定。',
        element,
        'Repository 和 Entity 使用相同 base name。',
      );
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
    final table = ConstantReader(
      entityAnnotations.single,
    ).read('table').stringValue;

    final keyFields = <RepositoryKeyFieldModel>[];
    for (final field in entityElement.fields.where(
      (field) => !field.isStatic && !field.isSynthetic,
    )) {
      final annotations = _fullFieldChecker.annotationsOf(field).toList();
      if (annotations.length != 1) continue;
      final fieldAnnotation = ConstantReader(annotations.single);
      if (!(fieldAnnotation.peek('key')?.boolValue ?? false)) continue;
      keyFields.add(
        RepositoryKeyFieldModel(
          columnName: fieldAnnotation.read('name').stringValue,
          dartName: field.name!,
          dartType: field.type.getDisplayString(),
        ),
      );
    }
    if (keyFields.isEmpty) {
      _fail(
        '$entityClassName 没有可用于 Repository 的物理 Key。',
        entityElement,
        '在至少一个 @FoxyFullField 上设置 key: true。',
      );
    }

    final methods = element.methods;
    final hasGet = methods.any(
      (method) =>
          method.name?.startsWith('get') == true &&
          _returns(method, 'Future<$entityClassName?>') &&
          method.formalParameters.length == 1,
    );
    final storeMethod = methods
        .where(
          (method) =>
              method.name?.startsWith('store') == true &&
              _returns(method, 'Future<void>') &&
              _accepts(method, [entityClassName]),
        )
        .firstOrNull;
    final hasStore = storeMethod != null;
    final hasUpdate = methods.any(
      (method) =>
          method.name?.startsWith('update') == true &&
          _returns(method, 'Future<void>') &&
          method.formalParameters.length == 2 &&
          method.formalParameters.last.type.getDisplayString() ==
              entityClassName,
    );
    final hasDestroy = methods.any(
      (method) =>
          method.name?.startsWith('destroy') == true &&
          _returns(method, 'Future<void>') &&
          method.formalParameters.length == 1,
    );
    final baseName = entityClassName.substring(
      0,
      entityClassName.length - 'Entity'.length,
    );
    final entityParameterName =
        storeMethod?.formalParameters.single.name ??
        '${baseName[0].toLowerCase()}${baseName.substring(1)}';

    final source = await buildStep.readAsString(buildStep.inputId);
    final repositoryTable = RegExp(
      r'''static\s+const\s+_table\s*=\s*['"]([^'"]+)['"]\s*;''',
    ).firstMatch(source)?.group(1);
    if (repositoryTable != table) {
      _fail(
        '$repositoryClassName._table 与 $entityClassName 的物理表不一致：'
            '${repositoryTable ?? '未声明'} != $table。',
        element,
        '让 Repository._table 与 @FoxyFullEntity.table 完全一致。',
      );
    }
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    if (!source.contains("part '$partName';") &&
        !source.contains('part "$partName";')) {
      _fail(
        '$repositoryClassName 缺少 part \'$partName\';。',
        element,
        '在 Repository imports 后声明生成 part。',
      );
    }
    final mixinName = '_${repositoryClassName}Mixin';
    if (!RegExp(
      'class\\s+$repositoryClassName\\s+with\\s+[^\\{;]*\\b$mixinName\\b',
    ).hasMatch(source)) {
      _fail(
        '$repositoryClassName 必须混入 $mixinName。',
        element,
        '把 $mixinName 添加到 Repository 的 with 列表末尾。',
      );
    }

    return RepositoryGenerationModel(
      entityClassName: entityClassName,
      entityParameterName: entityParameterName,
      generateDestroy: !hasDestroy,
      generateGet: !hasGet,
      generateStore: !hasStore,
      generateUpdate: !hasUpdate,
      keyFields: List.unmodifiable(keyFields),
      mixinName: mixinName,
      repositoryClassName: repositoryClassName,
      table: table,
    );
  }

  bool _accepts(MethodElement method, List<String> types) {
    final parameters = method.formalParameters;
    if (parameters.length != types.length) return false;
    for (var index = 0; index < types.length; index++) {
      if (parameters[index].type.getDisplayString() != types[index]) {
        return false;
      }
    }
    return true;
  }

  bool _returns(MethodElement method, String type) =>
      method.returnType.getDisplayString() == type;

  String _toSnakeCase(String value) {
    final buffer = StringBuffer();
    for (var index = 0; index < value.length; index++) {
      final codeUnit = value.codeUnitAt(index);
      final isUpper = codeUnit >= 65 && codeUnit <= 90;
      if (isUpper && index > 0) buffer.write('_');
      buffer.writeCharCode(isUpper ? codeUnit + 32 : codeUnit);
    }
    return buffer.toString();
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\n修复方式：$correction',
      element: element,
    );
  }
}
