import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class VehicleRepository with RepositoryMixin {
  // DBC 表在 foxy 数据库中
  static const _table = 'foxy.dbc_vehicle';

  Future<int> countVehicles({String? id}) async {
    var builder = laconic.table(_table);
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ID', id);
    }
    return await builder.count();
  }

  Future<List<VehicleEntity>> getVehicles({String? id, int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ID', id);
    }
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => VehicleEntity.fromJson(e.toMap())).toList();
  }

  Future<VehicleEntity?> getVehicle(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return VehicleEntity.fromJson(result.toMap());
  }
}
