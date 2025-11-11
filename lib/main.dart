import 'package:flutter/material.dart';
import 'package:foxy/di.dart';
import 'package:foxy/page/foxy_app/foxy_app.dart';
import 'package:foxy/util/window_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowInitializer.ensureInitialized();
  DI.ensureInitialized();
  runApp(FoxyApp());
}
