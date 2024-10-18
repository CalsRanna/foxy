import 'package:foxy/provider/setting.dart';
import 'package:foxy/service/application.dart';
import 'package:foxy/service/service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading.g.dart';

@riverpod
class LoadingLogsNotifier extends _$LoadingLogsNotifier {
  @override
  List<String> build() {
    return [];
  }

  Future<void> connectMysql() async {
    state = [...state, '加载数据库连接信息...'];
    final settingProvider = settingNotifierProvider;
    final setting = await ref.read(settingProvider.future);
    state = [...state, '连接到数据库...'];
    await ServiceInitializer.ensureInitialized(setting);
    try {
      await ApplicationService().getMysqlVersion();
      state = [...state, '数据库连接成功'];
    } catch (error) {
      state = [...state, '数据库连接失败', error.toString()];
      await Future.delayed(const Duration(milliseconds: 300));
      rethrow;
    }
    // If loading complete too soon, the window will not be resized correctly.
    await Future.delayed(const Duration(milliseconds: 300));
  }

  void end() {
    state = [...state, '加载完成'];
  }

  void start() {
    state = [...state, '开始加载'];
  }

  Future<bool> validateMysql() async {
    final settingProvider = settingNotifierProvider;
    final setting = await ref.read(settingProvider.future);
    await ServiceInitializer.ensureInitialized(setting);
    try {
      await ApplicationService().getMysqlVersion();
      return true;
    } catch (error) {
      return false;
    }
  }
}
