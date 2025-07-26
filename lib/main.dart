import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/di.dart';
import 'package:foxy/schema/isar.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/util/window_initializer.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowInitializer.ensureInitialized();
  await IsarInitializer.ensureInitialized();
  GetIt.instance.registerSingleton(FoxyRouter());
  DI.ensureInitialized();
  runApp(const ProviderScope(child: Foxy()));
}

class Foxy extends StatelessWidget {
  const Foxy({super.key});

  @override
  Widget build(BuildContext context) {
    final cardTheme = CardThemeData(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shadowColor: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.25),
    );
    var colorScheme = ColorScheme.fromSeed(seedColor: Color(0xff1677b3));
    final themeData = ThemeData(
      cardTheme: cardTheme,
      colorScheme: colorScheme,
      fontFamily: 'Microsoft YaHei',
      useMaterial3: true,
    );
    final router = GetIt.instance.get<FoxyRouter>();
    return MaterialApp.router(theme: themeData, routerConfig: router.config());
  }
}
