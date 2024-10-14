import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/loading.dart';
import 'package:foxy/router/router.dart';
import 'package:window_manager/window_manager.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loadingLogsNotifierProvider, (previous, next) async {
      if (next.last == '加载完成') {
        await windowManager.setOpacity(0.0);
        if (!context.mounted) return;
        const DashboardRoute().go(context);
        await windowManager.setSize(const Size(800, 600));
        await windowManager.center();
        await windowManager.setTitleBarStyle(TitleBarStyle.normal);
        await Future.delayed(const Duration(milliseconds: 300));
        await windowManager.setOpacity(1.0);
      }
    });
    final logs = ref.watch(loadingLogsNotifierProvider);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'asset/image/background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Text(
                logs[index],
                style: TextStyle(color: Colors.white),
              );
            },
            itemCount: logs.length,
          ),
        ],
      ),
    );
  }
}
