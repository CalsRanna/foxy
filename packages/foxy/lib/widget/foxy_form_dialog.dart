import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Uniform shell for business form dialogs (sub-table create/edit).
///
/// Every sub-table dialog previously hand-rolled a [ShadDialog] with
/// `titlePinned`, `descriptionPinned` and `DialogUtil.constraints` — this
/// widget keeps those three behaviors in one place. Use it as the
/// `builder` result of [DialogUtil.show].
class FoxyFormDialog extends StatelessWidget {
  final String title;
  final String? description;

  /// Dialog footer, rendered by [ShadDialog.actions]: right-aligned, pinned
  /// to the bottom while the content scrolls.
  ///
  /// Footer buttons belong here rather than at the end of [child], which
  /// scrolls out of view on long forms. Order is cancel first, primary
  /// action last; [saveActions] builds the common pair.
  final List<Widget> actions;
  final Widget child;

  const FoxyFormDialog({
    super.key,
    required this.title,
    this.description,
    this.actions = const [],
    required this.child,
  });

  /// Footer for the standard "cancel + save" sub-table dialog.
  ///
  /// Reports failures through [DialogUtil.error] and closes with a success
  /// toast, so every sub-table dialog ends the same way instead of each
  /// view re-implementing the try/catch/pop sequence.
  ///
  /// A failed save is reported even when the dialog was dismissed while it
  /// ran: the write did fail, and a silently swallowed error would leave
  /// the user believing it succeeded.
  static List<Widget> saveActions({
    /// Context of the dialog itself; used to close it.
    required BuildContext context,
    required ReadonlySignal<bool> submitting,
    required Future<void> Function() onSubmit,
    bool editing = false,
  }) {
    return [
      ShadButton.outline(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('取消'),
      ),
      Watch(
        (_) => ShadButton(
          enabled: !submitting.value,
          onPressed: () async {
            try {
              await onSubmit();
            } catch (error) {
              DialogUtil.instance.error(
                '保存失败：${FoxyExceptions.message(error)}',
              );
              return;
            }
            if (!context.mounted) return;
            DialogUtil.instance.success('保存成功');
            Navigator.of(context).pop();
          },
          child: Text(editing ? '更新' : '保存'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(title),
      description: description != null ? Text(description!) : null,
      titlePinned: true,
      descriptionPinned: true,
      constraints: DialogUtil.constraints(context),
      actions: actions,
      child: child,
    );
  }
}
