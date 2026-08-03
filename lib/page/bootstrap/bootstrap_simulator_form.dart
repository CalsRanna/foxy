import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BootstrapSimulatorForm extends StatelessWidget {
  final void Function()? onConnect;
  final StringFieldController hostController;
  final StringFieldController portController;
  final StringFieldController databaseController;
  final StringFieldController usernameController;
  final StringFieldController passwordController;
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
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 640),
        child: Padding(
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
                      Expanded(
                        child: FoxyStringInput(
                          controller: hostController,
                          placeholder: 'Host',
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: FoxyStringInput(
                          controller: portController,
                          placeholder: 'Port(Optional)',
                        ),
                      ),
                    ],
                  ),
                  FoxyStringInput(
                    controller: databaseController,
                    placeholder: 'Database',
                  ),
                  FoxyStringInput(
                    controller: usernameController,
                    placeholder: 'Username',
                  ),
                  FoxyStringInput(
                    controller: passwordController,
                    placeholder: 'Password',
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
        ),
      ),
    );
  }
}
