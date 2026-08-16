import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Uniform shell for business form dialogs (sub-table create/edit).
///
/// Every sub-table dialog previously hand-rolled a [ShadDialog] with
/// `titlePinned`, `descriptionPinned` and `DialogUtil.constraints` — this
/// widget keeps those three behaviors in one place. Use it as the
/// `builder` result of [DialogUtil.show].
class FoxyFormDialog extends StatelessWidget {
  final String title;
  final String? description;
  final Widget child;

  const FoxyFormDialog({
    super.key,
    required this.title,
    this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(title),
      description: description != null ? Text(description!) : null,
      titlePinned: true,
      descriptionPinned: true,
      constraints: DialogUtil.constraints(context),
      child: child,
    );
  }
}
