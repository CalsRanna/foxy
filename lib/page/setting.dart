import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/database/setting.dart';
import 'package:foxy/provider/setting.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/input.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return FoxyCard(
      child: Expanded(
        child: Row(
          children: [
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  ListTile(
                    onTap: () => handleTap(0),
                    selected: index == 0,
                    title: const Text('基本设置'),
                  ),
                  ListTile(
                    onTap: () => handleTap(1),
                    selected: index == 1,
                    title: const Text('软件设置'),
                  ),
                  ListTile(
                    onTap: () => handleTap(2),
                    selected: index == 2,
                    title: const Text('更新日志'),
                  ),
                ],
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            const SizedBox(width: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Consumer(builder: (context, ref, child) {
                final provider = ref.watch(settingNotifierProvider);
                return switch (provider) {
                  AsyncData(:final value) => _BasicSetting(
                      onPressed: (setting) => storeSetting(ref, setting),
                      setting: value,
                    ),
                  _ => const SizedBox(),
                };
              }),
            ),
          ],
        ),
      ),
    );
  }

  void handleTap(int value) {
    setState(() {
      index = value;
    });
  }

  void storeSetting(WidgetRef ref, Setting setting) async {
    final notifier = ref.read(settingNotifierProvider.notifier);
    await notifier.store(setting);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('保存成功')),
    );
  }
}

class _BasicSetting extends StatefulWidget {
  const _BasicSetting({super.key, required this.setting, this.onPressed});

  final Setting setting;
  final void Function(Setting)? onPressed;

  @override
  State<_BasicSetting> createState() => __BasicSettingState();
}

class __BasicSettingState extends State<_BasicSetting> {
  late TextEditingController hostController;
  late TextEditingController portController;
  late TextEditingController databaseController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    hostController = TextEditingController(text: widget.setting.host);
    portController =
        TextEditingController(text: widget.setting.port.toString());
    databaseController = TextEditingController(text: widget.setting.database);
    usernameController = TextEditingController(text: widget.setting.username);
    passwordController = TextEditingController(text: widget.setting.password);
  }

  @override
  void dispose() {
    hostController.dispose();
    portController.dispose();
    databaseController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          '基本设置',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        const Text('连接地址'),
        const SizedBox(height: 8),
        FoxyInput(controller: hostController),
        const SizedBox(height: 16),
        const Text('端口'),
        const SizedBox(height: 8),
        FoxyInput(controller: portController),
        const SizedBox(height: 16),
        const Text('数据库名称'),
        const SizedBox(height: 8),
        FoxyInput(controller: databaseController),
        const SizedBox(height: 16),
        const Text('用户名'),
        const SizedBox(height: 8),
        FoxyInput(controller: usernameController),
        const SizedBox(height: 16),
        const Text('密码'),
        const SizedBox(height: 8),
        FoxyInput(controller: passwordController),
        const SizedBox(height: 16),
        UnconstrainedBox(
          alignment: Alignment.centerLeft,
          child: FilledButton(
            onPressed: handlePressed,
            child: const Text('保存'),
          ),
        )
      ],
    );
  }

  void handlePressed() {
    final setting = Setting();
    setting.host = hostController.text;
    setting.port = int.parse(portController.text);
    setting.database = databaseController.text;
    setting.username = usernameController.text;
    setting.password = passwordController.text;
    widget.onPressed?.call(setting);
  }
}
