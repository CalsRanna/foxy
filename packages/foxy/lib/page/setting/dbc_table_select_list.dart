import 'package:flutter/material.dart';
import 'package:foxy/page/setting/dbc_export_table_row.dart';
import 'package:foxy/view_model/workflow/dbc_export_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Table-picker list shared by the DBC-export and MPQ-export dialogs:
/// "文件 / 记录数" header, empty state, and one row per item.
class DbcTableSelectList extends StatelessWidget {
  final List<DbcExportItem> items;
  final ValueChanged<DbcExportItem> onToggle;

  /// Shown when [items] is empty (search with no hits vs. nothing at all).
  final String emptyText;

  const DbcTableSelectList({
    super.key,
    required this.items,
    required this.onToggle,
    this.emptyText = '没有可导出的表',
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: theme.colorScheme.muted.withValues(alpha: 0.35),
            child: Row(
              children: [
                const SizedBox(width: 28),
                Expanded(
                  child: Text(
                    '文件',
                    style: theme.textTheme.muted.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 96,
                  child: Text(
                    '记录数',
                    textAlign: TextAlign.end,
                    style: theme.textTheme.muted.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? Center(child: Text(emptyText, style: theme.textTheme.muted))
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      color: theme.colorScheme.border.withValues(alpha: 0.6),
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return DbcExportTableRow(
                        key: ValueKey(
                          '${item.tableName}:${item.selected}:${item.recordCountLabel}',
                        ),
                        item: item,
                        onChanged: (value) => onToggle(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
