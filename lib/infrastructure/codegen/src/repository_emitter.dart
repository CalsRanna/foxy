import '../repository_annotations.dart';
import 'dart_literal.dart';
import 'naming.dart';
import 'repository_model.dart';

final class RepositoryEmitter {
  const RepositoryEmitter();

  /// 成员顺序遵循 "Sort Members" 规则:公开方法按名(copy → count →
  /// create → destroy → getBrief → get → getXxxs → store → update),
  /// 私有方法按名(_applyFilter → _before* → _whereKey)。
  String emit(RepositoryGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on RepositoryMixin {');
    if (model.queryLayerEnabled) {
      _emitCopy(buffer, model);
      _emitCount(buffer, model);
      _emitCreate(buffer, model);
    }
    _emitDestroy(buffer, model);
    _emitGet(buffer, model);
    if (model.queryLayerEnabled) {
      _emitGetBrief(buffer, model);
      _emitGetAll(buffer, model);
    }
    _emitStore(buffer, model);
    _emitUpdate(buffer, model);
    if (model.queryLayerEnabled) {
      _emitApplyFilter(buffer, model);
    }
    _emitWriteHooks(buffer, model);
    _emitWhereKey(buffer, model);
    buffer.writeln('}');
    return buffer.toString();
  }

  /// 物理列名一律用反引号包裹后写成 Dart 字符串字面量。
  ///
  /// laconic 不转义标识符，列名会原样拼进 SQL。无条件加反引号后，
  /// `index`、`rank` 这类 MySQL 保留字列不需要逐个登记白名单。
  String _column(String columnName) => dartStringLiteral('`$columnName`');

  void _emitApplyFilter(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer.writeln(
      '  QueryBuilder _applyFilter(QueryBuilder builder, '
      '${model.filterClassName}? filter) {',
    );
    buffer.writeln('    if (filter == null) return builder;');
    for (final field in model.filterFields) {
      final active = switch (field.type) {
        FoxyFilterType.boolean =>
          'filter.${field.name} != '
              '${dartLiteral(field.defaultValue, asType: 'bool')}',
        FoxyFilterType.decimal =>
          'filter.${field.name} != '
              '${dartLiteral(field.defaultValue, asType: 'double')}',
        FoxyFilterType.integer =>
          'filter.${field.name} != '
              '${dartLiteral(field.defaultValue, asType: 'int')}',
        FoxyFilterType.text => 'filter.${field.name}.isNotEmpty',
      };
      buffer
        ..writeln('    if ($active) {')
        ..writeln('      builder = builder.where(')
        ..writeln('        ${_column(field.column)},')
        ..writeln('        filter.${field.name},')
        ..writeln('      );')
        ..writeln('    }');
    }
    buffer.writeln('    return builder;');
    buffer.writeln('  }');
    buffer.writeln();
  }

  void _emitCopy(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<${model.keyType}> copy${model.baseName}'
        '(${model.keyType} key) async {',
      )
      ..writeln('    final source = await get${model.baseName}(key);')
      ..writeln('    if (source == null) {')
      ..writeln("      throw StateError('原记录不存在，可能已被其他操作修改或删除');")
      ..writeln('    }')
      ..writeln('    final blank = await create${model.baseName}();')
      ..writeln('    final copied = source.copyWith(');
    for (final field in model.keyFields) {
      buffer.writeln('      ${field.dartName}: blank.${field.dartName},');
    }
    buffer
      ..writeln('    );')
      ..writeln('    await store${model.baseName}(copied);')
      ..writeln(
        '    return ${model.keyFields.length == 1 ? 'copied.${model.keyFields.single.dartName}' : '${model.baseName}Key.fromEntity(copied)'};',
      )
      ..writeln('  }')
      ..writeln();
  }

  void _emitCount(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<int> count${pluralize(model.baseName)}'
        '({${model.filterClassName}? filter}) async {',
      )
      ..writeln(
        '    return _applyFilter(laconic.table(${_table(model)}), filter)'
        '.count();',
      )
      ..writeln('  }')
      ..writeln();
  }

  void _emitCreate(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer.writeln(
      '  Future<${model.entityClassName}> create${model.baseName}() async {',
    );
    buffer.writeln('    return ${model.entityClassName}(');
    for (final field in model.keyFields) {
      buffer.writeln(
        '      ${field.dartName}: await nextMaxPlusOne('
        '${_table(model)}, ${_column(field.columnName)}),',
      );
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln();
  }

  void _emitDestroy(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<void> destroy${model.baseName}(${model.keyType} key) async {',
      )
      ..writeln('    await _beforeDestroy(key);')
      ..writeln(
        '    final deletedRows = await _whereKey('
        'laconic.table(${_table(model)}), key).delete();',
      )
      ..writeln('    if (deletedRows == 0) {')
      ..writeln("      throw StateError('原记录不存在，可能已被其他操作修改或删除');")
      ..writeln('    }')
      ..writeln('  }')
      ..writeln();
  }

  void _emitGet(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<${model.entityClassName}?> get${model.baseName}'
        '(${model.keyType} key) async {',
      )
      ..writeln(
        '    final results = await _whereKey('
        'laconic.table(${_table(model)}), key).limit(1).get();',
      )
      ..writeln('    if (results.isEmpty) return null;')
      ..writeln(
        '    return ${model.entityClassName}.fromJson(results.first.toMap());',
      )
      ..writeln('  }')
      ..writeln();
  }

  void _emitGetAll(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<List<${model.entityClassName}>> '
        'get${pluralize(model.baseName)}() async {',
      )
      ..writeln(
        '    var builder = laconic.table(${_table(model)})'
        '${_orderByClause(model)};',
      )
      ..writeln('    final results = await builder.get();')
      ..writeln(
        '    return results'
        '.map((e) => ${model.entityClassName}.fromJson(e.toMap())).toList();',
      )
      ..writeln('  }')
      ..writeln();
  }

  void _emitGetBrief(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<List<${model.briefEntityClassName}>> '
        'getBrief${pluralize(model.baseName)}({',
      )
      ..writeln('    int page = 1,')
      ..writeln('    ${model.filterClassName}? filter,')
      ..writeln('  }) async {')
      ..writeln('    var offset = (page - 1) * kPageSize;')
      ..writeln('    var builder = laconic.table(${_table(model)}).select([');
    for (final column in model.briefProjectionColumns) {
      buffer.writeln('      ${_column(column)},');
    }
    buffer
      ..writeln('    ]);')
      ..writeln('    builder = _applyFilter(builder, filter);')
      ..writeln('    builder = builder${_orderByClause(model)};')
      ..writeln('    builder = builder.limit(kPageSize).offset(offset);')
      ..writeln('    final results = await builder.get();')
      ..writeln('    return results')
      ..writeln(
        '        .map((e) => ${model.briefEntityClassName}.fromJson(e.toMap()))'
        '.toList();',
      )
      ..writeln('  }')
      ..writeln();
  }

  void _emitStore(StringBuffer buffer, RepositoryGenerationModel model) {
    final parameter = model.entityParameterName;
    buffer.writeln(
      '  Future<void> store${model.baseName}'
      '(${model.entityClassName} $parameter) async {',
    );
    if (model.keyFields.length == 1 &&
        model.keyFields.single.dartType == 'int') {
      buffer
        ..writeln(
          '    if ($parameter.${model.keyFields.single.dartName} <= 0) {',
        )
        ..writeln("      throw StateError('主键必须在新建时显式分配');")
        ..writeln('    }');
    }
    buffer
      ..writeln('    await _beforeStore($parameter);')
      ..writeln('    final json = prepareWriteJson($parameter.toJson());')
      ..writeln('    try {')
      ..writeln('      await laconic.table(${_table(model)}).insert([json]);')
      ..writeln('    } catch (error) {')
      ..writeln('      if (MysqlErrorUtil.isDuplicateEntry(error)) {')
      ..writeln("        throw StateError('相同主键的记录已存在');")
      ..writeln('      }')
      ..writeln('      rethrow;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln();
  }

  void _emitUpdate(StringBuffer buffer, RepositoryGenerationModel model) {
    final parameter = model.entityParameterName;
    buffer
      ..writeln(
        '  Future<void> update${model.baseName}(${model.keyType} originalKey, '
        '${model.entityClassName} $parameter) async {',
      )
      ..writeln('    await _beforeUpdate(originalKey, $parameter);')
      ..writeln('    final json = prepareWriteJson($parameter.toJson());')
      ..writeln('    final int matchedRows;')
      ..writeln('    try {')
      ..writeln('      matchedRows = await _whereKey(')
      ..writeln('        laconic.table(${_table(model)}),')
      ..writeln('        originalKey,')
      ..writeln('      ).update(json);')
      ..writeln('    } catch (error) {')
      ..writeln('      if (MysqlErrorUtil.isDuplicateEntry(error)) {')
      ..writeln("        throw StateError('修改后的主键已存在');")
      ..writeln('      }')
      ..writeln('      rethrow;')
      ..writeln('    }')
      // 「未命中」是业务结果而不是驱动异常，必须留在 try 之外，
      // 否则会被上面的 duplicate-entry 翻译分支重新检查一遍。
      ..writeln('    if (matchedRows == 0) {')
      ..writeln("      throw StateError('原记录不存在，可能已被其他操作修改或删除');")
      ..writeln('    }')
      ..writeln('  }')
      ..writeln();
  }

  void _emitWhereKey(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer.writeln(
      '  QueryBuilder _whereKey(QueryBuilder builder, ${model.keyType} key) {',
    );
    if (model.keyFields.length == 1) {
      buffer.writeln(
        '    return builder.where('
        '${_column(model.keyFields.single.columnName)}, key);',
      );
    } else {
      buffer.writeln('    var query = builder;');
      for (final field in model.keyFields) {
        buffer.writeln(
          '    query = query.where(${_column(field.columnName)}, '
          'key.${field.dartName});',
        );
      }
      buffer.writeln('    return query;');
    }
    buffer.writeln('  }');
  }

  void _emitWriteHooks(StringBuffer buffer, RepositoryGenerationModel model) {
    final parameter = model.entityParameterName;
    buffer
      ..writeln('  Future<void> _beforeDestroy(${model.keyType} key) async {}')
      ..writeln()
      ..writeln(
        '  Future<void> _beforeStore'
        '(${model.entityClassName} $parameter) async {}',
      )
      ..writeln()
      ..writeln(
        '  Future<void> _beforeUpdate(${model.keyType} originalKey, '
        '${model.entityClassName} $parameter) async {}',
      )
      ..writeln();
  }

  /// `.orderBy('`ID`')` 或复合 key 的链式 `.orderBy(...).orderBy(...)`。
  String _orderByClause(RepositoryGenerationModel model) {
    final buffer = StringBuffer();
    for (final field in model.keyFields) {
      buffer.write('.orderBy(${_column(field.columnName)})');
    }
    return buffer.toString();
  }

  /// 物理表名写成 Dart 字符串字面量。
  ///
  /// 混入方类里声明的是 `static const _table`，mixin 实例方法无法按裸名
  /// 访问静态成员，所以这里直接内联字面量；`_table` 声明本身仍由
  /// RepositoryReader 校验与注解一致。
  String _table(RepositoryGenerationModel model) =>
      dartStringLiteral(model.table);
}
