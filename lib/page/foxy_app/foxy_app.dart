import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';

class FoxyApp extends StatelessWidget {
  const FoxyApp({super.key});

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router.config(),
      theme: themeData,
    );
  }
}
