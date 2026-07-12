import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    final result = await showShadDialog<bool>(
      opaque: false,
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

    await showShadDialog<void>(
      opaque: false,
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

    showShadDialog(
      opaque: false,
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
    showShadDialog(
      opaque: false,
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
