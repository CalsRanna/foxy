import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';

final class ActivityFieldChange {
  final Object? before;
  final Object? after;

  const ActivityFieldChange(this.before, this.after);

  factory ActivityFieldChange.fromJson(Map<String, Object?> json) =>
      ActivityFieldChange(json['before'], json['after']);

  Map<String, Object?> toJson() => {'before': before, 'after': after};
}

/// Collects the row writes belonging to one user action.
final class ActivityLogCapture {
  static const _zoneKey = #activityLogCapture;
  static const _equality = DeepCollectionEquality();

  static ActivityLogCapture? get current =>
      Zone.current[_zoneKey] as ActivityLogCapture?;
  final _rows = <ActivityRowChange>[];
  final Map<String, Object?>? _sourceKey;

  bool _observedWrite = false;

  ActivityLogCapture._(this._sourceKey);

  ActivityLogDetails? get details => _rows.isEmpty && _sourceKey == null
      ? null
      : ActivityLogDetails(List.unmodifiable(_rows), sourceKey: _sourceKey);

  bool get isUnchanged => _observedWrite && _rows.isEmpty;

  void record({
    required String table,
    required Map<String, Object?>? beforeKey,
    required Map<String, Object?>? afterKey,
    Map<String, Object?>? before,
    Map<String, Object?>? after,
    Iterable<String> columns = const [],
  }) {
    _observedWrite = true;
    var oldKey = beforeKey;
    var newKey = afterKey;
    final changes = <String, ActivityFieldChange>{};
    if (before != null &&
        after != null &&
        beforeKey != null &&
        afterKey != null) {
      final oldColumns = before.map(
        (column, value) => MapEntry(column.toLowerCase(), value),
      );
      final newColumns = after.map(
        (column, value) => MapEntry(column.toLowerCase(), value),
      );
      oldKey = _keyFromRow(beforeKey, oldColumns);
      newKey = _keyFromRow(afterKey, newColumns);
      for (final column in columns) {
        final oldValue = oldColumns[column.toLowerCase()];
        final newValue = newColumns[column.toLowerCase()];
        if (!_equality.equals(oldValue, newValue)) {
          changes[column] = ActivityFieldChange(oldValue, newValue);
        }
      }
      if (changes.isEmpty && _equality.equals(oldKey, newKey)) return;
    }
    _rows.add(
      ActivityRowChange(
        table: table,
        beforeKey: oldKey,
        afterKey: newKey,
        changes: changes,
      ),
    );
  }

  static Future<T> run<T>(
    Future<T> Function() action, {
    Map<String, Object?>? sourceKey,
  }) =>
      runZoned(action, zoneValues: {_zoneKey: ActivityLogCapture._(sourceKey)});

  static Map<String, Object?> _keyFromRow(
    Map<String, Object?> key,
    Map<String, Object?> row,
  ) => key.map((column, value) {
    final name = column.toLowerCase();
    return MapEntry(column, row.containsKey(name) ? row[name] : value);
  });
}

final class ActivityLogDetails {
  final List<ActivityRowChange> rows;
  final Map<String, Object?>? sourceKey;

  const ActivityLogDetails(this.rows, {this.sourceKey});

  factory ActivityLogDetails.fromJson(String value) {
    final json = jsonDecode(value) as Map<String, Object?>;
    final rows = json['rows'] as List<Object?>;
    return ActivityLogDetails(
      rows
          .map((row) => ActivityRowChange.fromJson(row as Map<String, Object?>))
          .toList(),
      sourceKey: json['source_key'] as Map<String, Object?>?,
    );
  }

  int get fieldCount =>
      rows.fold(0, (count, row) => count + row.changes.length);

  String toJson() => jsonEncode({
    if (sourceKey != null) 'source_key': sourceKey,
    'rows': rows.map((row) => row.toJson()).toList(),
  }, toEncodable: _encodeValue);

  static String _encodeValue(Object? value) => switch (value) {
    final DateTime date => date.toIso8601String(),
    _ => '$value',
  };
}

final class ActivityRowChange {
  final String table;
  final Map<String, Object?>? beforeKey;
  final Map<String, Object?>? afterKey;
  final Map<String, ActivityFieldChange> changes;

  const ActivityRowChange({
    required this.table,
    required this.beforeKey,
    required this.afterKey,
    this.changes = const {},
  });

  factory ActivityRowChange.fromJson(Map<String, Object?> json) {
    final changes = json['changes'] as Map<String, Object?>;
    return ActivityRowChange(
      table: json['table'] as String,
      beforeKey: json['before_key'] as Map<String, Object?>?,
      afterKey: json['after_key'] as Map<String, Object?>?,
      changes: changes.map(
        (column, value) => MapEntry(
          column,
          ActivityFieldChange.fromJson(value as Map<String, Object?>),
        ),
      ),
    );
  }

  Map<String, Object?> toJson() => {
    'table': table,
    if (beforeKey != null) 'before_key': beforeKey,
    if (afterKey != null) 'after_key': afterKey,
    'changes': changes.map(
      (column, change) => MapEntry(column, change.toJson()),
    ),
  };
}
