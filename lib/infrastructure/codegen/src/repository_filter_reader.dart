// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../repository_annotations.dart';
import 'repository_filter_model.dart';

final class RepositoryFilterReader {
  const RepositoryFilterReader();

  Future<RepositoryFilterGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyRepositoryFilter 只能标注 Repository class。',
        element,
        '把注解移动到具体 Repository class。',
      );
    }
    final repositoryClassName = element.name;
    if (repositoryClassName == null ||
        !repositoryClassName.endsWith('Repository')) {
      _fail(
        '@FoxyRepositoryFilter 只能标注以 Repository 结尾的 class。',
        element,
        '使用具体 Repository class 作为 Filter owner。',
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

    final filterClassName = annotation.read('name').stringValue;
    if (!RegExp(r'^[A-Z][A-Za-z0-9]*Filter$').hasMatch(filterClassName)) {
      _fail(
        '$repositoryClassName 的 Filter 名称 $filterClassName 不合法。',
        element,
        '使用以 Filter 结尾且不带 Entity 后缀的 UpperCamelCase 名称。',
      );
    }

    final source = await buildStep.readAsString(buildStep.inputId);
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    if (!source.contains("part '$partName';") &&
        !source.contains('part "$partName";')) {
      _fail(
        '$repositoryClassName 缺少 part \'$partName\';。',
        element,
        '在 Repository imports 后声明生成 part。',
      );
    }

    final fieldObjects = annotation.read('fields').listValue;
    if (fieldObjects.isEmpty) {
      _fail(
        '$filterClassName 必须至少声明一个字段。',
        element,
        '在 FoxyRepositoryFilter.fields 中声明查询字段。',
      );
    }

    final names = <String>{};
    final fields = <RepositoryFilterFieldModel>[];
    for (final object in fieldObjects) {
      final field = _readField(object, filterClassName, element);
      if (!names.add(field.name)) {
        _fail(
          '$filterClassName 重复声明字段 ${field.name}。',
          element,
          '确保 Filter 字段名唯一。',
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

  RepositoryFilterFieldModel _readField(
    DartObject object,
    String filterClassName,
    Element element,
  ) {
    final reader = ConstantReader(object);
    final name = reader.read('name').stringValue;
    if (!RegExp(r'^[a-z][A-Za-z0-9]*_?$').hasMatch(name)) {
      _fail(
        '$filterClassName 的字段名 $name 不是合法 lowerCamelCase 标识符。',
        element,
        '使用 lowerCamelCase；Dart 保留字允许追加单个下划线。',
      );
    }

    final typeIndex = reader
        .read('type')
        .objectValue
        .getField('index')
        ?.toIntValue();
    if (typeIndex == null ||
        typeIndex < 0 ||
        typeIndex >= FoxyFilterFieldType.values.length) {
      _fail(
        '$filterClassName.$name 的类型无法识别。',
        element,
        '使用 FoxyFilterFieldType 中的类型。',
      );
    }
    final type = FoxyFilterFieldType.values[typeIndex];
    final defaultValue = _convertDefault(
      reader.read('defaultValue').objectValue,
      type,
    );
    if (defaultValue == null) {
      _fail(
        '$filterClassName.$name 的默认值与 ${type.name} 类型不兼容。',
        element,
        '提供与 Filter 字段类型匹配的常量默认值。',
      );
    }

    return RepositoryFilterFieldModel(
      defaultValue: defaultValue,
      name: name,
      type: type,
    );
  }

  Object? _convertDefault(DartObject object, FoxyFilterFieldType type) =>
      switch (type) {
        FoxyFilterFieldType.boolean => object.toBoolValue(),
        FoxyFilterFieldType.decimal =>
          object.toDoubleValue() ?? object.toIntValue()?.toDouble(),
        FoxyFilterFieldType.integer => object.toIntValue(),
        FoxyFilterFieldType.text => object.toStringValue(),
      };

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
