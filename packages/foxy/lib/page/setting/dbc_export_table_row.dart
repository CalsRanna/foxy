import 'package:flutter/material.dart';
import 'package:foxy/view_model/workflow/dbc_export_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DbcExportTableRow extends StatelessWidget {
  final DbcExportItem item;
  final ValueChanged<bool> onChanged;

  const DbcExportTableRow({
    super.key,
    required this.item,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final material = Theme.of(context);
    final failed = item.countFailed;
    final countColor = failed
        ? theme.colorScheme.destructive
        : material.colorScheme.onSurface.withValues(alpha: 0.65);
    final nameColor = failed
        ? material.colorScheme.onSurface.withValues(alpha: 0.55)
        : material.colorScheme.onSurface;

    // Use a controlled Checkbox so the shadcn component's internal state
    // never drifts from the external `selected`.
    final checkbox = Checkbox(
      value: item.selected,
      onChanged: item.canSelect ? (value) => onChanged(value ?? false) : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );

    final row = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.canSelect ? () => onChanged(!item.selected) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              checkbox,
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.dbcFileName,
                  style: TextStyle(fontSize: 13, color: nameColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (failed) ...[
                Icon(
                  LucideIcons.circleAlert,
                  size: 14,
                  color: theme.colorScheme.destructive,
                ),
                const SizedBox(width: 6),
              ],
              SizedBox(
                width: 96,
                child: Text(
                  item.recordCountLabel,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 12, color: countColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (!failed) return row;
    return Tooltip(
      message: item.countError ?? '行数统计失败',
      waitDuration: const Duration(milliseconds: 250),
      child: row,
    );
  }
}
