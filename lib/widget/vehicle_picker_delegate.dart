import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final vehiclePickerDelegate = EntityPickerDelegate<VehicleEntity>(
  title: '载具',
  errorLabel: '搜索载具失败',
  filters: const [EntityPickerFilter('载具ID')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (VehicleEntity t) => t.id.toString()),
    EntityPickerColumn(header: '标识', width: 120, text: (VehicleEntity t) => t.flags.toString()),
    EntityPickerColumn(header: '转向速度', text: (VehicleEntity t) => t.turnSpeed.toString()),
  ],
  idOf: (VehicleEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<VehicleRepository>()
      .getVehicles(id: v[0].isEmpty ? null : v[0], page: page),
  count: (v) => GetIt.instance.get<VehicleRepository>().countVehicles(id: v[0].isEmpty ? null : v[0]),
);
