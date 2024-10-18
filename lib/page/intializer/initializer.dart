import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/loading.dart';
import 'package:foxy/provider/setting.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/schema/setting.dart';
import 'package:foxy/widget/input.dart';
import 'package:window_manager/window_manager.dart';

@RoutePage()
class InitializerPage extends ConsumerStatefulWidget {
  const InitializerPage({super.key});

  @override
  ConsumerState<InitializerPage> createState() => _InitializerPage();
}

class _InitializerPage extends ConsumerState<InitializerPage> {
  final hostController = TextEditingController();
  final portController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final databaseController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final provider = settingNotifierProvider;
    final state = ref.watch(provider);
    return switch (state) {
      AsyncData(:final value) => _buildData(value),
      AsyncLoading() => CircularProgressIndicator.adaptive(),
      AsyncError(:final error) => Text(error.toString()),
      _ => const SizedBox(),
    };
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  Future<void> handlePressed() async {
    setState(() {
      loading = true;
    });
    final setting = _getSetting();
    await _storeSetting(setting);
    try {
      await _validateMysql();
      _navigateDashboard();
    } catch (error) {
      _showError(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  Widget _buildData(Setting setting) {
    var textStyle = TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    var hostInput = FoxyInput(controller: hostController, placeholder: 'Host');
    var portInput = FoxyInput(controller: portController, placeholder: 'Port');
    var connectionChildren = [
      Expanded(flex: 2, child: hostInput),
      const SizedBox(width: 16),
      Expanded(child: portInput),
    ];
    var buttonChildren = [
      FilledButton(onPressed: handlePressed, child: const Text('Next')),
      const SizedBox(width: 16),
      if (loading) CircularProgressIndicator()
    ];
    var children = [
      Text('Mysql connection config', style: textStyle),
      SizedBox(height: 32),
      Row(children: connectionChildren),
      SizedBox(height: 16),
      FoxyInput(controller: userController, placeholder: 'User'),
      SizedBox(height: 16),
      FoxyInput(controller: passwordController, placeholder: 'Password'),
      SizedBox(height: 16),
      FoxyInput(controller: databaseController, placeholder: 'Database'),
      const SizedBox(height: 32),
      Row(children: buttonChildren),
    ];
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
    const edgeInsets = EdgeInsets.symmetric(horizontal: 80);
    return Scaffold(body: Padding(padding: edgeInsets, child: column));
  }

  void _disposeControllers() {
    hostController.dispose();
    portController.dispose();
    userController.dispose();
    passwordController.dispose();
    databaseController.dispose();
  }

  Setting _getSetting() {
    final host = hostController.text;
    final port = int.parse(portController.text);
    final user = userController.text;
    final password = passwordController.text;
    final database = databaseController.text;
    return Setting()
      ..host = host
      ..port = port
      ..username = user
      ..password = password
      ..database = database;
  }

  Future<void> _initControllers() async {
    final provider = settingNotifierProvider;
    final setting = await ref.read(provider.future);
    hostController.text = setting.host;
    portController.text = setting.port.toString();
    userController.text = setting.username;
    passwordController.text = setting.password;
    databaseController.text = setting.database;
  }

  Future<void> _navigateDashboard() async {
    setState(() {
      loading = false;
    });
    await windowManager.setOpacity(0);
    await Future.wait([
      windowManager.setSize(Size(1200, 900)),
      windowManager.center(),
    ]);
    if (!mounted) return;
    AutoRouter.of(context).replaceAll([DashboardRoute()]);
    Future.delayed(const Duration(milliseconds: 300));
    await windowManager.setOpacity(1);
  }

  void _showError(String error) {
    setState(() {
      loading = false;
    });
    var dialog = AlertDialog(
      content: Text(error),
      title: Text('Mysql Connection Error'),
    );
    showDialog(context: context, builder: (_) => dialog);
  }

  Future<void> _storeSetting(Setting setting) async {
    final provider = settingNotifierProvider;
    final notifier = ref.read(provider.notifier);
    await notifier.store(setting);
  }

  Future<bool> _validateMysql() async {
    final provider = loadingLogsNotifierProvider;
    final notifier = ref.read(provider.notifier);
    return await notifier.validateMysql();
  }
}
