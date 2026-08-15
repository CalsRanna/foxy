import 'package:foxy/database/database.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/preferences/locale_query_settings.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

// Exported for generated parts: the repository .g.dart is `part of` the
// parent library and cannot import on its own; the generated code's
// FoxyException throw sites resolve through this file's import scope.
export 'package:foxy/infrastructure/errors/foxy_exceptions.dart';

mixin RepositoryMixin {
  final kPageSize = 50;
  Laconic get laconic => Database.instance.laconic;

  /// Whether to JOIN the `*_locale` tables to show localized names.
  ///
  /// Reads the infrastructure layer's locale-query setting; defaults to
  /// enabled when DI is not ready.
  bool get localeEnabled {
    try {
      return GetIt.instance.get<LocaleQuerySettings>().localeEnabled;
    } catch (_) {
      return true;
    }
  }

  /// Next primary-key sequence number: `MAX(column) + 1`, starting at `1`
  /// for empty tables.
  ///
  /// [table] is the table name (DBC may use the full `foxy.dbc_*` name).
  /// [column] is the primary-key column name (e.g. `ID` / `entry`).
  /// [where] is an optional scope condition for "child sequence under a
  /// parent key":
  /// `nextMaxPlusOne(_table, 'ID', where: {'CreatureID': creatureId})`。
  /// [firstValue] is the starting value returned when the scope has no
  /// records.
  ///
  /// Conventions:
  /// - [create*] calls this to prefill the primary key, **without
  ///   persisting**;
  /// - [store*] keeps the entity's key when `> 0`, otherwise takes the next
  ///   number.
  Future<int> nextMaxPlusOne(
    String table,
    String column, {
    Map<String, Object?> where = const {},
    int firstValue = 1,
  }) async {
    _assertIdentifier(table);
    _assertIdentifier(column);
    for (final entry in where.entries) {
      _assertIdentifier(entry.key);
    }
    var builder = laconic.table(table).select(['max(`$column`) as max_id']);
    for (final entry in where.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    final result = await builder.first();
    final raw = result.toMap()['max_id'];
    if (raw == null) return firstValue;
    final current = raw is int
        ? raw
        : raw is num
        ? raw.toInt()
        : (int.tryParse(raw.toString()) ?? 0);
    if (current >= 2147483647) {
      // MAX+1 overflows at the INT limit: persisting fails with 1264,
      // indistinguishable from the duplicate-key retry path; throw
      // IdExhaustedException explicitly so callers get a mappable message.
      throw IdExhaustedException('primary key exhausted: $table.$column');
    }
    return current + 1;
  }

  /// Wraps the physical column names from Entity `toJson()` in backtick
  /// identifiers for write statements.
  ///
  /// laconic does not escape identifiers; column names are spliced into SQL
  /// verbatim. With backticks added uniformly, MySQL reserved words like
  /// `index` and `rank` need no per-column whitelist.
  Map<String, dynamic> prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        '`${_assertIdentifier(entry.key)}`': entry.value,
    };
  }

  /// Defensive identifier whitelist: identifiers are spliced verbatim into
  /// SQL (laconic does not escape them), so anything that flows into
  /// [nextMaxPlusOne] / [prepareWriteJson] must be a plain identifier.
  /// Allowed: dotted chains (`foxy.dbc_x`) of plain identifier segments,
  /// each optionally wrapped in a *complete* pair of backticks (the
  /// generated code passes `` `id` `` via `_column`). Quotes, whitespace and
  /// the SQL-breaking characters are rejected; a backtick can never appear
  /// mid-segment. All current call sites pass code constants; this guards
  /// against future user-controlled columns/tables.
  String _assertIdentifier(String identifier) {
    if (!identifier.split('.').every(_identifierSegment.hasMatch)) {
      throw ArgumentError.value(
        identifier,
        'identifier',
        'expected dotted [A-Za-z_][A-Za-z0-9_]* segments, each optionally '
            'wrapped in one pair of backticks',
      );
    }
    return identifier;
  }

  static final _identifierSegment = RegExp(r'^`?[A-Za-z_][A-Za-z0-9_]*`?$');
}
