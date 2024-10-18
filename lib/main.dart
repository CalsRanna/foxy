import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/schema/isar.dart';
import 'package:foxy/router/router.dart';
import 'package:get_it/get_it.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  const options = WindowOptions(
    backgroundColor: Colors.transparent,
    center: true,
    minimumSize: Size(1200, 900),
    size: Size(400, 300),
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  await IsarInitializer.ensureInitialized();
  GetIt.instance.registerSingleton(AppRouter());
  runApp(const ProviderScope(child: Foxy()));
}

class Foxy extends StatelessWidget {
  const Foxy({super.key});

  @override
  Widget build(BuildContext context) {
    final cardTheme = CardTheme(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.25),
    );
    final themeData = ThemeData(
      cardTheme: cardTheme,
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xfffa7e23)),
      fontFamily: 'Microsoft YaHei',
      useMaterial3: true,
    );
    final router = GetIt.instance.get<AppRouter>();
    return MaterialApp.router(theme: themeData, routerConfig: router.config());
  }
}
