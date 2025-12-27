import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BootstrapSimulatorForm extends StatelessWidget {
  final void Function()? onConnect;
  final TextEditingController hostController;
  final TextEditingController portController;
  final TextEditingController databaseController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const BootstrapSimulatorForm({
    super.key,
    this.onConnect,
    required this.hostController,
    required this.portController,
    required this.databaseController,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Text(
            'Welcome to Foxy',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
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
          ShadButton(
            width: double.infinity,
            onPressed: onConnect,
            child: Text('Connect'),
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
    return ShadInput(
      controller: controller,
      placeholder: Text(hintText),
      obscureText: obscureText,
    );
  }
}
