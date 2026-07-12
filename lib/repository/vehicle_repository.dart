import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/entity/vehicle_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class VehicleRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_vehicle';

  Future<List<BriefVehicleEntity>> getBriefVehicles({
    int page = 1,
    VehicleFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Flags', 'TurnSpeed']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefVehicleEntity.fromJson(e.toMap())).toList();
  }

  Future<List<VehicleEntity>> getVehicles() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => VehicleEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countVehicles({VehicleFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<VehicleEntity?> getVehicle(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return VehicleEntity.fromJson(results.first.toMap());
  }

  Future<VehicleEntity> createVehicle() async {
    return const VehicleEntity();
  }

  Future<int> storeVehicle(VehicleEntity vehicle) async {
    var json = vehicle.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateVehicle(VehicleEntity vehicle) async {
    var json = vehicle.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', vehicle.id).update(json);
  }

  Future<void> destroyVehicle(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyVehicle(int id) async {
    var source = await getVehicle(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveVehicle(VehicleEntity vehicle) async {
    if (vehicle.id == 0) {
      await storeVehicle(vehicle);
      return;
    }
    var existing = await getVehicle(vehicle.id);
    if (existing != null) {
      await updateVehicle(vehicle);
    } else {
      await laconic.table(_table).insert([vehicle.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(QueryBuilder builder, VehicleFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
