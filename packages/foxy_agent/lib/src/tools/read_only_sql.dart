import 'package:foxy_agent/src/tools/table_catalog.dart';

/// A single MySQL SELECT validated against the agent's table and column catalog.
final class ReadOnlySql {
  static const defaultRows = 50;
  static const maxRows = 200;

  final String statement;
  final int rowLimit;

  factory ReadOnlySql.parse(String sql, TableCatalog catalog) {
    if (sql.isEmpty || sql.length > 12000) {
      throw const FormatException('SQL must contain 1 to 12000 characters.');
    }
    return _SelectParser(sql, catalog).parse();
  }

  const ReadOnlySql._(this.statement, this.rowLimit);
}

final class _SelectParser {
  // Use the subset whose token boundaries do not depend on MySQL's SQL mode.
  static final _lexeme = RegExp(
    r"([ \t\r\n]+)|([a-zA-Z_][a-zA-Z_0-9]*)|(`(?:``|[^`\\\x00])*`)|"
    r"('(?:''|[^'\\\x00])*')|([0-9]+(?:\.[0-9]+)?)|"
    r'(<=>|<=|>=|<>|!=|[(),.;+*/%<>=&|^-])',
  );
  static final _integer = RegExp(r'^[0-9]+$');
  static const _functions = {
    'ABS',
    'AVG',
    'CEIL',
    'CHAR_LENGTH',
    'COALESCE',
    'CONCAT',
    'COUNT',
    'DATE',
    'DATEDIFF',
    'FLOOR',
    'IFNULL',
    'LENGTH',
    'LOWER',
    'MAX',
    'MIN',
    'NULLIF',
    'ROUND',
    'SUM',
    'UPPER',
    'YEAR',
    'MONTH',
    'DAY',
  };
  static const _literalWords = {'NULL', 'TRUE', 'FALSE'};
  static const _tableBoundaries = {
    'JOIN',
    'INNER',
    'LEFT',
    'RIGHT',
    'ON',
    'WHERE',
    'GROUP',
    'HAVING',
    'ORDER',
    'LIMIT',
  };
  static const _orderBoundaries = {',', ';', 'ASC', 'DESC', 'LIMIT'};
  static const _precedence = {
    'OR': 1,
    'AND': 2,
    '=': 3,
    '!=': 3,
    '<>': 3,
    '<=>': 3,
    '<': 3,
    '<=': 3,
    '>': 3,
    '>=': 3,
    'IS': 3,
    'IN': 3,
    'LIKE': 3,
    'BETWEEN': 3,
    '|': 4,
    '&': 5,
    '+': 6,
    '-': 6,
    '*': 7,
    '/': 7,
    '%': 7,
    '^': 8,
  };

  final String _sql;
  final TableCatalog _catalog;
  final List<_Token> _tokens;
  final _tables = <String, TableInfo>{};
  final _columns = <({String? qualifier, String name})>[];
  final _aliases = <String>{};
  var _index = 0;
  var _depth = 0;

  _SelectParser(this._sql, this._catalog) : _tokens = _tokenize(_sql);

  _Token get _current => _tokens[_index];

  ReadOnlySql parse() {
    final select = _expect('SELECT');
    _take('DISTINCT');
    do {
      _projection();
    } while (_take(','));

    _expect('FROM');
    _table();
    while (_join()) {
      _table();
      _expect('ON');
      _expression();
    }
    if (_take('WHERE')) _expression();
    if (_take('GROUP')) {
      _expect('BY');
      _expressions();
    }
    if (_take('HAVING')) _expression();
    if (_take('ORDER')) {
      _expect('BY');
      do {
        // MySQL gives SELECT aliases precedence for a bare ORDER BY name.
        if (_current.isIdentifier &&
            _aliases.contains(_current.identifier.toLowerCase()) &&
            _isOrderBoundary(_tokens[_index + 1])) {
          _index++;
        } else {
          _expression();
        }
        if (!_take('ASC')) _take('DESC');
      } while (_take(','));
    }

    final hasLimit = _take('LIMIT');
    var rowLimit = ReadOnlySql.defaultRows;
    if (hasLimit) {
      rowLimit = _limitInteger();
      if (_take(',')) {
        rowLimit = _limitInteger();
      } else if (_take('OFFSET')) {
        _limitInteger();
      }
      if (rowLimit > ReadOnlySql.maxRows) {
        _fail('LIMIT must be at most ${ReadOnlySql.maxRows}.');
      }
    }
    final end = _current.start;
    _take(';');
    if (_current.kind != _TokenKind.end) {
      _fail('Only one SELECT with the supported clauses is allowed.');
    }
    _checkColumns();

    final body = _sql.substring(select.end, end).trim();
    final limit = hasLimit ? '' : ' LIMIT ${rowLimit + 1}';
    return ReadOnlySql._(
      '${select.text} /*+ MAX_EXECUTION_TIME(5000) */ $body$limit',
      rowLimit,
    );
  }

  void _checkColumns() {
    for (final column in _columns) {
      final qualifier = column.qualifier;
      final name = column.name;
      if (qualifier == null && _tables.length != 1) {
        _fail('Qualify column "$name" with its table alias in a JOIN.');
      }
      final table = qualifier == null
          ? _tables.values.single
          : _tables[qualifier];
      if (table == null ||
          !table.columns.any(
            (column) => column.name.toLowerCase() == name.toLowerCase(),
          )) {
        final qualified = qualifier == null ? name : '$qualifier.$name';
        _fail('Column is outside the catalog: $qualified.');
      }
    }
  }

  void _columnOrFunction() {
    final token = _current;
    final name = _identifier();
    if (_current.syntax == '(') {
      if (!_functions.contains(token.syntax) || token.end != _current.start) {
        _fail('Unsupported function or spacing: $name.');
      }
      _index++;
      if (token.syntax != 'COUNT' || !_take('*')) {
        if ({'COUNT', 'SUM', 'AVG'}.contains(token.syntax)) _take('DISTINCT');
        _expressions();
      }
      _expect(')');
    } else if (_take('.')) {
      _columns.add((qualifier: name, name: _identifier()));
    } else {
      _columns.add((qualifier: null, name: name));
    }
  }

  _Token _expect(String syntax) {
    final token = _current;
    if (!_take(syntax)) _fail('Expected $syntax.');
    return token;
  }

  void _expression([int minimum = 1]) {
    if (++_depth > 48) _fail('SQL expressions are nested too deeply.');
    try {
      _operand();
      while (true) {
        final negated = _current.syntax == 'NOT';
        final operator = negated ? _tokens[_index + 1].syntax : _current.syntax;
        final precedence = _precedence[operator] ?? 0;
        if (precedence < minimum ||
            (negated && !{'IN', 'LIKE', 'BETWEEN'}.contains(operator))) {
          return;
        }
        _index += negated ? 2 : 1;
        switch (operator) {
          case 'IS':
            _take('NOT');
            if (!_literalWords.contains(_current.syntax)) {
              _fail('Expected NULL, TRUE, or FALSE after IS.');
            }
            _index++;
          case 'IN':
            _expect('(');
            _expressions();
            _expect(')');
          case 'BETWEEN':
            _expression(precedence + 1);
            _expect('AND');
            _expression(precedence + 1);
          default:
            _expression(precedence + 1);
        }
      }
    } finally {
      _depth--;
    }
  }

  void _expressions() {
    do {
      _expression();
    } while (_take(','));
  }

  Never _fail(String message) => throw FormatException(message);

  String _identifier() {
    final token = _current;
    if (!token.isIdentifier) {
      _fail('Expected an explicit column, table, or alias.');
    }
    _index++;
    return token.identifier;
  }

  bool _isOrderBoundary(_Token token) =>
      token.kind == _TokenKind.end || _orderBoundaries.contains(token.syntax);

  bool _join() {
    if (_take('JOIN')) return true;
    if (_take('LEFT') || _take('RIGHT')) {
      _take('OUTER');
    } else if (!_take('INNER')) {
      return false;
    }
    _expect('JOIN');
    return true;
  }

  int _limitInteger() {
    final token = _current;
    final value =
        token.kind == _TokenKind.number && _integer.hasMatch(token.text)
        ? int.tryParse(token.text)
        : null;
    if (value == null || value < 0) {
      _fail('Expected a non-negative LIMIT or OFFSET integer.');
    }
    _index++;
    return value;
  }

  void _operand() {
    if (_take('NOT')) {
      _expression(3);
    } else if (_take('+') || _take('-')) {
      _expression(9);
    } else if (_take('(')) {
      _expression();
      _expect(')');
    } else if (_take('CASE')) {
      if (_current.syntax != 'WHEN') _expression();
      do {
        _expect('WHEN');
        _expression();
        _expect('THEN');
        _expression();
      } while (_current.syntax == 'WHEN');
      if (_take('ELSE')) _expression();
      _expect('END');
    } else if (_current.kind == _TokenKind.number ||
        _current.kind == _TokenKind.string ||
        _literalWords.contains(_current.syntax)) {
      _index++;
    } else {
      _columnOrFunction();
    }
  }

  void _projection() {
    final start = _index;
    _expression();
    final last = _tokens[_index - 1];
    final plainColumn =
        last.isIdentifier &&
        ((_index == start + 1 && !_literalWords.contains(last.syntax)) ||
            (_index == start + 3 && _tokens[start + 1].syntax == '.'));
    final name = _take('AS')
        ? _identifier()
        : (plainColumn ? last.identifier : null);
    if (name != null && !_aliases.add(name.toLowerCase())) {
      _fail(
        'Duplicate output name: $name. Give the columns different AS aliases.',
      );
    }
  }

  void _table() {
    var name = _identifier();
    var database = '';
    if (_take('.')) {
      database = name;
      name = _identifier();
    }
    // A bare table resolves to the connection's default world schema.
    final table = _catalog.tables
        .where((table) => table.database == database && table.name == name)
        .firstOrNull;
    if (table == null) {
      final qualified = database.isEmpty ? name : '$database.$name';
      _fail(
        'Table is outside the catalog: $qualified. Use its name from list_tables.',
      );
    }
    final alias =
        _take('AS') ||
            (_current.isIdentifier &&
                !_tableBoundaries.contains(_current.syntax))
        ? _identifier()
        : name;
    if (!table.isBaseTable) {
      _fail('Only catalog base tables are allowed in SQL.');
    }
    if (_tables.containsKey(alias)) _fail('Duplicate table alias: $alias.');
    _tables[alias] = table;
  }

  bool _take(String syntax) {
    if (_current.syntax != syntax) return false;
    _index++;
    return true;
  }

  static List<_Token> _tokenize(String sql) {
    final tokens = <_Token>[];
    var offset = 0;
    while (offset < sql.length) {
      final match = _lexeme.matchAsPrefix(sql, offset);
      if (match == null ||
          sql.startsWith('--', offset) ||
          sql.startsWith('/*', offset)) {
        throw FormatException(
          'Unsupported SQL token at character ${offset + 1}.',
        );
      }
      if (match[1] == null) {
        final kind = switch (match) {
          _ when match[2] != null => _TokenKind.word,
          _ when match[3] != null => _TokenKind.identifier,
          _ when match[4] != null => _TokenKind.string,
          _ when match[5] != null => _TokenKind.number,
          _ => _TokenKind.symbol,
        };
        tokens.add(_Token(kind, match[0]!, offset, match.end));
      }
      offset = match.end;
    }
    return [...tokens, _Token(_TokenKind.end, '', offset, offset)];
  }
}

final class _Token {
  final _TokenKind kind;
  final String text;
  final int start;
  final int end;

  const _Token(this.kind, this.text, this.start, this.end);

  String get identifier => kind == _TokenKind.identifier
      ? text.substring(1, text.length - 1).replaceAll('``', '`')
      : text;

  bool get isIdentifier =>
      kind == _TokenKind.word || kind == _TokenKind.identifier;

  String get syntax => switch (kind) {
    _TokenKind.word => text.toUpperCase(),
    _TokenKind.symbol => text,
    _ => '',
  };
}

enum _TokenKind { word, identifier, string, number, symbol, end }
