import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:get_it/get_it.dart';

class VehicleSelectorController extends SelectorController<VehicleEntity> {
  final _repository = GetIt.instance.get<VehicleRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索载具失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final result = await _repository.getVehicles(id: id, page: page);
    final count = await _repository.countVehicles(id: id);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
