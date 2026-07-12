import 'package:flutter/material.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// DBC 单字段本地化编辑器：固定 16 行「语言编号 + 当前字段」。
///
/// 不提供添加/删除语言，不允许修改语言编号，允许清空字段值。
class DbcLocaleFieldEditor extends StatefulWidget {
  final String title;
  final int entry;
  final DbcLocaleFieldDefinition field;
  final List<DbcLocaleFieldValue> initialValues;
  final Future<void> Function(List<DbcLocaleFieldValue> values) onSave;

  const DbcLocaleFieldEditor({
    super.key,
    required this.title,
    required this.entry,
    required this.field,
    required this.initialValues,
    required this.onSave,
  });

  /// 弹出 DBC 字段本地化编辑对话框。
  ///
  /// 保存成功返回编辑后的 16 行值；取消或加载失败返回 null。
  static Future<List<DbcLocaleFieldValue>?> show(
    BuildContext context, {
    required String title,
    required int entry,
    required DbcLocaleFieldDefinition field,
    required Future<List<DbcLocaleFieldValue>> Function() onLoad,
    required Future<void> Function(List<DbcLocaleFieldValue> values) onSave,
  }) async {
    late final List<DbcLocaleFieldValue> values;
    try {
      values = await onLoad();
    } catch (e, s) {
      LoggerUtil.instance.e('加载 DBC 本地化失败: $title', error: e, stackTrace: s);
      if (!context.mounted) return null;
      _showErrorToast(context, '加载失败: $e');
      return null;
    }
    if (!context.mounted) return null;
    return showFoxyDialog<List<DbcLocaleFieldValue>>(
      context: context,
      builder: (_) => DbcLocaleFieldEditor(
        title: title,
        entry: entry,
        field: field,
        initialValues: values,
        onSave: onSave,
      ),
    );
  }

  static void _showErrorToast(BuildContext context, String message) {
    try {
      ShadSonner.of(context).show(ShadToast(description: Text(message)));
    } catch (_) {
      // 测试或无 Sonner 宿主时忽略，避免二次异常掩盖原始错误。
    }
  }

  @override
  State<DbcLocaleFieldEditor> createState() => _DbcLocaleFieldEditorState();
}

class _DbcLocaleFieldEditorState extends State<DbcLocaleFieldEditor> {
  late final List<TextEditingController> _controllers;
  bool _saving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    assert(
      widget.initialValues.length == DbcLocale.values.length,
      'DBC locale editor 必须固定 16 行',
    );
    _controllers = [
      for (final item in widget.initialValues)
        TextEditingController(text: item.value),
    ];
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _errorMessage = null;
    });
    try {
      final values = [
        for (var i = 0; i < DbcLocale.values.length; i++)
          DbcLocaleFieldValue(
            locale: DbcLocale.values[i],
            value: _controllers[i].text,
          ),
      ];
      await widget.onSave(values);
      if (mounted) {
        Navigator.of(context).pop(values);
      }
    } catch (e, s) {
      LoggerUtil.instance.e(
        '保存 DBC 本地化失败: ${widget.title}',
        error: e,
        stackTrace: s,
      );
      if (!mounted) return;
      setState(() => _errorMessage = '保存失败: $e');
      DbcLocaleFieldEditor._showErrorToast(context, '保存失败: $e');
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final multiline = widget.field.multiline;
    return ShadDialog(
      title: Text(widget.title),
      description: Text('编号: ${widget.entry}'),
      constraints: BoxConstraints(
        maxWidth: multiline ? 800 : 640,
        maxHeight: 560,
      ),
      actions: [
        ShadButton.outline(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
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
          Flexible(child: _buildTable(theme)),
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
          SizedBox(
            width: 120,
            child: Text('语言编号', style: theme.textTheme.muted),
          ),
          Expanded(
            child: Text(widget.field.label, style: theme.textTheme.muted),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(ShadThemeData theme) {
    final multiline = widget.field.multiline;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: DbcLocale.values.length,
      itemBuilder: (context, index) {
        final locale = DbcLocale.values[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: multiline
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            spacing: 16,
            children: [
              SizedBox(
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(top: multiline ? 8 : 0),
                  child: Text(locale.displayCode, style: theme.textTheme.small),
                ),
              ),
              Expanded(
                child: ShadInput(
                  controller: _controllers[index],
                  maxLines: multiline ? 4 : 1,
                  minLines: multiline ? 2 : 1,
                  placeholder: Text(locale.label),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
