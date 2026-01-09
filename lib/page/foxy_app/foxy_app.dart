import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FoxyApp extends StatelessWidget {
  const FoxyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var shadSonnerTheme = ShadSonnerTheme(alignment: Alignment.topCenter);
    var family = Platform.isWindows ? 'Microsoft YaHei' : null;
    var shadTextTheme = ShadTextTheme(family: family);
    var shadThemeData = ShadThemeData(
      sonnerTheme: shadSonnerTheme,
      textTheme: shadTextTheme,
    );
    return ShadApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router.config(),
      theme: shadThemeData,
    );
  }
}
