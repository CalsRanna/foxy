import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/setting.dart';
import 'package:foxy/schema/setting.dart';
import 'package:foxy/widget/input.dart';

@RoutePage()
class BasicSettingPage extends ConsumerStatefulWidget {
  const BasicSettingPage({super.key});

  @override
  ConsumerState<BasicSettingPage> createState() => _BasicSettingPageState();
}

class _BasicSettingPageState extends ConsumerState<BasicSettingPage> {
  final hostController = TextEditingController();
  final portController = TextEditingController();
  final databaseController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(settingNotifierProvider);
    return switch (provider) {
      AsyncData(:final value) => _buildData(value),
      AsyncLoading() => CircularProgressIndicator(),
      AsyncError(:final error) => Text(error.toString()),
      _ => const SizedBox(),
    };
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void storeSetting(Setting setting) async {
    final notifier = ref.read(settingNotifierProvider.notifier);
    await notifier.store(setting);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('保存成功')),
    );
  }

  Widget _buildData(Setting setting) {
    _initControllers(setting);
    const textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    final button = FilledButton(
      onPressed: () => storeSetting(setting),
      child: const Text('保存'),
    );
    final children = [
      const Text('基本设置', style: textStyle),
      const SizedBox(height: 16),
      const Text('地址'),
      const SizedBox(height: 8),
      FoxyInput(controller: hostController),
      const SizedBox(height: 16),
      const Text('端口'),
      const SizedBox(height: 8),
      FoxyInput(controller: portController),
      const SizedBox(height: 16),
      const Text('用户名'),
      const SizedBox(height: 8),
      FoxyInput(controller: usernameController),
      const SizedBox(height: 16),
      const Text('密码'),
      const SizedBox(height: 8),
      FoxyInput(controller: passwordController),
      const SizedBox(height: 16),
      const Text('数据库'),
      const SizedBox(height: 8),
      FoxyInput(controller: databaseController),
      const SizedBox(height: 16),
      button
    ];
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  void _disposeControllers() {
    hostController.dispose();
    portController.dispose();
    databaseController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void _initControllers(Setting setting) {
    hostController.text = setting.host;
    portController.text = setting.port.toString();
    databaseController.text = setting.database;
    usernameController.text = setting.username;
    passwordController.text = setting.password;
  }
}
