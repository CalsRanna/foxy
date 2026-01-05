import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/widget/input.dart';

@RoutePage()
class DatabaseSettingPage extends StatefulWidget {
  const DatabaseSettingPage({super.key});

  @override
  State<DatabaseSettingPage> createState() => _DatabaseSettingPageState();
}

class _DatabaseSettingPageState extends State<DatabaseSettingPage> {
  final hostController = TextEditingController();
  final portController = TextEditingController();
  final databaseController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('数据库设置'),
            const SizedBox(height: 24),
            _buildFormField('地址', hostController),
            const SizedBox(height: 16),
            _buildFormField('端口', portController),
            const SizedBox(height: 16),
            _buildFormField('用户名', usernameController),
            const SizedBox(height: 16),
            _buildFormField('密码', passwordController),
            const SizedBox(height: 16),
            _buildFormField('数据库', databaseController),
            const SizedBox(height: 24),
            FilledButton(onPressed: _handleSave, child: const Text('保存')),
          ],
        ),
      ),
    );
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

  Widget _buildFormField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        FoxyInput(controller: controller),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  void _handleSave() {
    // TODO: Implement save functionality
  }
}
