import 'package:flutter/material.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 普通数据库 `*_locale` 分表的动态行编辑器。
///
/// 支持按实际数据添加和删除 locale 行。
class DatabaseLocaleEditor extends StatefulWidget {
  final String title;
  final int entry;
  final List<String> fields;
  final List<String> fieldLabels;
  final List<List<String>> initialRows;
  final Future<void> Function(List<Map<String, String>> data) onSave;

  const DatabaseLocaleEditor({
    super.key,
    required this.title,
    required this.entry,
    required this.fields,
    required this.fieldLabels,
    required this.initialRows,
    required this.onSave,
  });

  /// 弹出多语言编辑对话框。
  ///
  /// [onLoad] 返回已有的多语言数据（List<Map>）。
  /// [onSave] 接收编辑后的数据，由调用方负责持久化。
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required int entry,
    required List<String> fields,
    required List<String> fieldLabels,
    required Future<List<Map<String, String>>> Function() onLoad,
    required Future<void> Function(List<Map<String, String>> data) onSave,
  }) async {
    late final List<Map<String, String>> jsonList;
    try {
      jsonList = await onLoad();
    } catch (e, s) {
      LoggerUtil.instance.e('加载多语言失败: $title', error: e, stackTrace: s);
      if (!context.mounted) return null;
      try {
        ShadSonner.of(context).show(
          ShadToast(description: Text('加载失败: $e')),
        );
      } catch (_) {}
      return null;
    }
    if (!context.mounted) return null;
    final initialRows = jsonList.map((json) {
      return fields.map((f) => json[f] ?? '').toList();
    }).toList();
    return showShadDialog<bool>(
      context: context,
      builder: (_) => DatabaseLocaleEditor(
        title: title,
        entry: entry,
        fields: fields,
        fieldLabels: fieldLabels,
        initialRows: initialRows,
        onSave: onSave,
      ),
    );
  }

  @override
  State<DatabaseLocaleEditor> createState() => _DatabaseLocaleEditorState();
}

/// 兼容旧名称。
typedef FoxyLocaleCrudDialog = DatabaseLocaleEditor;

class _DatabaseLocaleEditorState extends State<DatabaseLocaleEditor> {
  late List<List<TextEditingController>> _rows;
  bool _saving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _rows = widget.initialRows.map((row) {
      return row.map((v) => TextEditingController(text: v)).toList();
    }).toList();
  }

  @override
  void dispose() {
    for (var row in _rows) {
      for (var c in row) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void _addRow() {
    setState(() {
      _rows.add(widget.fields.map((_) => TextEditingController()).toList());
    });
  }

  void _removeRow(int index) {
    setState(() {
      for (var c in _rows[index]) {
        c.dispose();
      }
      _rows.removeAt(index);
    });
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _errorMessage = null;
    });
    try {
      final data = _rows.map((row) {
        final map = <String, String>{};
        for (var i = 0; i < widget.fields.length; i++) {
          map[widget.fields[i]] = row[i].text;
        }
        return map;
      }).toList();
      await widget.onSave(data);
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
      setState(() => _errorMessage = '保存失败: $e');
      try {
        ShadSonner.of(context).show(
          ShadToast(description: Text('保存失败: $e')),
        );
      } catch (_) {}
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadDialog(
      title: Text(widget.title),
      description: Text('编号: ${widget.entry}'),
      constraints: const BoxConstraints(maxWidth: 720),
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
          if (_errorMessage != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.destructive.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: theme.colorScheme.destructive.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                _errorMessage!,
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.destructive,
                ),
              ),
            ),
          ],
          _buildHeader(theme),
          Flexible(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildHeader(ShadThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.border)),
      ),
      child: Row(
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
              for (var c in row) Expanded(child: ShadInput(controller: c)),
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
}
