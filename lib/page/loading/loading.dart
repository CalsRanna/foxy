import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/loading.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:window_manager/window_manager.dart';

@RoutePage()
class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  @override
  ConsumerState<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> with WindowListener {
  @override
  void onWindowFocus() {
    setState(() {});
    super.onWindowFocus();
  }

  @override
  Widget build(BuildContext context) {
    final logs = ref.watch(loadingLogsNotifierProvider);
    var image = Image.asset(
      'asset/image/background.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
    var listView = ListView.builder(
      itemBuilder: (context, index) => _itemBuilder(logs, index),
      itemCount: logs.length,
      padding: EdgeInsets.all(16),
      reverse: true,
    );
    var positioned = Positioned(
      left: 0,
      right: 200,
      height: 300,
      child: listView,
    );
    return Scaffold(body: Stack(children: [image, positioned]));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    final provider = loadingLogsNotifierProvider;
    final notifier = ref.read(provider.notifier);
    try {
      notifier.start();
      await notifier.connectMysql();
      notifier.end();
      if (!mounted) return;
      _navigateDashboard();
    } catch (error) {
      _navigateInitializer();
    }
  }

  Widget _itemBuilder(List<String> logs, int index) {
    var textStyle = TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontSize: 12,
    );
    return Text(logs.reversed.elementAt(index), style: textStyle);
  }

  Future<void> _navigateDashboard() async {
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

  Future<void> _navigateInitializer() async {
    await windowManager.setOpacity(0);
    await Future.wait([
      windowManager.setSize(Size(600, 450)),
      windowManager.center(),
    ]);
    if (!mounted) return;
    AutoRouter.of(context).replaceAll([InitializerRoute()]);
    Future.delayed(const Duration(milliseconds: 300));
    await windowManager.setOpacity(1);
  }
}
