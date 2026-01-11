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
            ShadButton.destructive(
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

  void error(String error) {
    final context = router.navigatorKey.currentContext!;
    if (!context.mounted) return;

    // 先关闭所有现有对话框
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    // 然后显示错误对话框
    showShadDialog(
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
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const ShadDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('连接中...'),
            ],
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
    ShadSonner.of(context).show(ShadToast(title: Text(message)));
  }
}
