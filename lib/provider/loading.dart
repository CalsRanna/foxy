import 'package:foxy/service/service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading.g.dart';

@riverpod
class LoadingLogsNotifier extends _$LoadingLogsNotifier {
  @override
  List<String> build() {
    loading();
    return ['加载中...'];
  }

  Future<void> loading() async {
    try {
      await ServiceInitializer.ensureInitialized();
      state = [...state, '初始化mysql连接'];
    } on Exception catch (e) {
      state = [...state, e.toString()];
    }
    // If loading complete too soon, the window will not be resized correctly.
    await Future.delayed(const Duration(milliseconds: 300));
    state = [...state, '加载完成'];
  }
}
