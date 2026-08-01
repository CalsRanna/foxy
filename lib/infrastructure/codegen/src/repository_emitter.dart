import 'dart_literal.dart';
import 'repository_model.dart';

final class RepositoryEmitter {
  const RepositoryEmitter();

  /// 成员顺序遵循 "Sort Members" 规则:公开方法按名(destroy → get
  /// → store → update),私有方法按名(_before* → _whereKey)。
  String emit(RepositoryGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on RepositoryMixin {');
    _emitDestroy(buffer, model);
    _emitGet(buffer, model);
    _emitStore(buffer, model);
    _emitUpdate(buffer, model);
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

  String _table(RepositoryGenerationModel model) =>
      dartStringLiteral(model.table);
}
