import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';
import 'package:get_it/get_it.dart';

class DialogUtil {
  static final DialogUtil instance = DialogUtil._();

  DialogUtil._();

  void dismiss() {
    var router = GetIt.instance.get<FoxyRouter>();
    Navigator.maybePop(router.navigatorKey.currentContext!);
  }

  void loading() {
    var router = GetIt.instance.get<FoxyRouter>();
    showDialog(
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
      context: router.navigatorKey.currentContext!,
    );
  }
}
