import 'package:flutter/material.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Common shell for settings-related dialogs (title + content + actions).
class SettingDialogShell extends StatelessWidget {
  // ─── Common shell ──────────────────────────────────────────────────────────

  final String title;

  final Widget child;

  final List<Widget> actions;

  final bool compact;

  const SettingDialogShell({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      titlePinned: true,
      constraints: compact
          ? DialogUtil.compactConstraints(context)
          : DialogUtil.constraints(context),
      actionsMainAxisSize: compact ? MainAxisSize.max : null,
      title: Text(title),
      actions: actions,
      child: child,
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
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
        ShadButton.outline(
          size: ShadButtonSize.sm,
          onPressed: enabled ? onBrowse : null,
          child: const Text('浏览'),
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
}
