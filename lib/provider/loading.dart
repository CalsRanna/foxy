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
    await Future.delayed(const Duration(seconds: 5));
    state = [...state, '加载完成'];
  }
}
