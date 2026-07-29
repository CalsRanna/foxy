import 'dart_literal.dart';
import 'entity_model.dart';

final class EntityEmitter {
  const EntityEmitter();

  String emitEntityPart(EntityGenerationModel model) {
    final sections = <String>[
      emitFullMixin(model),
      if (model.keyFields.length > 1) emitKey(model),
      if (model.generateBrief) emitBrief(model),
    ];
    return sections.join('\n\n');
  }

  String emitFullMixin(EntityGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} {')
      ..writeln()
      ..writeln(
        '  static ${model.className} fromJson(Map<String, dynamic> json) {',
      )
      ..writeln('    return ${model.className}(');
    for (final field in model.fields) {
      buffer.writeln('      ${field.dartName}: ${_fullFromJson(field)},');
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  ${model.className} copyWith({');
    for (final field in model.fields) {
      buffer.writeln(
        '    ${_copyParameterType(field.dartType)} '
        '${field.dartName},',
      );
    }
    buffer
      ..writeln('  }) {')
      ..writeln('    final self = this as ${model.className};')
      ..writeln('    return ${model.className}(');
    for (final field in model.fields) {
      buffer.writeln(
        '      ${field.dartName}: ${field.dartName} ?? self.${field.dartName},',
      );
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Map<String, dynamic> toJson() {')
      ..writeln('    final self = this as ${model.className};')
      ..writeln('    return {');
    for (final field in model.fields) {
      buffer.writeln(
        '      ${dartLiteral(field.columnName)}: '
        '${_fullToJson(field, receiver: 'self')},',
      );
    }
    buffer
      ..writeln('    };')
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  bool operator ==(Object other) {')
      ..writeln('    final self = this as ${model.className};')
      ..writeln('    return identical(self, other) ||')
      ..writeln('        other is ${model.className} &&')
      ..writeln('            self.runtimeType == other.runtimeType &&');
    for (var index = 0; index < model.fields.length; index++) {
      final field = model.fields[index];
      final suffix = index == model.fields.length - 1 ? ';' : ' &&';
      buffer.writeln(
        '            self.${field.dartName} == '
        'other.${field.dartName}$suffix',
      );
    }
    buffer
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  int get hashCode {')
      ..writeln('    final self = this as ${model.className};')
      ..writeln('    return Object.hashAll([')
      ..writeln('      self.runtimeType,');
    for (final field in model.fields) {
      buffer.writeln('      self.${field.dartName},');
    }
    buffer
      ..writeln('    ]);')
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  String toString() {')
      ..writeln('    final self = this as ${model.className};')
      ..writeln("    return '${model.className}('");
    for (var index = 0; index < model.fields.length; index++) {
      final field = model.fields[index];
      final suffix = index == model.fields.length - 1 ? "'" : ", '";
      buffer.writeln(
        "        '${field.dartName}: "
        "\${self.${field.dartName}}$suffix",
      );
    }
    buffer
      ..writeln("        ')';")
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }

  String emitKey(EntityGenerationModel model) {
    final fields = model.keyFields;
    final buffer = StringBuffer()
      ..writeln('final class ${model.keyClassName} {');
    for (final field in fields) {
      buffer.writeln('  final ${field.dartType} ${field.dartName};');
    }
    buffer
      ..writeln()
      ..writeln('  const ${model.keyClassName}({');
    for (final field in fields) {
      buffer.writeln('    required this.${field.dartName},');
    }
    buffer
      ..writeln('  });')
      ..writeln()
      ..writeln(
        '  factory ${model.keyClassName}.fromEntity('
        '${model.className} entity) {',
      )
      ..writeln('    return ${model.keyClassName}(');
    for (final field in fields) {
      buffer.writeln('      ${field.dartName}: entity.${field.dartName},');
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  bool operator ==(Object other) {')
      ..writeln('    return identical(this, other) ||')
      ..writeln('        other is ${model.keyClassName} &&');
    for (var index = 0; index < fields.length; index++) {
      final field = fields[index];
      final suffix = index == fields.length - 1 ? ';' : ' &&';
      buffer.writeln(
        '            ${field.dartName} == other.${field.dartName}$suffix',
      );
    }
    buffer
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  int get hashCode => Object.hashAll([');
    for (final field in fields) {
      buffer.writeln('    ${field.dartName},');
    }
    buffer
      ..writeln('  ]);')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  String toString() {')
      ..writeln("    return '${model.keyClassName}('");
    for (var index = 0; index < fields.length; index++) {
      final field = fields[index];
      final suffix = index == fields.length - 1 ? "'" : ", '";
      buffer.writeln("        '${field.dartName}: \$${field.dartName}$suffix");
    }
    buffer
      ..writeln("        ')';")
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }

  String emitBrief(EntityGenerationModel model) {
    final fields = model.briefFields;
    final keyFields = model.keyFields;
    final buffer = StringBuffer();
    buffer.writeln('final class ${model.briefClassName} {');
    for (final field in fields) {
      buffer.writeln('  final ${field.dartType} ${field.dartName};');
    }
    buffer
      ..writeln()
      ..writeln('  const ${model.briefClassName}({');
    for (final field in fields) {
      buffer.writeln(
        field.nullable && field.constructorDefaultValue == null
            ? '    this.${field.dartName},'
            : '    this.${field.dartName} = '
                  '${dartLiteral(field.constructorDefaultValue, asType: field.nonNullableType)},',
      );
    }
    buffer
      ..writeln('  });')
      ..writeln()
      ..writeln(
        '  factory ${model.briefClassName}.fromJson('
        'Map<String, dynamic> json) {',
      )
      ..writeln('    return ${model.briefClassName}(');
    for (final field in fields) {
      buffer.writeln('      ${field.dartName}: ${_fullFromJson(field)},');
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln();
    if (keyFields.length == 1) {
      final key = keyFields.single;
      buffer.writeln('  ${key.dartType} get key => ${key.dartName};');
    } else {
      buffer
        ..writeln('  ${model.keyClassName} get key {')
        ..writeln('    return ${model.keyClassName}(');
      for (final field in keyFields) {
        buffer.writeln('      ${field.dartName}: ${field.dartName},');
      }
      buffer
        ..writeln('    );')
        ..writeln('  }');
    }
    _emitValueSemantics(buffer, model.briefClassName, fields);
    buffer.writeln('}');
    return buffer.toString();
  }

  /// 为 Brief 这类无继承的 `final class` 生成 `==` / `hashCode` / `toString`。
  ///
  /// Full Entity 的版本要额外做 `this as` 转型和 `runtimeType` 比较，
  /// 所以不复用这里的实现。
  void _emitValueSemantics(
    StringBuffer buffer,
    String className,
    List<EntityFieldModel> fields,
  ) {
    buffer
      ..writeln()
      ..writeln('  @override')
      ..writeln('  bool operator ==(Object other) {')
      ..writeln('    return identical(this, other) ||')
      ..writeln('        other is $className &&');
    for (var index = 0; index < fields.length; index++) {
      final field = fields[index];
      final suffix = index == fields.length - 1 ? ';' : ' &&';
      buffer.writeln(
        '            ${field.dartName} == other.${field.dartName}$suffix',
      );
    }
    buffer
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  int get hashCode => Object.hashAll([');
    for (final field in fields) {
      buffer.writeln('    ${field.dartName},');
    }
    buffer
      ..writeln('  ]);')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  String toString() {')
      ..writeln("    return '$className('");
    for (var index = 0; index < fields.length; index++) {
      final field = fields[index];
      final suffix = index == fields.length - 1 ? "'" : ", '";
      buffer.writeln("        '${field.dartName}: \$${field.dartName}$suffix");
    }
    buffer
      ..writeln("        ')';")
      ..writeln('  }');
  }

  String _fullFromJson(EntityFieldModel field) {
    final key = dartLiteral(field.columnName);
    final fallback = field.constructorDefaultValue == null
        ? ''
        : ' ?? ${dartLiteral(field.constructorDefaultValue, asType: field.nonNullableType)}';
    return switch (field.nonNullableType) {
      'int' => "(json[$key] as num?)?.toInt()$fallback",
      'double' => "(json[$key] as num?)?.toDouble()$fallback",
      'String' => "json[$key]?.toString()$fallback",
      'bool' =>
        "json[$key] == null ? "
            "${dartLiteral(field.constructorDefaultValue, asType: 'bool')} : "
            "(json[$key] as num).toInt() == 1",
      _ => throw StateError('Unsupported field type ${field.dartType}'),
    };
  }

  String _fullToJson(EntityFieldModel field, {required String receiver}) {
    final value = '$receiver.${field.dartName}';
    if (field.nonNullableType != 'bool') return value;
    if (field.nullable) {
      return '$value == null ? null : ($value! ? 1 : 0)';
    }
    return '$value ? 1 : 0';
  }

  String _copyParameterType(String type) =>
      type.endsWith('?') ? type : '$type?';
}
