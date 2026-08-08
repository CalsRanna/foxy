import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Uniform dialog max width (consistent across the project).
const kDialogWidth = 720.0;

/// Dialog max height = screen height × this ratio.
const kFoxyDialogMaxHeightRatio = 0.8;

/// Uniform dialog constraints: maxWidth fixed to [kDialogWidth],
/// maxHeight by screen ratio.
///
/// Every business dialog's [ShadDialog.constraints] should use this
/// function, keeping width and max height consistent project-wide.
BoxConstraints foxyDialogConstraints(BuildContext context) {
  return BoxConstraints(
    maxWidth: kDialogWidth,
    maxHeight: MediaQuery.of(context).size.height * kFoxyDialogMaxHeightRatio,
  );
}

/// Foxy dialog entry point, wrapping [showShadDialog] with the project's
/// default behavior.
///
/// ## Differences from [showShadDialog]
/// - **`opaque` defaults to `false`**: keeps the page below visible, the
///   barrier being a mere translucent overlay. `shadcn_ui` 0.55+ changed
///   the default to `true`, which stops the whole background from drawing
///   — looking like "black screen + dialog only".
///
/// Business code should call this function instead of [showShadDialog]
/// directly.
Future<T?> showFoxyDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color barrierColor = const Color(0xcc000000),
  String barrierLabel = '',
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  ShadDialogVariant variant = ShadDialogVariant.primary,

  /// Whether the route below is obscured. Foxy defaults to `false` (see
  /// the function docs).
  bool opaque = false,
}) {
  return showShadDialog<T>(
    context: context,
    builder: builder,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    variant: variant,
    opaque: opaque,
  );
}

class DialogUtil {
  static final DialogUtil instance = DialogUtil._();

  DialogUtil._();

  /// Shows a blocking notice dialog; returns after the user clicks "OK".
  ///
  /// Does not implicitly pop the stack top; callers should close temporary
  /// dialogs such as loading first.
  Future<void> alert({required String title, required String message}) async {
    final context = router.navigatorKey.currentContext!;
    if (!context.mounted) return;

    await showFoxyDialog<void>(
      context: context,
      builder: (context) {
        return ShadDialog.alert(
          title: Text(title),
          description: Text(message),
          constraints: foxyDialogConstraints(context),
          actions: [
            ShadButton(
              child: const Text('确定'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<bool> confirm({
    required String title,
    String? description,
    String confirmText = '确认',
    String cancelText = '取消',
    bool destructive = false,
  }) async {
    final context = router.navigatorKey.currentContext!;
    final result = await showFoxyDialog<bool>(
      context: context,
      builder: (context) {
        return ShadDialog.alert(
          title: Text(title),
          description: description != null ? Text(description) : null,
          constraints: foxyDialogConstraints(context),
          actions: [
            ShadButton.outline(
              child: Text(cancelText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            if (destructive)
              ShadButton.destructive(
                child: Text(confirmText),
                onPressed: () => Navigator.of(context).pop(true),
              )
            else
              ShadButton(
                child: Text(confirmText),
                onPressed: () => Navigator.of(context).pop(true),
              ),
          ],
        );
      },
    );
    return result ?? false;
  }

  Future<void> dismiss() async {
    await Navigator.maybePop(router.navigatorKey.currentContext!);
  }

  void dismissAll() {
    final context = router.navigatorKey.currentContext!;
    if (!context.mounted) return;
    // Only close dialog routes (PopupRoute), never pop a business page.
    while (Navigator.of(context).canPop()) {
      final route = ModalRoute.of(context);
      if (route is! PopupRoute) break;
      Navigator.of(context).pop();
    }
  }

  void error(String error) {
    final context = router.navigatorKey.currentContext!;
    if (!context.mounted) return;

    // Do not implicitly pop the stack top: if callers stacked dialogs such
    // as loading, they should dismiss explicitly first, so a real page is
    // never popped by accident (historically an unconditional pop flung the
    // list page out).
    showFoxyDialog(
      context: context,
      builder: (context) {
        return ShadDialog.alert(
          title: Text('错误'),
          description: Text(error),
          constraints: foxyDialogConstraints(context),
          actions: [
            ShadButton(
              child: Text('确定'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void loading() {
    final context = router.navigatorKey.currentContext!;
    showFoxyDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const ShadDialog(
          closeIcon: SizedBox.shrink(),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SizedBox.square(
              dimension: 28,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ),
        );
      },
    );
  }

  void success(String message) {
    final context = router.navigatorKey.currentContext!;
    ShadSonner.of(context).show(ShadToast(description: Text(message)));
  }
}
