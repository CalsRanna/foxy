import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class BootstrapViewModel {
  final version = signal('');

  final nameController = TextEditingController();
  final hostController = TextEditingController();
  final portController = TextEditingController();
  final databaseController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    nameController.dispose();
    hostController.dispose();
    portController.dispose();
    databaseController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<void> initSignals() async {
    hostController.text = '127.0.0.1';
    portController.text = '3306';
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  Future<void> login(BuildContext context) async {
    DialogUtil.instance.loading();
    await Future.delayed(const Duration(seconds: 3));
    DialogUtil.instance.dismiss();
    if (!context.mounted) return;
    AutoRouter.of(context).replaceAll([DashboardRoute()]);
  }
}
