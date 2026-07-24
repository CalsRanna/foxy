import 'repository_model.dart';

final class RepositoryEmitter {
  const RepositoryEmitter();

  String emit(RepositoryGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on RepositoryMixin {');
    _emitDestroy(buffer, model);
    _emitGet(buffer, model);
    _emitStore(buffer, model);
    _emitUpdate(buffer, model);
    _emitWriteHooks(buffer, model);
    _emitPrepareWriteJson(buffer);
    buffer.writeln(
      '  QueryBuilder _whereKey(QueryBuilder builder, ${model.keyType} key) {',
    );
    if (model.keyFields.length == 1) {
      buffer.writeln(
        "    return builder.where('${_escape(_queryColumn(model.keyFields.single.columnName))}', key);",
      );
    } else {
      buffer.writeln('    var query = builder;');
      for (final field in model.keyFields) {
        buffer.writeln(
          "    query = query.where('${_escape(_queryColumn(field.columnName))}', "
          'key.${field.dartName});',
        );
      }
      buffer.writeln('    return query;');
    }
    buffer
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }

  String _queryColumn(String columnName) {
    if (const {'index', 'rank'}.contains(columnName.toLowerCase())) {
      return '`$columnName`';
    }
    return columnName;
  }

  void _emitDestroy(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<void> destroy${model.baseName}(${model.keyType} key) async {',
      )
      ..writeln(
        "    final deletedRows = await _whereKey(laconic.table('${_escape(model.table)}'), key).delete();",
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
        '  Future<${model.entityClassName}?> get${model.baseName}(${model.keyType} key) async {',
      )
      ..writeln(
        "    final results = await _whereKey(laconic.table('${_escape(model.table)}'), key).limit(1).get();",
      )
      ..writeln('    if (results.isEmpty) return null;')
      ..writeln(
        '    return ${model.entityClassName}.fromJson(results.first.toMap());',
      )
      ..writeln('  }')
      ..writeln();
  }

  void _emitStore(StringBuffer buffer, RepositoryGenerationModel model) {
    final parameter = model.entityParameterName;
    buffer.writeln(
      '  Future<void> store${model.baseName}(${model.entityClassName} $parameter) async {',
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
      ..writeln('    final json = _prepareWriteJson($parameter.toJson());')
      ..writeln('    try {')
      ..writeln(
        "      await laconic.table('${_escape(model.table)}').insert([json]);",
      )
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
        '  Future<void> update${model.baseName}(${model.keyType} originalKey, ${model.entityClassName} $parameter) async {',
      )
      ..writeln('    await _beforeUpdate(originalKey, $parameter);')
      ..writeln('    final json = _prepareWriteJson($parameter.toJson());')
      ..writeln('    try {')
      ..writeln('      final matchedRows = await _whereKey(')
      ..writeln("        laconic.table('${_escape(model.table)}'),")
      ..writeln('        originalKey,')
      ..writeln('      ).update(json);')
      ..writeln('      if (matchedRows == 0) {')
      ..writeln("        throw StateError('原记录不存在，可能已被其他操作修改或删除');")
      ..writeln('      }')
      ..writeln('    } catch (error) {')
      ..writeln('      if (MysqlErrorUtil.isDuplicateEntry(error)) {')
      ..writeln("        throw StateError('修改后的主键已存在');")
      ..writeln('      }')
      ..writeln('      rethrow;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln();
  }

  void _emitWriteHooks(StringBuffer buffer, RepositoryGenerationModel model) {
    final parameter = model.entityParameterName;
    buffer
      ..writeln(
        '  Future<void> _beforeStore(${model.entityClassName} $parameter) async {}',
      )
      ..writeln()
      ..writeln(
        '  Future<void> _beforeUpdate(${model.keyType} originalKey, ${model.entityClassName} $parameter) async {}',
      )
      ..writeln();
  }

  void _emitPrepareWriteJson(StringBuffer buffer) {
    buffer
      ..writeln(
        '  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {',
      )
      ..writeln('    return {')
      ..writeln('      for (final entry in json.entries)')
      ..writeln(
        "        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))",
      )
      ..writeln("          '`\${entry.key}`': entry.value")
      ..writeln('        else')
      ..writeln('          entry.key: entry.value,')
      ..writeln('    };')
      ..writeln('  }')
      ..writeln();
  }

  String _escape(String value) =>
      value.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
}
