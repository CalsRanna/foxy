import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'vehicle_repository.g.dart';

@FoxyRepository(VehicleEntity)
@FoxyFilter.text('id')
class VehicleRepository with RepositoryMixin, _VehicleRepositoryMixin {
  static const _table = 'foxy.dbc_vehicle';

  Future<int> copyVehicle(int key) async {
    final source = await getVehicle(key);
    if (source == null) {
      throw StateError('原载具不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeVehicle(copied);
    return copied.id;
  }

  Future<int> countVehicles({VehicleFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<VehicleEntity> createVehicle() async {
    return VehicleEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefVehicleEntity>> getBriefVehicles({
    int page = 1,
    VehicleFilter? filter,
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

  QueryBuilder _applyFilter(QueryBuilder builder, VehicleFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
