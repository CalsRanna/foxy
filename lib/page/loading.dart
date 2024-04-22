import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/loading.dart';
import 'package:foxy/router/router.dart';
import 'package:window_manager/window_manager.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      ref.listen(loadingLogsNotifierProvider, (previous, next) async {
        if (next.last == '加载完成') {
          await Future.delayed(const Duration(seconds: 1));
          if (!context.mounted) return;
          windowManager.maximize();
          windowManager.setTitleBarStyle(TitleBarStyle.normal);
          windowManager.setResizable(false);
          windowManager.setMaximizable(false);
          const DashboardRoute().go(context);
        }
      });
      final logs = ref.watch(loadingLogsNotifierProvider);
      return ListView.builder(
        itemBuilder: (context, index) {
          return Text(logs[index]);
        },
        itemCount: logs.length,
      );
    }));
  }
}
