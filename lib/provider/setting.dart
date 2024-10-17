import 'package:foxy/schema/isar.dart';
import 'package:foxy/schema/setting.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting.g.dart';

@riverpod
class SettingNotifier extends _$SettingNotifier {
  @override
  Future<Setting> build() async {
    final settings = await isar.settings.where().findAll();
    if (settings.isEmpty) return Setting();
    return settings.first;
  }

  Future<void> store(Setting setting) async {
    final previousState = await future;
    setting.id = previousState.id;
    await isar.writeTxn(() async {
      await isar.settings.put(setting);
    });
    ref.invalidateSelf();
  }
}
