import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class BootstrapViewModel {
  final showForm = signal(false);
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
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  void updateShowForm(bool value) {
    showForm.value = value;
  }
}
