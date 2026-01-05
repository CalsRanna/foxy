import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FoxyApp extends StatelessWidget {
  const FoxyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var shadSonnerTheme = ShadSonnerTheme(alignment: Alignment.topCenter);
    return ShadApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router.config(),
      theme: ShadThemeData(sonnerTheme: shadSonnerTheme),
    );
  }
}
