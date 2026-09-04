import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/widget/foxy_loading_indicator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Foxy dialog entry point: uniform sizing, project-wide behaviors, and
/// singleton dialog service.
///
/// Static members are the shared dialog toolkit ([constraints], [show]);
/// instance members are the dialog service ([alert], [confirm], [error]...).
class DialogUtil {
  static final instance = DialogUtil._();

  /// Uniform dialog max width (consistent across the project).
  static const width = 720.0;

  /// Dialog max height = screen height × this ratio.
  static const maxHeightRatio = 0.8;

  /// Uniform dialog constraints: maxWidth fixed to [width], maxHeight by
  /// screen ratio.
  ///
  /// Every business dialog's [ShadDialog.constraints] should use this
  /// function, keeping width and max height consistent project-wide.
  static BoxConstraints constraints(BuildContext context) {
    return BoxConstraints(
      maxWidth: width,
      maxHeight: MediaQuery.of(context).size.height * maxHeightRatio,
    );
  }

  /// Shows a dialog, wrapping [showShadDialog] with the project's default
  /// behavior.
  ///
  /// ## Differences from [showShadDialog]
  /// - **`opaque` defaults to `false`**: keeps the page below visible, the
  ///   barrier being a mere translucent overlay. `shadcn_ui` 0.55+ changed
  ///   the default to `true`, which stops the whole background from drawing
  ///   — looking like "black screen + dialog only".
  ///
  /// Business code should call this function instead of [showShadDialog]
  /// directly.
  static Future<T?> show<T>({
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

  DialogUtil._();

  /// Shows a blocking notice dialog; returns after the user clicks "OK".
  ///
  /// Does not implicitly pop the stack top; callers should close temporary
  /// dialogs such as loading first.
  Future<void> alert({required String title, required String message}) async {
    final context = FoxyRouter.router.navigatorKey.currentContext!;
    if (!context.mounted) return;

    await show<void>(
      context: context,
      builder: (context) {
        return ShadDialog.alert(
          title: Text(title),
          description: Text(message),
          constraints: constraints(context),
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
    final context = FoxyRouter.router.navigatorKey.currentContext!;
    final result = await show<bool>(
      context: context,
      builder: (context) {
        return ShadDialog.alert(
          title: Text(title),
          description: description != null ? Text(description) : null,
          constraints: constraints(context),
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
    await Navigator.maybePop(FoxyRouter.router.navigatorKey.currentContext!);
  }

  void error(String error) {
    final context = FoxyRouter.router.navigatorKey.currentContext!;
    if (!context.mounted) return;

    // Do not implicitly pop the stack top: if callers stacked dialogs such
    // as loading, they should dismiss explicitly first, so a real page is
    // never popped by accident (historically an unconditional pop flung the
    // list page out).
    show(
      context: context,
      builder: (context) {
        return ShadDialog.alert(
          title: Text('错误'),
          description: Text(error),
          constraints: constraints(context),
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
    final context = FoxyRouter.router.navigatorKey.currentContext!;
    show(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const ShadDialog(
          closeIcon: SizedBox.shrink(),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: FoxyLoadingIndicator(size: 28, strokeWidth: 3),
          ),
        );
      },
    );
  }

  void success(String message) {
    final context = FoxyRouter.router.navigatorKey.currentContext!;
    ShadSonner.of(context).show(ShadToast(description: Text(message)));
  }
}
