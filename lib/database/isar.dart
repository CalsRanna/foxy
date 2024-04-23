import 'dart:io';

import 'package:foxy/database/setting.dart';
import 'package:isar/isar.dart';

late Isar isar;

class IsarInitializer {
  static Future<void> ensureInitialized() async {
    final directory = Directory.current;
    isar = await Isar.open([SettingSchema], directory: directory.path);
  }
}
