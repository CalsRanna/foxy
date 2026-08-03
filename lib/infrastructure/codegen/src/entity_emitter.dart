import 'package:source_gen/source_gen.dart';

import 'dart_literal.dart';
import 'entity_model.dart';

final class EntityEmitter {
  const EntityEmitter();

  /// Brief 类成员顺序遵循 "Sort Members" 规则:
  /// 字段(保持原序)→ 构造函数(无名 → fromJson)→ hashCode getter
  /// → key getter → == → toString。
  String emitBrief(EntityGenerationModel model) {
    final fields = model.briefFields;
    final keyFields = model.keyFields;
    final buffer = StringBuffer()
      ..writeln('final class ${model.briefClassName} {');
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
    _emitValueHashCode(buffer, model.briefClassName, fields);
    buffer.writeln();
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
    buffer.writeln();
    _emitValueEquals(buffer, model.briefClassName, fields);
    buffer.writeln();
    _emitValueToString(buffer, model.briefClassName, fields);
    buffer.writeln('}');
    return buffer.toString();
  }

  /// 顶层成员顺序遵循 Dart "Sort Members" 规则:公开 class 按名称
  /// (Brief 在前),私有 mixin 最后。
  String emitEntityPart(EntityGenerationModel model) {
    final sections = <String>[
      if (model.generateBrief) emitBrief(model),
      if (model.keyFields.length > 1) emitKey(model),
      emitFullMixin(model),
    ];
    return sections.join('\n\n');
  }

  /// mixin 成员顺序遵循 "Sort Members" 规则:
  /// 实例 getter(hashCode)→ 实例方法(== → copyWith → toJson → toString)
  /// → 静态方法(fromJson)。
  String emitFullMixin(EntityGenerationModel model) {
    final buffer = StringBuffer()..writeln('mixin ${model.mixinName} {');
    _emitMixinHashCode(buffer, model);
    buffer.writeln();
    _emitMixinEquals(buffer, model);
    buffer.writeln();
    _emitMixinCopyWith(buffer, model);
    buffer.writeln();
    _emitMixinToJson(buffer, model);
    buffer.writeln();
    _emitMixinToString(buffer, model);
    buffer.writeln();
    _emitMixinFromJson(buffer, model);
    buffer.writeln('}');
    return buffer.toString();
  }

  /// Key 类成员顺序遵循 "Sort Members" 规则:
  /// 字段(保持原序)→ 构造函数(无名 → fromEntity)→ hashCode getter
  /// → == → toString。
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
      ..writeln();
    _emitValueHashCode(buffer, model.keyClassName, fields);
    buffer.writeln();
    _emitValueEquals(buffer, model.keyClassName, fields);
    buffer.writeln();
    _emitValueToString(buffer, model.keyClassName, fields);
    buffer.writeln('}');
    return buffer.toString();
  }

  String _copyParameterType(String type) =>
      type.endsWith('?') ? type : '$type?';

  void _emitMixinCopyWith(StringBuffer buffer, EntityGenerationModel model) {
    buffer.writeln('  ${model.className} copyWith({');
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
      ..writeln('  }');
  }

  void _emitMixinEquals(StringBuffer buffer, EntityGenerationModel model) {
    buffer
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
    buffer.writeln('  }');
  }

  void _emitMixinFromJson(StringBuffer buffer, EntityGenerationModel model) {
    buffer.writeln(
      '  static ${model.className} fromJson(Map<String, dynamic> json) {',
    );
    buffer.writeln('    return ${model.className}(');
    for (final field in model.fields) {
      buffer.writeln('      ${field.dartName}: ${_fullFromJson(field)},');
    }
    buffer
      ..writeln('    );')
      ..writeln('  }');
  }

  void _emitMixinHashCode(StringBuffer buffer, EntityGenerationModel model) {
    buffer
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
      ..writeln('  }');
  }

  void _emitMixinToJson(StringBuffer buffer, EntityGenerationModel model) {
    buffer
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
      ..writeln('  }');
  }

  void _emitMixinToString(StringBuffer buffer, EntityGenerationModel model) {
    buffer
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
      ..writeln('  }');
  }

  void _emitValueEquals(
    StringBuffer buffer,
    String className,
    List<EntityFieldModel> fields,
  ) {
    buffer
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
    buffer.writeln('  }');
  }

  /// 无继承 `final class`(Key / Brief)共用的值语义成员。
  void _emitValueHashCode(
    StringBuffer buffer,
    String className,
    List<EntityFieldModel> fields,
  ) {
    buffer
      ..writeln('  @override')
      ..writeln('  int get hashCode => Object.hashAll([');
    for (final field in fields) {
      buffer.writeln('    ${field.dartName},');
    }
    buffer.writeln('  ]);');
  }

  void _emitValueToString(
    StringBuffer buffer,
    String className,
    List<EntityFieldModel> fields,
  ) {
    buffer
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
    // laconic_mysql 把 tinyint(1) 列解码成 Dart bool（二进制与文本协议都如此），
    // 而 tinyint(1) 常被声明为 int/bool 字段（如 creature_onkill_reputation）——
    // 因此 int/bool 的 fromJson 必须双容忍 bool/num 两种形态，否则读真实数据即抛
    // TypeError（feature_entity.dart 手写代码 `== 1 || == true` 同此考虑）。
    return switch (field.nonNullableType) {
      'int' =>
        "json[$key] == true ? 1 : json[$key] == false ? 0 : "
            "(json[$key] as num?)?.toInt()$fallback",
      'double' => "(json[$key] as num?)?.toDouble()$fallback",
      'String' => "json[$key]?.toString()$fallback",
      'bool' =>
        "json[$key] == null ? "
            "${dartLiteral(field.constructorDefaultValue, asType: 'bool')} : "
            "(json[$key] == true || json[$key] == 1)",
      _ => throw InvalidGenerationSourceError(
        'Unsupported field type ${field.dartType}',
      ),
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
}
