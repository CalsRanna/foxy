import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/schema/isar.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/util/window_initializer.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowInitializer.ensureInitialized();
  await IsarInitializer.ensureInitialized();
  GetIt.instance.registerSingleton(AppRouter());
  if (Platform.isAndroid || Platform.isIOS) {
    var orientations = [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ];
    SystemChrome.setPreferredOrientations(orientations);
  }
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
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff1677b3)),
      fontFamily: 'Microsoft YaHei',
      useMaterial3: true,
    );
    final router = GetIt.instance.get<AppRouter>();
    return MaterialApp.router(theme: themeData, routerConfig: router.config());
  }
}
