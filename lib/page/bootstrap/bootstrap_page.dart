import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/bootstrap/bootstrap_simulator_form.dart';
import 'package:foxy/page/bootstrap/bootstrap_workflow_view_model.dart';
import 'package:foxy/page/bootstrap/bootstrap_window_header.dart';
import 'package:foxy/page/feature/feature_state_view_model.dart';
import 'package:foxy/page/foxy_app/foxy_state_view_model.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class BootstrapPage extends StatefulWidget {
  const BootstrapPage({super.key});

  @override
  State<BootstrapPage> createState() => _BootstrapPageState();
}

class _BootstrapPageState extends State<BootstrapPage> {
  final viewModel = GetIt.instance.get<BootstrapWorkflowViewModel>();

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
      body: Stack(
        children: [
          Row(children: children),
          BootstrapWindowHeader(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  Future<void> _prepare() async {
    try {
      await viewModel.prepare();
    } catch (_) {
      if (!mounted) return;
      DialogUtil.instance.error(viewModel.errorMessage.value ?? '加载连接配置失败');
    }
  }

  Future<void> _connect() async {
    var loadingShown = false;
    try {
      DialogUtil.instance.loading();
      loadingShown = true;
      await viewModel.start();
      final result = viewModel.result.value;
      if (result == null) {
        throw StateError('数据库启动流程结束但未返回结果');
      }

      GetIt.instance.get<FoxyStateViewModel>().setLocaleSettings(
        hasLocaleTables: result.hasLocaleTables,
        localeEnabled: result.localeEnabled,
      );
      GetIt.instance.get<FeatureStateViewModel>().replaceFeatures(
        result.features,
      );

      await DialogUtil.instance.dismiss();
      loadingShown = false;
      if (!mounted) return;
      if (!result.configSaved) {
        await DialogUtil.instance.alert(
          title: '警告',
          message: '数据库连接成功，但配置文件保存失败。本次可继续使用；下次启动可能需要重新填写连接信息。',
        );
      }
      if (!mounted) return;
      AutoRouter.of(context).replaceAll([const DashboardRoute()]);
    } catch (error) {
      if (loadingShown) {
        await DialogUtil.instance.dismiss();
      }
      if (!mounted) return;
      DialogUtil.instance.error(
        viewModel.errorMessage.value ?? error.toString(),
      );
    }
  }

  Widget _buildCoverPanel() {
    var image = Image.asset(
      'asset/image/background.png',
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
    return Stack(
      children: [
        image,
        Container(decoration: boxDecoration),
      ],
    );
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

  Widget _buildWorkspacePanel() {
    return Watch(
      (_) => BootstrapSimulatorForm(
        key: const ValueKey('form'),
        hostController: viewModel.hostController,
        portController: viewModel.portController,
        databaseController: viewModel.databaseController,
        usernameController: viewModel.usernameController,
        passwordController: viewModel.passwordController,
        onConnect: _connect,
      ),
    );
  }
}
