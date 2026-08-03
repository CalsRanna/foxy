import 'package:source_gen/source_gen.dart';

import 'dart_literal.dart';
import 'form_model.dart';

final class FormEmitter {
  const FormEmitter();

  /// controller 标识:`class_` → `class`(保留字转义),其余原样。
  String controllerName(FormFieldModel field) {
    final name = field.dartName;
    return name.endsWith('_') ? name.substring(0, name.length - 1) : name;
  }

  /// 成员顺序遵循 "Sort Members" 规则:字段(repository → 状态信号 →
  /// controller,保持原序)在前,公开方法按名(dispose → initSignals →
  /// persist),私有方法按名(_afterApplyCandidate → _applyCandidate
  /// → _collectCandidate → _logActivity)。
  String emit(FormGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on FieldControllerMixin {');
    if (model.skeletonEnabled) {
      _emitSkeletonFields(buffer, model);
    }
    for (final field in model.fields) {
      buffer.writeln(_controllerDeclaration(field));
    }
    if (model.skeletonEnabled) {
      buffer.writeln();
      _emitDispose(buffer, model);
      buffer.writeln();
      _emitInitSignals(buffer, model);
      buffer.writeln();
      _emitPersist(buffer, model);
    }
    buffer.writeln();
    _emitAfterApply(buffer, model);
    buffer.writeln();
    _emitApply(buffer, model);
    buffer.writeln();
    _emitCollect(buffer, model);
    if (model.skeletonEnabled) {
      buffer.writeln();
      _emitLogActivity(buffer, model);
    }
    buffer.writeln('}');
    return buffer.toString();
  }

  void _emitSkeletonFields(StringBuffer buffer, FormGenerationModel model) {
    buffer
      ..writeln(
        '  final _repository = GetIt.instance.get<${model.repositoryClassName}>();',
      )
      ..writeln()
      ..writeln('  final entity = signal<${model.entityClassName}?>(null);')
      ..writeln()
      ..writeln('  final persistedKey = signal<${model.keyType}?>(null);')
      ..writeln()
      ..writeln('  final loading = signal(false);')
      ..writeln()
      ..writeln('  final submitting = signal(false);')
      ..writeln()
      ..writeln('  final errorMessage = signal<String?>(null);')
      ..writeln();
  }

  void _emitDispose(StringBuffer buffer, FormGenerationModel model) {
    buffer
      ..writeln('  void dispose() {')
      ..writeln('    disposeControllers();')
      ..writeln('  }');
  }

  void _emitInitSignals(StringBuffer buffer, FormGenerationModel model) {
    buffer
      ..writeln('  Future<void> initSignals({${model.keyType}? key}) async {')
      ..writeln('    loading.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      if (key == null) {')
      ..writeln(
        '        final blank = await _repository.create${model.baseName}();',
      )
      // 慢查询返回时页面可能已销毁(disposeControllers),再写
      // TextEditingController 会在 debug 下抛 FlutterError。
      ..writeln('        if (isDisposed) return;')
      ..writeln('        entity.value = blank;')
      ..writeln('        _applyCandidate(blank);')
      ..writeln('        persistedKey.value = null;')
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln(
        '      final result = await _repository.get${model.baseName}(key);',
      )
      ..writeln('      if (result == null) {')
      ..writeln("        throw RecordNotFoundException('record not found');")
      ..writeln('      }')
      ..writeln('      if (isDisposed) return;')
      ..writeln('      entity.value = result;')
      ..writeln('      _applyCandidate(result);')
      ..writeln('      persistedKey.value = key;')
      ..writeln('    } catch (error, stackTrace) {')
      ..writeln('      errorMessage.value = foxyErrorMessage(error);')
      ..writeln(
        "      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);",
      )
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      loading.value = false;')
      ..writeln('    }')
      ..writeln('  }');
  }

  void _emitPersist(StringBuffer buffer, FormGenerationModel model) {
    final persistedKeyWrite = model.singleKeyFieldName != null
        ? 'candidate.${model.singleKeyFieldName}'
        : '${model.baseName}Key.fromEntity(candidate)';
    buffer
      ..writeln('  Future<void> persist() async {')
      ..writeln('    if (submitting.value) {')
      ..writeln("      throw BusyException('operation already in progress');")
      ..writeln('    }')
      ..writeln('    submitting.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      final candidate = _collectCandidate();')
      ..writeln('      final originalKey = persistedKey.value;')
      ..writeln('      final action = originalKey == null')
      ..writeln('          ? ActivityActionType.create')
      ..writeln('          : ActivityActionType.update;')
      ..writeln('      if (originalKey == null) {')
      ..writeln('        await _repository.store${model.baseName}(candidate);')
      ..writeln('      } else {')
      ..writeln(
        '        await _repository.update${model.baseName}('
        'originalKey, candidate);',
      )
      ..writeln('      }')
      ..writeln('      persistedKey.value = $persistedKeyWrite;')
      ..writeln('      entity.value = candidate;')
      ..writeln('      _logActivity(action, candidate);')
      ..writeln('    } catch (error) {')
      ..writeln('      errorMessage.value = foxyErrorMessage(error);')
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      submitting.value = false;')
      ..writeln('    }')
      ..writeln('  }');
  }

  void _emitLogActivity(StringBuffer buffer, FormGenerationModel model) {
    buffer.writeln(
      '  void _logActivity(ActivityActionType action, '
      '${model.entityClassName} ${model.entityCamelName}) {}',
    );
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
      (FormFieldKind.plain, 'bool') =>
        'SelectFieldController<int>(fallback: 0)',
      _ => throw InvalidGenerationSourceError(
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
      ..writeln('  ${model.entityClassName} _collectCandidate() {')
      ..writeln('    return ${model.entityClassName}(');
    for (final field in model.fields) {
      final controller = controllerName(field);
      final collect =
          field.kind == FormFieldKind.plain && field.dartType == 'bool'
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
