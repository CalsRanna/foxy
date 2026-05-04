import 'package:signals/signals.dart';
import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class VehicleSelectorViewModel {
  final _repository = VehicleRepository();

  final idFilter = signal('');
  final items = signal<List<VehicleEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final result = await _repository.getVehicles(id: id, page: page.value);
      final count = await _repository.countVehicles(id: id);
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索载具失败: $e');
      DialogUtil.instance.error('搜索载具失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
