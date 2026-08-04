import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/widget/database_locale_changes.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 兼容旧名称。
typedef FoxyLocaleCrudDialog = DatabaseLocaleEditor;

/// 普通数据库 `*_locale` 分表的动态行编辑器。
///
/// 单字段两列表格：第一列语言、第二列该字段的值。支持按实际数据添加和删除
/// locale 行；`fields` 固定为 `['locale', <字段名>]`。
class DatabaseLocaleEditor extends StatefulWidget {
  final String title;
  final int entry;
  final List<String> fields;
  final List<String> fieldLabels;
  final List<DatabaseLocaleRow> initialRows;
  final Future<void> Function(DatabaseLocaleChanges changes) onSave;

  const DatabaseLocaleEditor({
    super.key,
    required this.title,
    required this.entry,
    required this.fields,
    required this.fieldLabels,
    required this.initialRows,
    required this.onSave,
  }) : assert(
         fields.length == fieldLabels.length,
         'fields 与 fieldLabels 长度必须一致',
       ),
       assert(
         fields.length == 2,
         'DatabaseLocaleEditor 仅支持两列：语言 + 单字段',
       );

  @override
  State<DatabaseLocaleEditor> createState() => _DatabaseLocaleEditorState();

  /// 弹出多语言编辑对话框。
  ///
  /// [onLoad] 返回带原始 locale 身份的已有行。
  /// [onSave] 接收显式行变更，由调用方负责转成领域强类型 Key 并持久化。
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required int entry,
    required List<String> fields,
    required List<String> fieldLabels,
    required Future<List<DatabaseLocaleRow>> Function() onLoad,
    required Future<void> Function(DatabaseLocaleChanges changes) onSave,
  }) async {
    late final List<DatabaseLocaleRow> loadedRows;
    try {
      loadedRows = await onLoad();
    } catch (e, s) {
      LoggerUtil.instance.e('加载多语言失败: $title', error: e, stackTrace: s);
      if (!context.mounted) return null;
      try {
        ShadSonner.of(context).show(
          ShadToast(description: Text('加载失败: ${foxyErrorMessage(e)}')),
        );
      } catch (_) {}
      return null;
    }
    if (!context.mounted) return null;
    return showFoxyDialog<bool>(
      context: context,
      builder: (_) => DatabaseLocaleEditor(
        title: title,
        entry: entry,
        fields: fields,
        fieldLabels: fieldLabels,
        initialRows: loadedRows,
        onSave: onSave,
      ),
    );
  }
}

final class _DatabaseLocaleEditingRow {
  final String? originalLocale;
  final List<TextEditingController> controllers;

  _DatabaseLocaleEditingRow({
    required this.originalLocale,
    required this.controllers,
  });

  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
  }
}

class _DatabaseLocaleEditorState extends State<DatabaseLocaleEditor> {
  late List<_DatabaseLocaleEditingRow> _rows;
  late Set<String> _initialLocales;
  bool _saving = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadDialog(
      title: Text(widget.title),
      scrollable: false,
      titlePinned: true,
      constraints: foxyDialogConstraints(context),
      actions: [
        ShadButton.outline(onPressed: _addRow, child: const Text('添加')),
        const Spacer(),
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ShadButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? '保存中...' : '保存'),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FoxyInlineError(message: _errorMessage),
          _buildHeader(theme),
          Flexible(child: _buildTable()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialLocales = widget.initialRows
        .map((row) => row.originalLocale)
        .whereType<String>()
        .toSet();
    _rows = widget.initialRows.map((row) {
      return _DatabaseLocaleEditingRow(
        originalLocale: row.originalLocale,
        controllers: widget.fields
            .map(
              (field) => TextEditingController(text: row.values[field] ?? ''),
            )
            .toList(),
      );
    }).toList();
  }

  void _addRow() {
    setState(() {
      _rows.add(
        _DatabaseLocaleEditingRow(
          originalLocale: null,
          controllers: widget.fields
              .map((_) => TextEditingController())
              .toList(),
        ),
      );
    });
  }

  Widget _buildHeader(ShadThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.border)),
      ),
      child: Row(
        spacing: 16,
        children: [
          for (var label in widget.fieldLabels)
            Expanded(child: Text(label, style: theme.textTheme.muted)),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildTable() {
    if (_rows.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Text('暂无多语言数据，点击添加按钮新增'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _rows.length,
      itemBuilder: (context, index) {
        final row = _rows[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            spacing: 16,
            children: [
              for (var c in row.controllers)
                Expanded(child: ShadInput(controller: c)),
              SizedBox(
                width: 40,
                child: ShadButton.ghost(
                  padding: EdgeInsets.zero,
                  onPressed: () => _removeRow(index),
                  size: ShadButtonSize.sm,
                  child: const Icon(LucideIcons.trash, size: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeRow(int index) {
    setState(() {
      _rows[index].dispose();
      _rows.removeAt(index);
    });
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _errorMessage = null;
    });
    try {
      final rows = _rows.map((row) {
        final map = <String, String>{};
        for (var i = 0; i < widget.fields.length; i++) {
          map[widget.fields[i]] = row.controllers[i].text;
        }
        return DatabaseLocaleRow(
          originalLocale: row.originalLocale,
          values: Map.unmodifiable(map),
        );
      }).toList();
      final retainedLocales = rows
          .map((row) => row.originalLocale)
          .whereType<String>()
          .toSet();
      final changes = DatabaseLocaleChanges(
        rows: List.unmodifiable(rows),
        deletedLocales: List.unmodifiable(
          _initialLocales.difference(retainedLocales),
        ),
      );
      await widget.onSave(changes);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e, s) {
      LoggerUtil.instance.e(
        '保存多语言失败: ${widget.title}',
        error: e,
        stackTrace: s,
      );
      if (!mounted) return;
      setState(() => _errorMessage = '保存失败: ${foxyErrorMessage(e)}');
      try {
        ShadSonner.of(context).show(
          ShadToast(description: Text('保存失败: ${foxyErrorMessage(e)}')),
        );
      } catch (_) {}
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }
}
