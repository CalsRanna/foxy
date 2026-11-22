import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

/// Reports failures from operations that handle exceptions in the view model.
/// Each signal change is handled once, independently of widget rebuilds.
mixin DialogErrorState<T extends StatefulWidget> on State<T> {
  late final void Function() _unsubscribeError;

  ReadonlySignal<String?> get dialogError;

  bool get showInitialDialogError => false;

  @override
  void dispose() {
    _unsubscribeError();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var first = true;
    _unsubscribeError = dialogError.subscribe((message) {
      final show = !first || showInitialDialogError;
      first = false;
      if (!show || message == null) return;
      final binding = WidgetsBinding.instance;
      binding.addPostFrameCallback((_) {
        if (mounted) DialogUtil.instance.error(message);
      });
      binding.ensureVisualUpdate();
    });
  }
}

/// Foxy dialog entry point: uniform sizing, project-wide behaviors, and
/// singleton dialog service.
///
/// Static members are the shared dialog toolkit ([constraints], [show]);
/// instance members are the dialog service ([alert], [confirm], [error]...).
class DialogUtil {
  static final instance = DialogUtil._();

  /// Default maximum width for business dialogs.
  static const width = 720.0;

  static const _compactWidth = 480.0;

  /// Dialog max height = screen height × this ratio.
  static const maxHeightRatio = 0.8;

  final _errors = Queue<String>();

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
          constraints: compactConstraints(context),
          actionsMainAxisSize: MainAxisSize.max,
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
    _errors.addLast(error);
    if (_errors.length == 1) unawaited(_showErrors());
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

  Future<void> _showErrors() async {
    while (_errors.isNotEmpty) {
      final error = _errors.first;
      final context = FoxyRouter.router.navigatorKey.currentContext;
      try {
        if (context == null || !context.mounted) continue;
        await show<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => errorDialog(context, error),
        );
      } finally {
        _errors.removeFirst();
      }
    }
  }

  /// Fixed width for dialogs that use the compact layout.
  static BoxConstraints compactConstraints(BuildContext context) {
    return constraints(context)
        .copyWith(minWidth: _compactWidth, maxWidth: _compactWidth);
  }

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

  /// Renders the standard blocking error in an existing dialog route.
  static Widget errorDialog(
    BuildContext context,
    String message, {
    VoidCallback? onRetry,
  }) {
    return PopScope(
      canPop: false,
      child: ShadDialog.alert(
        title: const Text('错误'),
        description: Text(message),
        closeIcon: const SizedBox.shrink(),
        constraints: compactConstraints(context),
        actionsMainAxisSize: MainAxisSize.max,
        actions: [
          if (onRetry != null)
            ShadButton.outline(onPressed: onRetry, child: const Text('重试')),
          ShadButton(
            child: const Text('确定'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
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
}
