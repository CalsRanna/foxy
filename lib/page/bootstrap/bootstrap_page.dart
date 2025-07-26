import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/page/bootstrap/bootstrap_simulator_tile.dart';
import 'package:foxy/page/bootstrap/bootstrap_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class BootstrapPage extends ConsumerStatefulWidget {
  const BootstrapPage({super.key});

  @override
  ConsumerState<BootstrapPage> createState() => _BootstrapPageState();
}

class _BootstrapPageState extends ConsumerState<BootstrapPage> {
  final viewModel = GetIt.instance.get<BootstrapViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildInformationPanel(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAddSimulatorButton(),
                Watch((_) => _buildForm()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    if (!viewModel.showForm.value) {
      return SizedBox();
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.5),
      ),
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInput(TextEditingController(), 'Host'),
          Divider(height: 1, thickness: 1),
          _buildInput(TextEditingController(), 'Port(Optional)'),
          Divider(height: 1, thickness: 1),
          _buildInput(TextEditingController(), 'Database'),
          Divider(height: 1, thickness: 1),
          _buildInput(TextEditingController(), 'Username'),
          Divider(height: 1, thickness: 1),
          _buildInput(TextEditingController(), 'Password', obscureText: true),
        ],
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String hintText, {
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hintText),
        obscureText: obscureText,
      ),
    );
  }

  Widget _buildInformationPanel() {
    var version = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Text('Foxy'), Watch((_) => Text(viewModel.version.value))],
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 200),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          width: 200,
          child: version,
        ),
      ],
    );
  }

  Widget _buildAddSimulatorButton() {
    return BootstrapSimulatorTile(
      child: Icon(
        HugeIcons.strokeRoundedAdd01,
        color: Theme.of(context).colorScheme.primary,
        size: 32,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }
}
