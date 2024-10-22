import 'dart:io';

import 'package:foxy/schema/setting.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late Isar isar;

class IsarInitializer {
  static Future<void> ensureInitialized() async {
    Directory directory = await getApplicationSupportDirectory();
    isar = await Isar.open([SettingSchema], directory: directory.path);
  }
}
