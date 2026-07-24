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
    buffer.writeln(
      '  QueryBuilder _whereKey(QueryBuilder builder, ${model.keyType} key) {',
    );
    if (model.keyFields.length == 1) {
      buffer.writeln(
        "    return builder.where('${_escape(model.keyFields.single.columnName)}', key);",
      );
    } else {
      buffer.writeln('    var query = builder;');
      for (final field in model.keyFields) {
        buffer.writeln(
          "    query = query.where('${_escape(field.columnName)}', "
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

  void _emitDestroy(StringBuffer buffer, RepositoryGenerationModel model) {
    if (!model.generateDestroy) return;
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
    if (!model.generateGet) return;
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
    if (!model.generateStore) return;
    final parameter = model.entityParameterName;
    buffer
      ..writeln(
        '  Future<void> store${model.baseName}(${model.entityClassName} $parameter) async {',
      )
      ..writeln('    try {')
      ..writeln(
        "      await laconic.table('${_escape(model.table)}').insert([$parameter.toJson()]);",
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
    if (!model.generateUpdate) return;
    final parameter = model.entityParameterName;
    buffer
      ..writeln(
        '  Future<void> update${model.baseName}(${model.keyType} originalKey, ${model.entityClassName} $parameter) async {',
      )
      ..writeln('    try {')
      ..writeln('      final matchedRows = await _whereKey(')
      ..writeln("        laconic.table('${_escape(model.table)}'),")
      ..writeln('        originalKey,')
      ..writeln('      ).update($parameter.toJson());')
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

  String _escape(String value) =>
      value.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
}
