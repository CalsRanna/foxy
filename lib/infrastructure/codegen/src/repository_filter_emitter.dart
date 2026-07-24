import 'repository_filter_model.dart';

final class RepositoryFilterEmitter {
  const RepositoryFilterEmitter();

  String emit(RepositoryFilterGenerationModel model) {
    final buffer = StringBuffer()..writeln('final class ${model.className} {');
    for (final field in model.fields) {
      buffer.writeln('  final ${field.dartType} ${field.name};');
    }
    buffer
      ..writeln()
      ..writeln('  const ${model.className}({');
    for (final field in model.fields) {
      buffer.writeln(
        '    this.${field.name} = '
        '${_literal(field.defaultValue, asType: field.dartType)},',
      );
    }
    buffer
      ..writeln('  });')
      ..writeln()
      ..writeln(
        '  factory ${model.className}.fromJson(Map<String, dynamic> json) {',
      )
      ..writeln('    return ${model.className}(');
    for (final field in model.fields) {
      buffer.writeln('      ${field.name}: ${_fromJson(field)},');
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  ${model.className} copyWith({');
    for (final field in model.fields) {
      buffer.writeln('    ${field.dartType}? ${field.name},');
    }
    buffer
      ..writeln('  }) {')
      ..writeln('    return ${model.className}(');
    for (final field in model.fields) {
      buffer.writeln(
        '      ${field.name}: ${field.name} ?? this.${field.name},',
      );
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Map<String, dynamic> toJson() {')
      ..writeln('    return {');
    for (final field in model.fields) {
      buffer.writeln("      '${field.name}': ${field.name},");
    }
    buffer
      ..writeln('    };')
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }

  String _fromJson(RepositoryFilterFieldModel field) {
    final key = "'${field.name}'";
    final fallback = _literal(field.defaultValue, asType: field.dartType);
    return switch (field.dartType) {
      'bool' => 'json[$key] as bool? ?? $fallback',
      'double' => '(json[$key] as num?)?.toDouble() ?? $fallback',
      'int' => '(json[$key] as num?)?.toInt() ?? $fallback',
      _ => 'json[$key]?.toString() ?? $fallback',
    };
  }

  String _literal(Object value, {required String asType}) {
    if (value is String) {
      final escaped = value
          .replaceAll(r'\', r'\\')
          .replaceAll("'", r"\'")
          .replaceAll(r'$', r'\$')
          .replaceAll('\n', r'\n')
          .replaceAll('\r', r'\r')
          .replaceAll('\t', r'\t');
      return "'$escaped'";
    }
    if (value is bool || value is int) {
      if (asType == 'double' && value is int) return '$value.0';
      return '$value';
    }
    if (value is double && value.isFinite) {
      final text = value.toString();
      return text.contains('.') ? text : '$text.0';
    }
    throw StateError('Unsupported Filter literal $value');
  }
}
