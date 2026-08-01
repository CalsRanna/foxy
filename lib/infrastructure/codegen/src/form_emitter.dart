import 'form_model.dart';

final class FormEmitter {
  const FormEmitter();

  String emit(FormGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on FieldControllerMixin {');
    for (final field in model.fields) {
      buffer.writeln(_controllerDeclaration(field));
    }
    buffer.writeln();
    _emitCollect(buffer, model);
    buffer.writeln();
    _emitApply(buffer, model);
    buffer.writeln('}');
    return buffer.toString();
  }

  /// 与手写风格对齐:`SelectFieldController` 一族用换行形式,
  /// 其余单行。
  String _controllerDeclaration(FormFieldModel field) {
    final expression = switch ((field.kind, field.dartType)) {
      (FormFieldKind.select, _) => 'SelectFieldController<int>'
          '(fallback: ${field.selectFallback})',
      (FormFieldKind.flag, _) => 'FlagFieldController()',
      (FormFieldKind.plain, 'int') => 'IntFieldController()',
      (FormFieldKind.plain, 'double') => 'DoubleFieldController()',
      (FormFieldKind.plain, 'String') => 'StringFieldController()',
      (FormFieldKind.plain, 'bool') => 'SelectFieldController<int>(fallback: 0)',
      _ => throw StateError(
          'Unsupported field ${field.dartName}: ${field.dartType}',
        ),
    };
    if (expression.startsWith('SelectFieldController')) {
      return '  late final ${field.dartName}Controller = registerController(\n'
          '    $expression,\n'
          '  );';
    }
    return '  late final ${field.dartName}Controller = '
        'registerController($expression);';
  }

  void _emitCollect(StringBuffer buffer, FormGenerationModel model) {
    buffer
      ..writeln(
        '  ${model.entityClassName} _collectCandidate() {',
      )
      ..writeln('    return ${model.entityClassName}(');
    for (final field in model.fields) {
      final collect = field.kind == FormFieldKind.plain && field.dartType == 'bool'
          ? '${field.dartName}Controller.collect() == 1'
          : '${field.dartName}Controller.collect()';
      buffer.writeln('      ${field.dartName}: $collect,');
    }
    buffer
      ..writeln('    );')
      ..writeln('  }');
  }

  void _emitApply(StringBuffer buffer, FormGenerationModel model) {
    final parameter = _entityParameterName(model.entityClassName);
    buffer.writeln(
      '  void _applyCandidate(${model.entityClassName} $parameter) {',
    );
    for (final field in model.fields) {
      final init = field.kind == FormFieldKind.plain && field.dartType == 'bool'
          ? '${field.dartName}Controller.init($parameter.${field.dartName} ? 1 : 0)'
          : '${field.dartName}Controller.init($parameter.${field.dartName})';
      buffer.writeln('    $init;');
    }
    buffer.writeln('  }');
  }

  /// `TalentEntity` → `talent`(与 Repository 的实体参数命名一致)。
  String _entityParameterName(String entityClassName) {
    final baseName = entityClassName.substring(
      0,
      entityClassName.length - 'Entity'.length,
    );
    return '${baseName[0].toLowerCase()}${baseName.substring(1)}';
  }
}
