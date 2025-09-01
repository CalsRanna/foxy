import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';

class DialogUtil {
  static final DialogUtil instance = DialogUtil._();

  DialogUtil._();

  void dismiss() {
    Navigator.maybePop(router.navigatorKey.currentContext!);
  }

  void loading() {
    showDialog(
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
      context: router.navigatorKey.currentContext!,
    );
  }

  void error(String error) {
    showDialog(
      context: router.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(title: Text(error));
      },
    );
  }
}
