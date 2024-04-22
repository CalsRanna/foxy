import 'package:foxy/model/frequent_module.dart';
import 'package:foxy/service/frequent_module.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'frequent_module.g.dart';

@riverpod
class FrequentModulesNotifier extends _$FrequentModulesNotifier {
  @override
  Future<List<FrequentModule>> build() async {
    final service = FrequentModuleService();
    await service.init();
    return await FrequentModuleService().getFrequentModules();
  }
}
