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
    ClassElement element,
    List<DartObject> annotations,
    BuildStep buildStep,
  ) async {
    final repositoryClassName = element.name;
    if (repositoryClassName == null ||
        !repositoryClassName.endsWith('Repository')) {
      _fail(
        '@FoxyFilter 只能标注以 Repository 结尾的 class。',
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

    final baseName = repositoryClassName.substring(
      0,
      repositoryClassName.length - 'Repository'.length,
    );
    final filterClassName = '${baseName}Filter';
    final names = <String>{};
    final fields = <RepositoryFilterFieldModel>[];
    for (final object in annotations) {
      final field = _readField(object, filterClassName, element);
      if (!names.add(field.name)) {
        _fail(
          '$filterClassName 重复声明字段 ${field.name}。',
          element,
          '确保每个 @FoxyFilter 字段名唯一。',
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
        typeIndex >= FoxyFilterType.values.length) {
      _fail(
        '$filterClassName.$name 的类型无法识别。',
        element,
        '使用 FoxyFilter 的 text/integer/decimal/boolean 具名构造函数。',
      );
    }
    final type = FoxyFilterType.values[typeIndex];
    final defaultValue = _convertDefault(
      reader.read('defaultValue').objectValue,
      type,
    );
    if (defaultValue == null) {
      _fail(
        '$filterClassName.$name 的默认值与 ${type.name} 类型不兼容。',
        element,
        '通过对应的 FoxyFilter 具名构造函数传入正确默认值。',
      );
    }

    return RepositoryFilterFieldModel(
      defaultValue: defaultValue,
      name: name,
      type: type,
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
