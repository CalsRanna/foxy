import 'package:flutter/material.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/model/locale/foxy_locale_editor_delegate.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/view_model/foxy_state_view_model.dart';
import 'package:foxy/widget/picker/locale/database_locale_editor.dart';
import 'package:foxy/widget/picker/locale/dbc_locale_field_editor.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

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
    return SignalBuilder(
      builder: (_) {
        final showLocaleButton =
            widget.delegate is DbcLocaleFieldEditorDelegate ||
            GetIt.instance.get<FoxyStateViewModel>().localeEnabled.value;
        final canOpen = widget.entry != null || widget.ownerKey != null;
        return ShadInput(
          controller: widget.controller.controller,
          placeholder: Text(widget.placeholder ?? ''),
          trailing: showLocaleButton
              ? ShadButton.ghost(
                  height: 20,
                  width: 20,
                  padding: EdgeInsets.zero,
                  enabled: canOpen,
                  onPressed: canOpen ? _openLocaleDialog : null,
                  child: Icon(LucideIcons.globe, size: 12),
                )
              : null,
        );
      },
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
