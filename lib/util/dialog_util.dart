import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Foxy 对话框入口，封装 [showShadDialog] 并固定项目默认行为。
///
/// ## 与 [showShadDialog] 的差异
/// - **`opaque` 默认 `false`**：保留下层页面绘制，蒙层只做半透明遮罩。
///   `shadcn_ui` 0.55+ 将 `opaque` 默认改为 `true`，会导致背景整页不绘制，
///   看起来像「只有黑屏 + 对话框」。
///
/// 业务代码应调用本函数，而不是直接使用 [showShadDialog]。
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
  /// 是否遮挡下层路由。Foxy 默认 `false`（见函数文档）。
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

  /// 显示阻塞式提示对话框，用户点「确定」后返回。
  ///
  /// 不隐式 pop 栈顶；调用方应先自行关闭 loading 等临时对话框。
  Future<void> alert({required String title, required String message}) async {
    final context = router.navigatorKey.currentContext!;
    if (!context.mounted) return;

    await showFoxyDialog<void>(
      context: context,
      builder: (context) {
        return ShadDialog.alert(
          title: Text(title),
          description: Text(message),
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

  void error(String error) {
    final context = router.navigatorKey.currentContext!;
    if (!context.mounted) return;

    // 兼容旧调用：若栈顶是 loading 等可 pop 路由则先关掉。
    // 新代码应显式 dismiss loading 后再调用，避免依赖此隐式副作用。
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    showFoxyDialog(
      context: context,
      builder: (context) {
        return ShadDialog.alert(
          title: Text('错误'),
          description: Text(error),
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

  void dismissAll() {
    final context = router.navigatorKey.currentContext!;
    if (!context.mounted) return;
    // 关闭所有对话框
    while (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void success(String message) {
    final context = router.navigatorKey.currentContext!;
    ShadSonner.of(context).show(ShadToast(description: Text(message)));
  }
}
