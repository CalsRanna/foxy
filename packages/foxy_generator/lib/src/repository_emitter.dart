import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy_generator/src/dart_literal.dart';
import 'package:foxy_generator/src/naming.dart';
import 'package:foxy_generator/src/repository_model.dart';

final class RepositoryEmitter {
  const RepositoryEmitter();

  /// Member order follows the "Sort Members" rule: public methods by name
  /// (copy → count → create → destroy → getBrief → get → getXxxs →
  /// getXxxLocales → saveXxxLocales → store → update), private methods by
  /// name (_applyFilter → _before* → _whereKey).
  String emit(RepositoryGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on ${_onClause(model)} {');
    if (model.queryLayerEnabled) {
      _emitCopy(buffer, model);
      _emitCount(buffer, model);
      _emitCreate(buffer, model);
    }
    _emitDestroy(buffer, model);
    _emitGet(buffer, model);
    if (model.queryLayerEnabled) {
      _emitGetBrief(buffer, model);
    }
    // Full-list queries are generated only for main-table repositories
    // (child tables have no full consumers such as DBC export).
    if (model.listViewModelPresent) {
      _emitGetAll(buffer, model);
    }
    if (model.localeHelpersEnabled) {
      _emitGetLocales(buffer, model);
      _emitSaveLocales(buffer, model);
    }
    _emitStore(buffer, model);
    _emitUpdate(buffer, model);
    if (model.listViewModelPresent) {
      _emitApplyFilter(buffer, model);
    }
    _emitWriteHooks(buffer, model);
    _emitWhereKey(buffer, model);
    buffer.writeln('}');
    return buffer.toString();
  }

  /// Locale helpers delegate to DbcLocaleRepositoryMixin's
  /// loadDbcLocaleField/storeDbcLocaleField; the generated mixin's on clause
  /// must be widened to that mixin (the repository class already mixes it in).
  String _onClause(RepositoryGenerationModel model) =>
      model.localeHelpersEnabled
      ? 'RepositoryMixin, DbcLocaleRepositoryMixin'
      : 'RepositoryMixin';

  void _emitGetLocales(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<List<DbcLocaleFieldValue>> get${model.baseName}Locales('
        'int id, DbcLocaleFieldDefinition field) =>',
      )
      ..writeln('      loadDbcLocaleField(id, field);')
      ..writeln();
  }

  void _emitSaveLocales(StringBuffer buffer, RepositoryGenerationModel model) {
    buffer
      ..writeln(
        '  Future<void> save${model.baseName}Locales('
        'int id, DbcLocaleFieldDefinition field, '
        'List<DbcLocaleFieldValue> locales) =>',
      )
      ..writeln('      storeDbcLocaleField(id, field, locales);')
      ..writeln();
  }

  /// Physical column names are always wrapped in backticks and written as
  /// Dart string literals.
  ///
  /// laconic does not escape identifiers; column names are spliced into SQL
  /// verbatim. With unconditional backticks, MySQL reserved words such as
  /// `index` and `rank` need no whitelist.
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
    final links = model.linkKeyFields;
    buffer
      ..writeln(
        '  Future<${model.keyType}> copy${model.baseName}'
        '(${model.keyType} key) async {',
      )
      ..writeln('    final source = await get${model.baseName}(key);')
      ..writeln('    if (source == null) {')
      ..writeln(
        "      throw RecordNotFoundException('${model.table} record not found');",
      )
      ..writeln('    }')
      ..writeln(
        '    final blank = await create${model.baseName}('
        '${links.isEmpty ? '' : links.map((p) => 'source.${p.dartName}').join(', ')});',
      )
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
    final links = model.linkKeyFields;
    if (links.isEmpty) {
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
      return;
    }
    buffer
      ..writeln(
        '  Future<int> count${pluralize(model.baseName)}'
        '(${_linkParams(links)}) async {',
      )
      ..writeln(
        '    return laconic.table(${_table(model)})${_linkWheres(links)}'
        '.count();',
      )
      ..writeln('  }')
      ..writeln();
  }

  void _emitCreate(StringBuffer buffer, RepositoryGenerationModel model) {
    final links = model.linkKeyFields;
    if (links.isEmpty) {
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
      return;
    }
    final linkNames = links.map((p) => p.dartName).toList();
    buffer.writeln(
      '  Future<${model.entityClassName}> create${model.baseName}'
      '(${_linkParams(links)}) async {',
    );
    buffer.writeln('    return ${model.entityClassName}(');
    for (final link in links) {
      buffer.writeln('      ${link.dartName}: ${link.dartName},');
    }
    for (final field in model.keyFields) {
      if (linkNames.contains(field.dartName)) continue;
      buffer.writeln(
        '      ${field.dartName}: await nextMaxPlusOne('
        '${_table(model)}, ${_column(field.columnName)}, '
        'where: {${_linkWhereMap(links)}}),',
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
      ..writeln(
        "      throw RecordNotFoundException('${model.table} record not found');",
      )
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
    final links = model.linkKeyFields;
    if (links.isEmpty) {
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
      return;
    }
    buffer
      ..writeln(
        '  Future<List<${model.briefEntityClassName}>> '
        'getBrief${pluralize(model.baseName)}('
        '${_linkParams(links)}, {',
      )
      ..writeln('    int page = 1,')
      ..writeln('  }) async {')
      ..writeln('    var offset = (page - 1) * kPageSize;')
      ..writeln('    var builder = laconic.table(${_table(model)}).select([');
    for (final column in model.briefProjectionColumns) {
      buffer.writeln('      ${_column(column)},');
    }
    buffer
      ..writeln('    ]);')
      ..writeln('    builder = builder${_linkWheres(links)};')
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
        ..writeln(
          "      throw InvalidPrimaryKeyException("
          "'primary key must be assigned before store');",
        )
        ..writeln('    }');
    }
    // Duplicate-key retry only reallocates the "sequence column": when
    // autoIncrementKey is declared only it is reallocated; otherwise retry
    // happens only when exactly one non-link int primary key exists (the
    // MAX+1 race only affects numeric primary keys); otherwise throw
    // DuplicateKeyException rather than rewriting multiple keys — pasting an
    // existing composite-key row with all keys taking a global MAX+1 would
    // silently write unrelated garbage rows.
    final retriedKeys = model.autoIncrementKey != null
        ? [model.autoIncrementKey!]
        : model.keyFields
              .where(
                (field) =>
                    field.dartType == 'int' &&
                    !model.linkKeyFields.any(
                      (p) => p.dartName == field.dartName,
                    ),
              )
              .map((field) => field.dartName)
              .toList();
    final retryScope = <String>{
      ...model.linkKeyFields.map((p) => p.dartName),
      ...model.autoIncrementScope,
    }.toList();
    buffer
      ..writeln('    await _beforeStore($parameter);')
      ..writeln('    final json = prepareWriteJson($parameter.toJson());')
      ..writeln('    try {')
      ..writeln('      await laconic.table(${_table(model)}).insert([json]);')
      ..writeln('    } catch (error) {')
      ..writeln('      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;');
    if (retriedKeys.length != 1) {
      buffer.writeln(
        "      throw DuplicateKeyException('duplicate key in ${model.table}');",
      );
    } else {
      final retriedKey = retriedKeys.single;
      final retriedField = model.keyFields.firstWhere(
        (field) => field.dartName == retriedKey,
      );
      buffer
        // TOCTOU fallback: when concurrent creates obtain the same MAX+1,
        // reallocate the sequence column and retry once.
        // Known boundary: after a successful retry the caller's key is not
        // updated; refreshing the list reveals the new row.
        ..writeln('      final retried = $parameter.copyWith(')
        ..writeln('        $retriedKey: await nextMaxPlusOne(')
        ..writeln(
          '          ${_table(model)}, ${_column(retriedField.columnName)},',
        );
      if (retryScope.isNotEmpty) {
        buffer.writeln(
          '          where: {${_retryWhereMap(model, parameter, retryScope)}},',
        );
      }
      buffer
        ..writeln('        ),')
        ..writeln('      );')
        ..writeln('      try {')
        ..writeln('        await laconic.table(${_table(model)})'
          '.insert([prepareWriteJson(retried.toJson())]);')
        ..writeln('        return;')
        ..writeln('      } catch (retryError) {')
        ..writeln('        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {')
        ..writeln(
          "          throw DuplicateKeyException('duplicate key in ${model.table}');",
        )
        ..writeln('        }')
        ..writeln('        rethrow;')
        ..writeln('      }');
    }
    buffer
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
      ..writeln(
        "        throw DuplicateKeyException('duplicate key in ${model.table}');",
      )
      ..writeln('      }')
      ..writeln('      rethrow;')
      ..writeln('    }')
      // "No match" is a business result, not a driver exception; it must stay
      // outside the try block, otherwise the duplicate-entry branch above
      // would re-check it.
      ..writeln('    if (matchedRows == 0) {')
      ..writeln(
        "      throw RecordNotFoundException('${model.table} record not found');",
      )
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

  /// Link-key parameter list: `int race, int class_` (empty list → empty string).
  String _linkParams(List<RepositoryKeyFieldModel> links) =>
      links.map((p) => '${p.dartType} ${p.dartName}').join(', ');

  /// Link-key where chain: `where('`race`', race).where('`class`', class_)`.
  String _linkWheres(List<RepositoryKeyFieldModel> links) => links
      .map((p) => '.where(${_column(p.columnName)}, ${p.dartName})')
      .join();

  /// Link-key where map literal: `'`race`': race, '`class`': class_`.
  String _linkWhereMap(List<RepositoryKeyFieldModel> links) =>
      links.map((p) => "'${p.columnName}': ${p.dartName}").join(', ');

  /// Sequence-column where map for the retry path, referenced via the entity
  /// parameter, e.g. `'CreatureID': loot.CreatureID` (_column already returns
  /// a quoted literal).
  /// [scopeNames] are the field dart names after merging linkKey with
  /// autoIncrementScope.
  String _retryWhereMap(
    RepositoryGenerationModel model,
    String parameter,
    List<String> scopeNames,
  ) =>
      scopeNames
          .map(
            (name) => '${_column(
              model.keyFields.firstWhere((f) => f.dartName == name).columnName,
            )}: $parameter.$name',
          )
          .join(', ');

  /// `.orderBy('`ID`')`, or a chained `.orderBy(...).orderBy(...)` for
  /// composite keys.
  String _orderByClause(RepositoryGenerationModel model) {
    final buffer = StringBuffer();
    for (final field in model.keyFields) {
      buffer.write('.orderBy(${_column(field.columnName)})');
    }
    return buffer.toString();
  }

  /// Physical table name written as a Dart string literal.
  ///
  /// The mixing-in class declares `static const _table`, but mixin instance
  /// methods cannot access static members by bare name, so the literal is
  /// inlined here; RepositoryReader still validates that `_table` matches
  /// the annotation.
  String _table(RepositoryGenerationModel model) =>
      dartStringLiteral(model.table);
}
