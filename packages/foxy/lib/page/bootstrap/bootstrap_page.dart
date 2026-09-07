import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/cover/cover_selector.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/page/bootstrap/bootstrap_simulator_form.dart';
import 'package:foxy/page/bootstrap/bootstrap_window_header.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/view_model/bootstrap_workflow_view_model.dart';
import 'package:foxy/view_model/feature_state_view_model.dart';
import 'package:foxy/view_model/foxy_state_view_model.dart';
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

  /// User-chosen cover image, picked once when the page opens; null falls
  /// back to the built-in asset.
  File? _coverFile;

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
    try {
      final coverDir = Directory(CoverSelector.defaultDirPath);
      if (!coverDir.existsSync()) coverDir.createSync(recursive: true);
    } on FileSystemException {
      // Best effort: pick() treats a missing directory as "no candidate".
    }
    _coverFile = CoverSelector.pick(CoverSelector.defaultDirPath);
    LoggerUtil.instance.d(
      _coverFile == null
          ? '封面目录无可用图片,使用内置背景: ${CoverSelector.defaultDirPath}'
          : '封面图片: ${_coverFile!.path}',
    );
    _prepare();
  }

  Widget _buildCoverPanel() {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    var image = _coverFile == null
        ? _buildAssetCover()
        : Image.file(
            _coverFile!,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            // Decode at screen width so arbitrary user images (possibly 4K)
            // do not consume full-resolution memory.
            cacheWidth: MediaQuery.sizeOf(context).width.round(),
            errorBuilder: (context, error, stackTrace) => _buildAssetCover(),
          );
    var linearGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.transparent, surfaceColor],
    );
    var boxDecoration = BoxDecoration(gradient: linearGradient);
    return Stack(
      children: [
        image,
        Container(decoration: boxDecoration),
      ],
    );
  }

  /// Built-in fallback when no user cover is available or decoding fails.
  Widget _buildAssetCover() {
    return Image.asset(
      'asset/image/cover.webp',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget _buildInformationPanel() {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Watch((_) => Text(viewModel.version.value))],
    );
    return Container(
      color: Theme.of(context).colorScheme.surface,
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

  Future<void> _connect() async {
    var loadingShown = false;
    try {
      DialogUtil.instance.loading();
      loadingShown = true;
      await viewModel.start();
      final result = viewModel.result.value;
      if (result == null) {
        throw StateError('database bootstrap flow ended without a result');
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
        viewModel.errorMessage.value ?? FoxyExceptions.message(error),
      );
    }
  }

  Future<void> _prepare() async {
    try {
      await viewModel.prepare();
    } catch (_) {
      if (!mounted) return;
      DialogUtil.instance.error(viewModel.errorMessage.value ?? '加载连接配置失败');
    }
  }
}
