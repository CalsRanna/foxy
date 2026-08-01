import 'dart_literal.dart';
import 'form_model.dart';

final class FormEmitter {
  const FormEmitter();

  /// controller 标识:`class_` → `class`(保留字转义),其余原样。
  String controllerName(FormFieldModel field) {
    final name = field.dartName;
    return name.endsWith('_') ? name.substring(0, name.length - 1) : name;
  }

  /// 成员顺序遵循 "Sort Members" 规则:字段(controller,保持原序)
  /// 在前,私有方法按名(_afterApplyCandidate → _applyCandidate
  /// → _collectCandidate)。
  String emit(FormGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on FieldControllerMixin {');
    for (final field in model.fields) {
      buffer.writeln(_controllerDeclaration(field));
    }
    buffer.writeln();
    _emitAfterApply(buffer, model);
    buffer.writeln();
    _emitApply(buffer, model);
    buffer.writeln();
    _emitCollect(buffer, model);
    buffer.writeln('}');
    return buffer.toString();
  }

  /// 与手写风格对齐:`SelectFieldController` 一族用换行形式,
  /// 其余单行。
  String _controllerDeclaration(FormFieldModel field) {
    final controller = controllerName(field);
    final expression = switch ((field.kind, field.dartType)) {
      (FormFieldKind.select, _) => _selectExpression(field),
      (FormFieldKind.flag, _) => 'FlagFieldController()',
      (FormFieldKind.group, _) => 'IntFieldControllerGroup()',
      (FormFieldKind.nullable, _) => 'NullableStringFieldController()',
      (FormFieldKind.plain, 'int') => 'IntFieldController()',
      (FormFieldKind.plain, 'double') => 'DoubleFieldController()',
      (FormFieldKind.plain, 'String') => 'StringFieldController()',
      (FormFieldKind.plain, 'bool') => 'SelectFieldController<int>(fallback: 0)',
      _ => throw StateError(
          'Unsupported field ${field.dartName}: ${field.dartType}',
        ),
    };
    if (expression.startsWith('SelectFieldController')) {
      return '  late final ${controller}Controller = registerController(\n'
          '    $expression,\n'
          '  );';
    }
    return '  late final ${controller}Controller = '
        'registerController($expression);';
  }

  void _emitAfterApply(StringBuffer buffer, FormGenerationModel model) {
    final parameter = _entityParameterName(model.entityClassName);
    buffer.writeln(
      '  void _afterApplyCandidate(${model.entityClassName} $parameter) {}',
    );
  }

  void _emitApply(StringBuffer buffer, FormGenerationModel model) {
    final parameter = _entityParameterName(model.entityClassName);
    buffer.writeln(
      '  void _applyCandidate(${model.entityClassName} $parameter) {',
    );
    for (final field in model.fields) {
      final controller = controllerName(field);
      final init = field.kind == FormFieldKind.plain && field.dartType == 'bool'
          ? '${controller}Controller.init($parameter.${field.dartName} ? 1 : 0)'
          : '${controller}Controller.init($parameter.${field.dartName})';
      buffer.writeln('    $init;');
    }
    // 加载实体后的语义钩子(如联动刷新编辑规格),手写侧覆写。
    buffer
      ..writeln('    _afterApplyCandidate($parameter);')
      ..writeln('  }');
  }

  void _emitCollect(StringBuffer buffer, FormGenerationModel model) {
    buffer
      ..writeln(
        '  ${model.entityClassName} _collectCandidate() {',
      )
      ..writeln('    return ${model.entityClassName}(');
    for (final field in model.fields) {
      final controller = controllerName(field);
      final collect = field.kind == FormFieldKind.plain && field.dartType == 'bool'
          ? '${controller}Controller.collect() == 1'
          : '${controller}Controller.collect()';
      buffer.writeln('      ${field.dartName}: $collect,');
    }
    buffer
      ..writeln('    );')
      ..writeln('  }');
  }

  /// `TalentEntity` → `talent`(与 Repository 的实体参数命名一致)。
  String _entityParameterName(String entityClassName) {
    final baseName = entityClassName.substring(
      0,
      entityClassName.length - 'Entity'.length,
    );
    return '${baseName[0].toLowerCase()}${baseName.substring(1)}';
  }

  /// `SelectFieldController` 表达式:fallback 类型决定泛型与字面量。
  String _selectExpression(FormFieldModel field) {
    final fallback = field.selectFallback;
    if (fallback is String) {
      return 'SelectFieldController<String>'
          '(fallback: ${dartStringLiteral(fallback)})';
    }
    return 'SelectFieldController<int>(fallback: $fallback)';
  }
}
