import 'package:flutter/material.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/widget/database_locale_changes.dart';
import 'package:foxy/widget/dbc_locale_field_editor.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_locale_crud_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Legacy name kept for compatibility.
typedef FoxyLocalePickerDelegate = DatabaseLocaleEditorDelegate;

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
         'fields 与 fieldLabels 长度必须一致',
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
         'fields 与 fieldLabels 长度必须一致',
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

/// Locale-field picker: ShadInput + globe button.
///
/// Dispatches by [delegate] type to [DatabaseLocaleEditor] or
/// [DbcLocaleFieldEditor]. The globe button is disabled for new records
/// (null [entry]).
class FoxyLocalePicker extends StatefulWidget {
  /// Primary key of the owning record; disables the globe button when
  /// null.
  final int? entry;

  /// Composite primary key of the owning record, for delegates keyed by
  /// more than one column ([CompositeKeyLocaleEditorDelegate]).
  ///
  /// When provided, the globe button is enabled even if [entry] is null,
  /// and the composite key (instead of [entry]) is passed to the delegate.
  final Object? ownerKey;

  /// Controller of the main input (held by the ViewModel; backfills the
  /// main-language value).
  final StringFieldController controller;

  /// Title of the locale-edit dialog.
  final String title;

  /// Placeholder of the main input.
  final String? placeholder;

  /// Data/persistence config.
  final FoxyLocaleEditorDelegate delegate;

  /// Callback after a successful DBC-field save, syncing the ViewModel
  /// Entity with the main-language Controller.
  ///
  /// Only called when [DbcLocaleFieldEditorDelegate] saves successfully.
  final void Function(List<DbcLocaleFieldValue> values)? onSaved;

  const FoxyLocalePicker({
    super.key,
    required this.entry,
    required this.controller,
    required this.title,
    required this.delegate,
    this.ownerKey,
    this.placeholder,
    this.onSaved,
  });

  @override
  State<FoxyLocalePicker> createState() => _FoxyLocalePickerState();
}

class _FoxyLocalePickerState extends State<FoxyLocalePicker> {
  @override
  Widget build(BuildContext context) {
    final canOpen = widget.entry != null || widget.ownerKey != null;
    return ShadInput(
      controller: widget.controller.controller,
      placeholder: Text(widget.placeholder ?? ''),
      trailing: ShadButton.ghost(
        height: 20,
        width: 20,
        padding: EdgeInsets.zero,
        enabled: canOpen,
        onPressed: canOpen ? _openLocaleDialog : null,
        child: Icon(LucideIcons.globe, size: 12),
      ),
    );
  }

  Future<void> _openLocaleDialog() async {
    final entry = widget.entry;
    final ownerKey = widget.ownerKey;
    if (entry == null && ownerKey == null) return;

    switch (widget.delegate) {
      case CompositeKeyLocaleEditorDelegate(
        :final fields,
        :final fieldLabels,
        :final onLoad,
        :final onSave,
      ):
        final owningKey = ownerKey;
        if (owningKey == null) return;
        await DatabaseLocaleEditor.show(
          context,
          title: widget.title,
          entry: 0,
          fields: fields,
          fieldLabels: fieldLabels,
          onLoad: () => onLoad(owningKey),
          onSave: (changes) => onSave(owningKey, changes),
        );
      case DatabaseLocaleEditorDelegate(
        :final fields,
        :final fieldLabels,
        :final onLoad,
        :final onSave,
      ):
        if (entry == null) return;
        await DatabaseLocaleEditor.show(
          context,
          title: widget.title,
          entry: entry,
          fields: fields,
          fieldLabels: fieldLabels,
          onLoad: () => onLoad(entry),
          onSave: (changes) => onSave(entry, changes),
        );
      case DbcLocaleFieldEditorDelegate(
        :final field,
        :final onLoad,
        :final onSave,
      ):
        if (entry == null) return;
        final saved = await DbcLocaleFieldEditor.show(
          context,
          title: widget.title,
          entry: entry,
          field: field,
          // Merge the main-input draft: avoids "main box edited but not
          // saved → dialog only changes other languages → old zhCN from the
          // DB is written back and wipes the main box".
          onLoad: () async {
            final loaded = await onLoad(entry);
            return loaded.withPrimaryDraft(widget.controller.collect());
          },
          onSave: (values) => onSave(entry, values),
        );
        if (saved != null) {
          widget.onSaved?.call(saved);
        }
    }
  }
}
