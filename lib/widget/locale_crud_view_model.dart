import 'package:flutter/widgets.dart';
import 'package:signals/signals.dart';

class LocaleCrudRow {
  final List<TextEditingController> controllers;

  LocaleCrudRow(List<String> values)
    : controllers = values.map((v) => TextEditingController(text: v)).toList();

  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
  }
}

class LocaleCrudViewModel {
  final int entry;
  final List<String> fields;
  final List<String> fieldLabels;
  final Future<List<Map<String, dynamic>>> Function(int entry) onLoad;
  final Future<void> Function(int entry, List<Map<String, dynamic>>) onSave;

  final rows = signal<List<LocaleCrudRow>>([]);
  final saving = signal(false);
  final loading = signal(false);

  LocaleCrudViewModel({
    required this.entry,
    required this.fields,
    required this.fieldLabels,
    required this.onLoad,
    required this.onSave,
  });

  Future<void> load() async {
    loading.value = true;
    try {
      final jsonList = await onLoad(entry);
      rows.value = jsonList.map((json) {
        return LocaleCrudRow(fields.map((f) => (json[f] ?? '').toString()).toList());
      }).toList();
    } catch (_) {
      rows.value = [];
    } finally {
      loading.value = false;
    }
  }

  void addRow() {
    rows.value = [...rows.value, LocaleCrudRow(fields.map((_) => '').toList())];
  }

  void removeRow(int index) {
    if (index < 0 || index >= rows.value.length) return;
    final old = rows.value;
    old[index].dispose();
    rows.value = [...old]..removeAt(index);
  }

  Future<void> save() async {
    saving.value = true;
    try {
      final data = rows.value.map((r) {
        final map = <String, dynamic>{};
        for (var i = 0; i < fields.length; i++) {
          map[fields[i]] = r.controllers[i].text;
        }
        return map;
      }).toList();
      await onSave(entry, data);
    } finally {
      saving.value = false;
    }
  }

  void dispose() {
    for (var r in rows.value) {
      r.dispose();
    }
  }
}
