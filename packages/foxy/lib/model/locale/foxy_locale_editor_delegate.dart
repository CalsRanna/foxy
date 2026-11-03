import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/model/locale/database_locale_changes.dart';

/// Edit contract for regular database `*_locale` sub-tables: dynamic
/// language rows, addable/deletable.
final class DatabaseLocaleEditorDelegate extends FoxyLocaleEditorDelegate {
  /// Field names of the locale table (entity columns); the first is
  /// conventionally 'locale'.
  final List<String> fields;

  /// Display labels for the dialog's column headers; length matches
  /// [fields].
  final List<String> fieldLabels;

  /// Loads the locale data of the given entry.
  final Future<List<DatabaseLocaleRow>> Function(int entry) onLoad;

  /// Saves the locale changes of the given entry.
  final Future<void> Function(int entry, DatabaseLocaleChanges changes) onSave;

  const DatabaseLocaleEditorDelegate({
    required this.fields,
    required this.fieldLabels,
    required this.onLoad,
    required this.onSave,
  }) : assert(
         fields.length == fieldLabels.length,
         'fields and fieldLabels must have the same length',
       );
}

/// Locale editor for sub-tables keyed by a composite primary key (more than
/// one column besides `locale`).
///
/// Unlike [DatabaseLocaleEditorDelegate], the load/save closures receive the
/// full owning-record key instead of a single int, so the editor can target
/// rows such as `gossip_menu_option_locale` (MenuID + OptionID + Locale).
final class CompositeKeyLocaleEditorDelegate extends FoxyLocaleEditorDelegate {
  /// Field names of the locale table (entity columns); the first is
  /// conventionally 'locale'.
  final List<String> fields;

  /// Display labels for the dialog's column headers; length matches
  /// [fields].
  final List<String> fieldLabels;

  /// Loads the locale data of the given owning record.
  final Future<List<DatabaseLocaleRow>> Function(Object key) onLoad;

  /// Saves the locale changes of the given owning record.
  final Future<void> Function(Object key, DatabaseLocaleChanges changes) onSave;

  const CompositeKeyLocaleEditorDelegate({
    required this.fields,
    required this.fieldLabels,
    required this.onLoad,
    required this.onSave,
  }) : assert(
         fields.length == fieldLabels.length,
         'fields and fieldLabels must have the same length',
       );
}

/// Edit contract for DBC wide-table locale fields: fixed 16 rows,
/// partially updating the main record.
final class DbcLocaleFieldEditorDelegate extends FoxyLocaleEditorDelegate {
  final DbcLocaleFieldDefinition field;
  final Future<List<DbcLocaleFieldValue>> Function(int entry) onLoad;
  final Future<void> Function(int entry, List<DbcLocaleFieldValue> values)
  onSave;

  const DbcLocaleFieldEditorDelegate({
    required this.field,
    required this.onLoad,
    required this.onSave,
  });
}

/// Common abstraction for the locale-editor entry points.
///
/// Regular database locale sub-tables and DBC locstrings share the input +
/// globe-button entry, but use separate strongly-typed Delegates and editor
/// bodies, never stacking conditional branches inside one body.
sealed class FoxyLocaleEditorDelegate {
  const FoxyLocaleEditorDelegate();
}
