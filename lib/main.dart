import 'package:flutter/material.dart';
import 'package:foxy/di.dart';
import 'package:foxy/page/foxy_app/foxy_app.dart';
import 'package:foxy/infrastructure/window/window_initializer.dart';
import 'package:signals/signals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowInitializer.ensureInitialized();
  DI.ensureInitialized();
  SignalsObserver.instance = null;
  runApp(FoxyApp());
}
