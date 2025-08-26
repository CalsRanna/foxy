import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return _buildData();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  Widget _buildData() {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    final button = FilledButton(onPressed: () {}, child: const Text('保存'));
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
      button,
    ];
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    var constrainedBox = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: column,
    );
    return Align(alignment: Alignment.centerLeft, child: constrainedBox);
  }

  void _disposeControllers() {
    hostController.dispose();
    portController.dispose();
    databaseController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
