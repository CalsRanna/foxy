import 'package:flutter/material.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_loading_indicator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Common shell for settings-related dialogs (title + content + actions).
class SettingDialogShell extends StatelessWidget {
  // ─── Common shell ──────────────────────────────────────────────────────────

  /// Result banner (success/error/warning, with color and icon).
  static Widget banner(
    BuildContext context, {
    required String text,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          if (icon != null) Icon(icon, size: 16, color: color),
          Expanded(
            child: SelectableText(
              text,
              style: TextStyle(fontSize: 13, color: color, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  /// Muted hint text.
  static Widget mutedHint(BuildContext context, String text) {
    final theme = ShadTheme.of(context);
    return Text(text, style: theme.textTheme.muted.copyWith(fontSize: 13));
  }

  /// Path input row (input box + browse button).
  static Widget pathField({
    required StringFieldController controller,
    required String placeholder,
    required VoidCallback onBrowse,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool enabled = true,
  }) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: ShadInput(
            controller: controller.controller,
            placeholder: Text(placeholder),
            enabled: enabled,
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(LucideIcons.folderSearch, size: 16),
            ),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
        ShadButton.outline(
          size: ShadButtonSize.sm,
          onPressed: enabled ? onBrowse : null,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [Icon(LucideIcons.folderOpen, size: 15), Text('浏览')],
          ),
        ),
      ],
    );
  }

  /// Progress panel (ratio bar or spinner + label + details).
  static Widget progressPanel(
    BuildContext context, {
    required double? ratio,
    required String label,
    required String detail,
    String idleText = '正在准备...',
    Widget? trailing,
  }) {
    final theme = ShadTheme.of(context);
    final muted = theme.textTheme.muted.copyWith(fontSize: 12);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        if (ratio != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('进度', style: muted),
              Text(
                '${(ratio * 100).clamp(0, 100).toStringAsFixed(0)}%',
                style: muted,
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: ratio, minHeight: 8),
          ),
        ] else
          const Center(child: FoxyLoadingIndicator(size: 28, strokeWidth: 2.5)),
        if (label.isNotEmpty)
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        if (detail.isNotEmpty) Text(detail, style: muted),
        if (ratio == null && label.isEmpty) Text(idleText, style: muted),
        if (trailing != null)
          Align(alignment: Alignment.centerRight, child: trailing),
      ],
    );
  }

  /// Read-only path display box (directory config comes from the settings
  /// page; action dialogs no longer edit it directly).
  static Widget readonlyPath(BuildContext context, String path) {
    final theme = ShadTheme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.border),
      ),
      child: Row(
        spacing: 8,
        children: [
          Icon(
            LucideIcons.folder,
            size: 15,
            color: theme.colorScheme.mutedForeground,
          ),
          Expanded(
            child: SelectableText(path, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  /// Dialog title row (icon + text).
  static Widget titleRow(IconData icon, String text, {Color? iconColor}) {
    return Row(
      spacing: 10,
      children: [
        Icon(icon, size: 20, color: iconColor),
        Text(text),
      ],
    );
  }

  final Widget title;
  final Widget child;
  final List<Widget> actions;

  const SettingDialogShell({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      titlePinned: true,
      constraints: DialogUtil.constraints(context),
      title: title,
      actions: actions,
      child: child,
    );
  }
}
