import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/bootstrap/bootstrap_simulator_form.dart';
import 'package:foxy/page/bootstrap/bootstrap_simulator_list_view.dart';
import 'package:foxy/page/bootstrap/bootstrap_view_model.dart';
import 'package:foxy/page/bootstrap/bootstrap_window_header.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class BootstrapPage extends StatefulWidget {
  const BootstrapPage({super.key});

  @override
  State<BootstrapPage> createState() => _BootstrapPageState();
}

class _BootstrapPageState extends State<BootstrapPage> {
  final viewModel = GetIt.instance.get<BootstrapViewModel>();

  @override
  Widget build(BuildContext context) {
    var stack = Stack(
      children: [_buildInformationPanel(), _buildWorkspacePanel()],
    );
    var children = [
      Expanded(child: _buildCoverPanel()),
      Expanded(child: stack),
    ];
    return Scaffold(
      body: Stack(children: [Row(children: children), BootstrapWindowHeader()]),
    );
  }

  Widget _buildWorkspacePanel() {
    return Watch(
      (_) => AnimatedSwitcher(
        duration: Durations.medium1,
        transitionBuilder:
            (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
        layoutBuilder: (currentChild, previousChildren) => currentChild!,
        child:
            viewModel.showForm.value
                ? BootstrapSimulatorForm(
                  key: const ValueKey('form'),
                  onBack: () => viewModel.updateShowForm(false),
                  nameController: viewModel.nameController,
                  hostController: viewModel.hostController,
                  portController: viewModel.portController,
                  databaseController: viewModel.databaseController,
                  usernameController: viewModel.usernameController,
                  passwordController: viewModel.passwordController,
                )
                : BootstrapSimulatorListView(
                  key: const ValueKey('list'),
                  onAdd: viewModel.updateShowForm,
                ),
      ),
    );
  }

  Widget _buildCoverPanel() {
    var image = Image.asset(
      'asset/image/background.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
    var linearGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.transparent, Colors.white],
    );
    var boxDecoration = BoxDecoration(gradient: linearGradient);
    return Stack(children: [image, Container(decoration: boxDecoration)]);
  }

  Widget _buildInformationPanel() {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Watch((_) => Text(viewModel.version.value))],
    );
    return Container(
      color: Colors.white,
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: column,
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }
}
