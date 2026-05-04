import 'package:flutter/material.dart';
import 'package:foxy/widget/locale_crud_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class LocaleCrudDialog extends StatelessWidget {
  final String title;
  final int entry;
  final LocaleCrudViewModel vm;

  const LocaleCrudDialog({
    super.key,
    required this.title,
    required this.entry,
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return _buildDialog(context);
  }

  Future<bool?> show(BuildContext context) {
    return showShadDialog<bool>(
      context: context,
      builder: (context) {
        vm.load();
        return _buildDialog(context);
      },
    );
  }

  Widget _buildDialog(BuildContext dialogContext) {
    final theme = ShadTheme.of(dialogContext);
    return ShadDialog(
      title: Text(title),
      description: Text('编号: $entry'),
      constraints: BoxConstraints(maxWidth: 720),
      actions: [
        ShadButton.outline(
          onPressed: () => vm.addRow(),
          child: Text('添加'),
        ),
        const Spacer(),
        ShadButton.outline(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text('取消'),
        ),
        Watch((_) {
          final saving = vm.saving.value;
          return ShadButton(
            onPressed: saving ? null : () async {
              await vm.save();
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
            },
            child: saving ? Text('保存中...') : Text('保存'),
          );
        }),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(theme),
          Flexible(child: _buildTable(dialogContext)),
        ],
      ),
    );
  }

  Widget _buildHeader(ShadThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.border)),
      ),
      child: Row(
        children: [
          for (var label in vm.fieldLabels)
            Expanded(
              child: Text(label, style: theme.textTheme.muted),
            ),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext dialogContext) {
    return Watch((_) {
      final rows = vm.rows.value;
      if (rows.isEmpty) {
        return Padding(
          padding: EdgeInsets.all(32),
          child: Text('暂无多语言数据，点击添加按钮新增'),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              spacing: 16,
              children: [
                for (var c in row.controllers)
                  Expanded(
                    child: ShadInput(controller: c),
                  ),
                SizedBox(
                  width: 40,
                  child: ShadButton.ghost(
                    padding: EdgeInsets.zero,
                    onPressed: () => vm.removeRow(index),
                    size: ShadButtonSize.sm,
                    child: Icon(LucideIcons.trash, size: 16),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
