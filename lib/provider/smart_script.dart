import 'package:foxy/model/smart_script.dart';
import 'package:foxy/service/smart_script.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'smart_script.g.dart';

@Riverpod(keepAlive: true)
Future<int> smartScriptTotal(SmartScriptTotalRef ref) {
  return SmartScriptService().count();
}

@Riverpod(keepAlive: true)
class SmartScriptsNotifier extends _$SmartScriptsNotifier {
  @override
  Future<List<SmartScript>> build() async {
    return SmartScriptService().search();
  }

  Future<void> paginate(int page) async {
    final templates = await SmartScriptService().search(page: page);
    state = AsyncData(templates);
  }

  Future<void> reset() async {
    ref.invalidateSelf();
    await future;
  }
}
