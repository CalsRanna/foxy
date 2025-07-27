import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BootstrapSimulatorForm extends StatelessWidget {
  final VoidCallback? onBack;
  final TextEditingController nameController;
  final TextEditingController hostController;
  final TextEditingController portController;
  final TextEditingController databaseController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const BootstrapSimulatorForm({
    super.key,
    this.onBack,
    required this.nameController,
    required this.hostController,
    required this.portController,
    required this.databaseController,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Row(
            spacing: 16,
            children: [
              IconButton(
                onPressed: onBack,
                icon: Icon(HugeIcons.strokeRoundedArrowLeft02),
              ),
              Text(
                'Welcome to Foxy',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              _buildInput(context, nameController, 'Simulator Name(Optional)'),
              Row(
                spacing: 16,
                children: [
                  Expanded(child: _buildInput(context, hostController, 'Host')),
                  SizedBox(
                    width: 160,
                    child: _buildInput(
                      context,
                      portController,
                      'Port(Optional)',
                    ),
                  ),
                ],
              ),
              _buildInput(context, databaseController, 'Database'),
              _buildInput(context, usernameController, 'Username'),
              _buildInput(
                context,
                passwordController,
                'Password',
                obscureText: true,
              ),
            ],
          ),
          FilledButton.tonal(
            onPressed: () {},
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Login'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(
    BuildContext context,
    TextEditingController controller,
    String hintText, {
    bool obscureText = false,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    var outline = colorScheme.outline;
    const edgeInsets = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    var textField = TextField(
      controller: controller,
      decoration: InputDecoration.collapsed(hintText: hintText),
      obscureText: obscureText,
    );
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: outline.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: edgeInsets,
      child: textField,
    );
  }
}
