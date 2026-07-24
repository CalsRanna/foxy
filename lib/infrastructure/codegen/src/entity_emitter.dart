import 'entity_model.dart';

final class EntityEmitter {
  const EntityEmitter();

  String emitFullMixin(EntityGenerationModel model) {
    final buffer = StringBuffer()..writeln('mixin ${model.mixinName} {');
    for (final field in model.fields) {
      buffer.writeln('  ${field.dartType} get ${field.dartName};');
    }
    buffer
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
      ..writeln('    return ${model.className}(');
    for (final field in model.fields) {
      buffer.writeln(
        '      ${field.dartName}: ${field.dartName} ?? this.${field.dartName},',
      );
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Map<String, dynamic> toJson() {')
      ..writeln('    return {');
    for (final field in model.fields) {
      buffer.writeln(
        '      ${_literal(field.columnName)}: ${_fullToJson(field)},',
      );
    }
    buffer
      ..writeln('    };')
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  bool operator ==(Object other) {')
      ..writeln('    return identical(this, other) ||')
      ..writeln('        other is ${model.className} &&')
      ..writeln('            runtimeType == other.runtimeType &&');
    for (var index = 0; index < model.fields.length; index++) {
      final field = model.fields[index];
      final suffix = index == model.fields.length - 1 ? ';' : ' &&';
      buffer.writeln(
        '            ${field.dartName} == other.${field.dartName}$suffix',
      );
    }
    buffer
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  int get hashCode {')
      ..writeln('    return Object.hashAll([')
      ..writeln('      runtimeType,');
    for (final field in model.fields) {
      buffer.writeln('      ${field.dartName},');
    }
    buffer
      ..writeln('    ]);')
      ..writeln('  }')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  String toString() {')
      ..writeln("    return '${model.className}('");
    for (var index = 0; index < model.fields.length; index++) {
      final field = model.fields[index];
      final suffix = index == model.fields.length - 1 ? "'" : ", '";
      buffer.writeln("        '${field.dartName}: \$${field.dartName}$suffix");
    }
    buffer
      ..writeln("        ')';")
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }

  String emitKeyLibrary(EntityGenerationModel model) {
    final fields = model.keyFields;
    final buffer = StringBuffer()
      ..writeln("import '${model.inputFileName}';")
      ..writeln()
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

  String emitBriefLibrary(EntityGenerationModel model) {
    final fields = model.briefFields;
    final keyFields = model.keyFields;
    final buffer = StringBuffer();
    if (keyFields.length > 1) {
      buffer
        ..writeln(
          "import '${model.inputFileName.replaceFirst('.dart', '.key.g.dart')}';",
        )
        ..writeln();
    }
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
                  '${_literal(field.constructorDefaultValue, asType: field.nonNullableType)},',
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
    buffer.writeln('}');
    return buffer.toString();
  }

  String emitFilterLibrary(EntityGenerationModel model) {
    final fields = model.filterFields;
    final buffer = StringBuffer()
      ..writeln('final class ${model.filterClassName} {');
    for (final field in fields) {
      buffer.writeln('  final ${field.filter!.dartType} ${field.dartName};');
    }
    buffer
      ..writeln()
      ..writeln('  const ${model.filterClassName}({');
    for (final field in fields) {
      final filter = field.filter!;
      buffer.writeln(
        '    this.${field.dartName} = '
        '${_literal(filter.defaultValue, asType: filter.dartType)},',
      );
    }
    buffer
      ..writeln('  });')
      ..writeln()
      ..writeln(
        '  factory ${model.filterClassName}.fromJson('
        'Map<String, dynamic> json) {',
      )
      ..writeln('    return ${model.filterClassName}(');
    for (final field in fields) {
      buffer.writeln('      ${field.dartName}: ${_filterFromJson(field)},');
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  ${model.filterClassName} copyWith({');
    for (final field in fields) {
      buffer.writeln('    ${field.filter!.dartType}? ${field.dartName},');
    }
    buffer
      ..writeln('  }) {')
      ..writeln('    return ${model.filterClassName}(');
    for (final field in fields) {
      buffer.writeln(
        '      ${field.dartName}: ${field.dartName} ?? this.${field.dartName},',
      );
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Map<String, dynamic> toJson() {')
      ..writeln('    return {');
    for (final field in fields) {
      buffer.writeln('      ${_literal(field.dartName)}: ${field.dartName},');
    }
    buffer
      ..writeln('    };')
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }

  String _fullFromJson(EntityFieldModel field) {
    final key = _literal(field.columnName);
    final fallback = field.constructorDefaultValue == null
        ? ''
        : ' ?? ${_literal(field.constructorDefaultValue, asType: field.nonNullableType)}';
    return switch (field.nonNullableType) {
      'int' => "(json[$key] as num?)?.toInt()$fallback",
      'double' => "(json[$key] as num?)?.toDouble()$fallback",
      'String' => "json[$key]?.toString()$fallback",
      'bool' =>
        "json[$key] == null ? "
            "${_literal(field.constructorDefaultValue, asType: 'bool')} : "
            "(json[$key] as num).toInt() == 1",
      _ => throw StateError('Unsupported field type ${field.dartType}'),
    };
  }

  String _fullToJson(EntityFieldModel field) {
    if (field.nonNullableType != 'bool') return field.dartName;
    if (field.nullable) {
      return '${field.dartName} == null '
          '? null : (${field.dartName}! ? 1 : 0)';
    }
    return '${field.dartName} ? 1 : 0';
  }

  String _filterFromJson(EntityFieldModel field) {
    final filter = field.filter!;
    final key = _literal(field.dartName);
    final fallback = _literal(filter.defaultValue, asType: filter.dartType);
    return switch (filter.type) {
      // ignore: deprecated_member_use_from_same_package
      _ when filter.dartType == 'bool' => 'json[$key] as bool? ?? $fallback',
      _ when filter.dartType == 'double' =>
        '(json[$key] as num?)?.toDouble() ?? $fallback',
      _ when filter.dartType == 'int' =>
        '(json[$key] as num?)?.toInt() ?? $fallback',
      _ => 'json[$key]?.toString() ?? $fallback',
    };
  }

  String _copyParameterType(String type) =>
      type.endsWith('?') ? type : '$type?';

  String _literal(Object? value, {String? asType}) {
    if (value == null) return 'null';
    if (value is String) return _stringLiteral(value);
    if (value is bool || value is int) {
      if (asType == 'double' && value is int) return '$value.0';
      return '$value';
    }
    if (value is double) {
      if (value.isFinite) {
        final text = value.toString();
        return text.contains('.') ? text : '$text.0';
      }
    }
    throw StateError('Unsupported literal $value (${value.runtimeType})');
  }

  String _stringLiteral(String value) {
    final escaped = value
        .replaceAll(r'\', r'\\')
        .replaceAll("'", r"\'")
        .replaceAll(r'$', r'\$')
        .replaceAll('\n', r'\n')
        .replaceAll('\r', r'\r')
        .replaceAll('\t', r'\t');
    return "'$escaped'";
  }
}
