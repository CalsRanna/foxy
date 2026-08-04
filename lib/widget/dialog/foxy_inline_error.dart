import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Inline dialog error notice, replacing [DialogUtil.error] inside
/// dialogs.
///
/// When an in-dialog operation (save, query, etc.) fails, show an inline
/// error, keeping the dialog state (inputs, filters, pagination) and not
/// closing itself. A null [message] renders an empty placeholder, so
/// callers need no null checks.
class FoxyInlineError extends StatelessWidget {
  final String? message;

  const FoxyInlineError({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    final theme = ShadTheme.of(context);
    return Container(
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
        message!,
        style: theme.textTheme.small.copyWith(
          color: theme.colorScheme.destructive,
        ),
      ),
    );
  }
}
