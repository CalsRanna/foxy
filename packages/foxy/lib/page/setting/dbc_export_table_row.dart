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
    final material = Theme.of(context);
    final failed = item.countFailed;
    final countColor = material.colorScheme.onSurface.withValues(alpha: 0.65);
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

    const padding = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final content = Row(
      children: [
        checkbox,
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            item.dbcFileName,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 13, color: nameColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 96,
          child: Text(
            failed ? '—' : item.recordCountLabel,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 12, color: countColor),
          ),
        ),
      ],
    );
    return Material(
      color: Colors.transparent,
      child: item.canSelect
          ? ShadButton.ghost(
              width: double.infinity,
              height: 0,
              expands: true,
              onPressed: () => onChanged(!item.selected),
              padding: padding,
              child: content,
            )
          : Padding(padding: padding, child: content),
    );
  }
}
